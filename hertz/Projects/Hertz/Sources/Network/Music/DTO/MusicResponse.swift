public struct MusicResponse: Decodable {
    let id: Int
    let music: String
    let author: String
    
    public init(id: Int, music: String, author: String) {
        self.id = id
        self.music = music
        self.author = author
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
