public struct EmailCodeRequest: Encodable {
    let to: String
    
    public init(to: String) {
        self.to = to
    }
}
