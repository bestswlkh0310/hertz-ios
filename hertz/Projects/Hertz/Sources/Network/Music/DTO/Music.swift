import Then

public struct Music: Hashable, Then {
    var id: Int
    var music: String
    var author: String
    var image: String
    
    public init(id: Int, music: String, author: String, image: String) {
        self.id = id
        self.music = music
        self.author = author
        self.image = image
    }
}

extension Music {
    public static var stubs: [Music] = Array(repeating: .init(id: .random(in: 0..<1000000), music: "Sea of Orbit", author: "Music Mate", image: "Logo"), count: 20)
}
