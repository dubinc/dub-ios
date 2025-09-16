<div align="center">
  <img src="https://github.com/dubinc/dub/assets/28986134/3815d859-afaa-48f9-a9b3-c09964e4d404" alt="Dub.co TypeScript SDK to interact with APIs.">
  <h3>Dub.co iOS SDK</h3>
  <a href="https://speakeasyapi.dev/"><img src="https://custom-icon-badges.demolab.com/badge/-Built%20By%20Speakeasy-212015?style=for-the-badge&logoColor=FBE331&logo=speakeasy&labelColor=545454" /></a>
  <a href="https://opensource.org/licenses/MIT">
    <img src="https://img.shields.io/badge/License-MIT-blue.svg" style="width: 100px; height: 28px;" />
  </a>
</div>

<br/>

<!-- Start Summary [summary] -->
Dub is the modern link attribution platform for short links, conversion tracking, and affiliate programs. 
The Dub iOS SDK is a client side library built in Swift for both UIKit and SwiftUI. 
It enables open tracking for deep links and deferred deep links as well as conversion tracking for sale and lead events.
Learn more about the Dub.co iOS SDK in the [official documentation](https://dub.co/docs/sdks/ios/overview).
<!-- End Summary [summary] -->

<!-- Start Table of Contents [toc] -->
## Table of Contents
<!-- $toc-max-depth=2 -->
  * [Compatibility](#compatibility)
  * [Installation](#Installation)
  * [Usage](#usage)
* [Development](#development)
  * [Documentation](#documentation)
  * [Contributions](#contributions)

<!-- End Table of Contents [toc] -->

Compatibility
-------------------------

### Supported iOS and Xcode versions

The Dub iOS SDK is avilable for iOS and macOS. It requires the following minimum build tool versions:

| Tool  | Version |
| ----- | ------- |
| Xcode | 16+   |
| Swift | 6+    |

And supports the following device platforms:

| Platform | Version            |
| -------- | ------------------ |
| iOS      | 16.0               |
| macOS    | 10.13 (Ventura)    |

If you require additional compatability, [let us know](https://dub.co/contact/support)!


<!-- Start SDK Installation [installation] -->
## Installation

### Swift Package Manager (Recommended)

Option 1: Add the following lines to your `Package.swift` file:

```swift
let package = Package(
    ...
    dependencies: [
        ...
        .package(name: "Dub", url: "https://github.com/dubinc/dub-ios.git", from: "0.1.0"),
    ],
    targets: [
        .target(
            name: "MyApp",
            dependencies: ["Dub"] // Add Dub as a dependency to your app's target
        )
    ]
)
```

Option 2: You may manually install the package by navigating to the `Package Dependencies` section of your Xcode project pressing the `+` and installing `https://github.com/dubinc/dub-ios`.

### Other

If you have additional installation requirements, [let us know](https://dub.co/contact/support)!


<!-- Usage [usage] -->
## Usage

### SwiftUI

The SwiftUI example may be found at `/Examples/SwiftUI`.


# Development

## Documentation
This project uses the [Swift-DocC Plugin](https://github.com/apple/swift-docc-plugin) to generate SDK docs from code comments. 

To generate documents manually run the following command from the project root:

```bash
swift package --allow-writing-to-directory ./docs generate-documentation --target Dub --output-path ./docs
```
    
To write doc comments, hover over a symbol and press `⌘ + ⌥ + /` (command + option + forward slash).

## Contributions

Feel free to open a PR or a Github issue as a proof of concept and we'll do our best to include it in a future release!
