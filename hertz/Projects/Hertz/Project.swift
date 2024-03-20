import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "Hertz",
    platform: .iOS,
    product: .app,
    dependencies: [
        .external(name: "SnapKit"),
        .external(name: "Then"),
        .external(name: "Moya")
    ],
    resources: ["Resources/**"],
    infoPlist: .file(path: "Support/Info.plist")
)
