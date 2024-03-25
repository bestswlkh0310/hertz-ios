import Moya
import Foundation

public class APIRequestLoader<T: TargetType> {
    private let session = Session(interceptor: AuthInterceptor())
    private let decoder = JSONDecoder()
    
    public func request<D: Decodable>(_ target: T, res: D.Type) async -> NetworkResult<D> {
        do {
            let response = try await target.authorization == .authorization ? request(target, session: session) : request(target)
            return getResult(by: response.statusCode, response.data, type: res)
        } catch {
            return .authFailure
        }
    }
    
    public func requestData(_ target: T) async -> NetworkResult<Data> {
        do {
            let response = try await target.authorization == .authorization ? request(target, session: session) : request(target)
            if 200...299 ~= response.statusCode {
                return NetworkResult.success(response.data)
            }
            return getResult(by: response.statusCode, response.data, type: Data.self)
        } catch {
            return .authFailure
        }
    }
    
    private func getResult<M: Decodable>(by statusCode: Int,
                                         _ data: Data,
                                         type: M.Type) -> NetworkResult<M> {
        switch statusCode {
        case 200...299: decodeData(data: data, type: M.self)
        case 400, 402...499: decodeData(data: data, type: M.self)
        case 500: .serverErr
        case 401: .authFailure
        default: .networkErr
        }
    }
    
    private func decodeData<M: Decodable>(data: Data, type: M.Type) -> NetworkResult<M> {
        
        do {
            let decodedData = try decoder.decode(M.self, from: data)
            return .success(decodedData)
        } catch let DecodingError.dataCorrupted(context) {
            print(context)
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print("error: ", error)
            print(error.localizedDescription)
        }
        guard let decodedData = try? decoder.decode(ErrorResponse.self, from: data) else {
            print("json decoded failed !")
            return .decodingError
        }
        
        return .requestErr(decodedData)
    }
    
    private func decodeError(data: Data) -> NetworkResult<ErrorResponse> {
        guard let decodedData = try? decoder.decode(ErrorResponse.self, from: data) else {
            return .decodingError
        }
        return .requestErr(decodedData)
    }
    
    private func request(_ target: T,
                                        session: Session = MoyaProvider<T>.defaultAlamofireSession()) async throws -> Moya.Response {
        try await withCheckedThrowingContinuation { config in
            MoyaProvider<T>(session: session).request(target, completion: config.resume(with: ))
        }
    }
}
