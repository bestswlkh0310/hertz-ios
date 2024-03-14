struct MusicModel: Hashable {
    var image: String
    var title: String
    var author: String
}

extension MusicModel {
    static var stubs: [MusicModel] = Array(repeating: .init(image: "Logo", title: "Sea of Orbit", author: "Music Mate"), count: 20)
}
