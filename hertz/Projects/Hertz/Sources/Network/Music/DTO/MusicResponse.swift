struct MusicResponse: Decodable {
    let id: Int
    let music: String
    let author: String
}

extension MusicResponse {
    func toDomain() -> Music {
        Music(id: id,
              music: music,
              author: author,
              image: "Logo") // TODO: rm dummy
    }
}
