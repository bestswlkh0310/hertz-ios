public struct MusicResponse: Decodable {
    let id: Int
    let music: String
    let author: String
    let isLiked: Bool
    
    public init(id: Int, music: String, author: String, isLiked: Bool) {
        self.id = id
        self.music = music
        self.author = author
        self.isLiked = isLiked
    }
}

extension MusicResponse {
    public func toDomain() -> Music {
        Music(id: id,
              music: music,
              author: author,
              image: "Logo") // TODO: rm dummy
    }
}
