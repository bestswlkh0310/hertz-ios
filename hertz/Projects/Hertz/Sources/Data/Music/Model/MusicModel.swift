struct Music: Hashable {
    var id: Int
    var music: String
    var author: String
    var image: String
}

extension Music {
    static var stubs: [Music] = Array(repeating: .init(id: .random(in: 0..<1000000), music: "Sea of Orbit", author: "Music Mate", image: "Logo"), count: 20)
}
