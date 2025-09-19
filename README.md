<div align="center">
  <img src="https://github.com/user-attachments/assets/ad6a41fb-a512-440a-8bb2-d51342b8b6f0" alt="Dub.co TypeScript SDK to interact with APIs.">
  <h3>Dub iOS SDK</h3>
</div>

<p align="center">
    Track deep link conversion events in your iOS app
    <br />
    <a href="https://dub.co/docs/concepts/deep-links/attribution"><strong>Learn more »</strong></a>
    <br />
    <br />
    <a href="#compatibility"><strong>Compatibility</strong></a> ·
    <a href="#installation"><strong>Installation</strong></a> ·
    <a href="#development"><strong>Development</strong></a>
</p>

<br/>

<!-- Start Summary [summary] -->
Dub is the modern link attribution platform for short links, conversion tracking, and affiliate programs. 
The Dub iOS SDK is a client side library built in Swift for both UIKit and SwiftUI. 
It enables open tracking for deep links and deferred deep links as well as conversion tracking for sale and lead events.
Learn more about the Dub iOS SDK in the [official documentation](https://dub.co/docs/sdks/ios/overview).
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

### UIKit

The SwiftUI example may be found at `/Examples/UIKit`.

## Development

### Documentation
This project uses the [Swift-DocC Plugin](https://github.com/apple/swift-docc-plugin) to generate SDK docs from code comments. 

To generate documents manually run the following command from the project root:

```bash
swift package --allow-writing-to-directory ./docs generate-documentation --target Dub --output-path ./docs
```
    
To write doc comments, hover over a symbol and press `⌘ + ⌥ + /` (command + option + forward slash).

### Contributions

Feel free to open a PR or a Github issue as a proof of concept and we'll do our best to include it in a future release!
