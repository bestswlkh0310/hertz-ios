public enum NetworkResult<T> {
    case success(T)     // 200...299
    case error(ErrorResponse) // // 400...499
    case decodingError // 디코딩 에러
    case serverError  // 500
    case networkError // 네트워크 연결 실패
    case authFailure // 401
}
