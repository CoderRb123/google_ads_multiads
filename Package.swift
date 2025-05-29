// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "google_ads_multiads",
    products: [
        .library(
            name: "google_ads_multiads",
            targets: ["google_ads_multiads"]),
    ],
    dependencies : [
        .package(name:"MultiAdsInterface",url: "https://github.com/CoderRb123/MultiAdsInterface.git",from: "1.1.7"),
        .package(name:"GoogleMobileAds",url: "https://github.com/googleads/swift-package-manager-google-mobile-ads.git",.upToNextMajor(from: "12.4.0")),
    ],
    targets: [
        .target(
            name: "google_ads_multiads",
            dependencies: [
              "MultiAdsInterface",
              "GoogleMobileAds",
              "AppLovinSDK",
              "MetaAdapter",
              "UnityAdapter"
            ],
            path: "Sources",
        ),
        .binaryTarget(
         name: "AppLovinSDK",
         path: "./Sources/AppLovinSDK.xcframework"
        ),
        .binaryTarget(
         name: "MetaAdapter",
         path: "./Sources/MetaAdapter.xcframework"
        ),
        .binaryTarget(
         name: "UnityAdapter",
         path: "./Sources/UnityAdapter.xcframework"
        ),
    ]
)
