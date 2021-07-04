// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "SwiftyMenu",
    platforms: [
        .iOS(.v10),
    ],
    products: [
        .library(
            name: "SwiftyMenu",
            targets: ["SwiftyMenu"]
        ),
    ],
	dependencies: [
		.package(
			url: "https://github.com/SnapKit/SnapKit.git",
			from: "5.0.1"
		)
	],
    targets: [
        .target(
            name: "SwiftyMenu",
			dependencies: ["SnapKit"],
			path: "SwiftyMenu"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
