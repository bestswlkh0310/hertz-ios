import Moya
import Foundation

class HttpClient {
    static let shared = HttpClient()

    func request<T: TargetType, D: Decodable>(_ target: T, res: D.Type) async -> NetworkResult<D> {
        do {
            let session = Session(interceptor: AuthInterceptor.shared)
            let response = try await target.authorization == .authorization ? request(target, session: session) : request(target)
            let statusCode = response.statusCode
            let data = response.data
            let networkRequest = judgeStatus(by: statusCode, data, type: res)
            return networkRequest
        } catch {
            return .networkErr
        }
    }
    
    private func judgeStatus<M: Decodable>(by statusCode: Int, _ data: Data, type: M.Type) -> NetworkResult<M> {
        switch statusCode {
        case 200...299: return isValidData(data: data, type: M.self)
        case 400, 402...499: return isValidData(data: data, type: M.self)
        case 500: return .serverErr
        case 401: return .failure
        default: return .networkErr
        }
    }
    
    private func isValidData<M: Decodable>(data: Data, type: M.Type) -> NetworkResult<M> {
        let decoder = JSONDecoder()
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
            return .pathErr
        }
        
        return .requestErr(decodedData)
    }
    
    private func request<T: TargetType>(_ target: T, 
                                        session: Session = MoyaProvider<T>.defaultAlamofireSession()) async throws -> Moya.Response {
        return try await withCheckedThrowingContinuation { config in
            self.request(target: target, provider: MoyaProvider<T>(session: session), completion: config.resume(with:))
        }
    }
    
    private func request<T: TargetType>(target: T,
                         provider: MoyaProvider<T>,
                         completion: @escaping Moya.Completion) {
        provider.request(target) {
            completion($0)
        }
    }
}
