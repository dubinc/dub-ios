<div align="center">
  <img src="https://github.com/user-attachments/assets/6b9d2dec-3139-453c-8a2f-cd0bce9a5bf8" alt="Dub.co iOS SDK to track deep links and attribution.">
  <h3>Dub iOS SDK (BETA)</h3>
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

[Dub](http://dub.co/) is the modern link attribution platform for short links, conversion tracking, and affiliate programs.

The Dub iOS SDK is a client side library built in Swift for both UIKit and SwiftUI.

It enables open tracking for regular/[deferred deep links](https://dub.co/docs/concepts/deep-links/deferred-deep-linking) as well as [tracking lead and sale conversion events](https://dub.co/docs/concepts/deep-links/attribution).

Learn more about the Dub iOS SDK in the [official documentation](https://dub.co/docs/sdks/client-side-mobile/installation-guides/swift).

<!-- End Summary [summary] -->

<!-- Start Table of Contents [toc] -->

## Table of Contents

<!-- $toc-max-depth=2 -->

- [Compatibility](#compatibility)
- [Installation](#Installation)
- [Usage](#usage)
- [Development](#development)
  - [Documentation](#documentation)
  - [Contributions](#contributions)

<!-- End Table of Contents [toc] -->

## Compatibility

### Supported iOS and Xcode versions

The Dub iOS SDK is available for iOS and macOS. It requires the following minimum build tool versions:

| Tool  | Version |
| ----- | ------- |
| Xcode | 16+     |
| Swift | 6+      |

And supports the following device platforms:

| Platform | Version         |
| -------- | --------------- |
| iOS      | 16.0            |
| macOS    | 10.13 (Ventura) |

If you require additional compatibility, [let us know](https://dub.co/contact/support)!

## Installation

### Swift Package Manager (Recommended)

The Dub iOS SDK can be installed using the [Swift Package Manager](https://docs.swift.org/swiftpm/documentation/packagemanagerdocs/).

In Xcode, select **File** > **Add Package Dependencies** and add `https://github.com/dubinc/dub-ios` as the repository URL. Select the latest version of the SDK from the [release page](https://github.com/dubinc/dub-ios/releases).

### Other

If you have additional installation requirements, [let us know](https://dub.co/contact/support)!

## Examples

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
