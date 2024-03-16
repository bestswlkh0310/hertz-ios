import ProjectDescription

let dependencies = Dependencies(
    carthage: [],
    swiftPackageManager: .init(
        [
            .remote(url: "https://github.com/SnapKit/SnapKit.git", requirement: .upToNextMajor(from: "5.7.1")),
            .remote(url: "https://github.com/devxoul/Then.git", requirement: .upToNextMajor(from: "3.0.0"))
        ]
    ),
    platforms: [.iOS]
)
