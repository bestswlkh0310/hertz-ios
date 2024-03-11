import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "Hertz",
    platform: .iOS,
    product: .app,
    dependencies: [
        
    ],
    resources: ["Resources/**"],
    infoPlist: .file(path: "Support/Info.plist")
)
