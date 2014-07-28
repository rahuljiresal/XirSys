# XirSys

## Usage

## Installation

XirSys is available through [CocoaPods](http://cocoapods.org). Add the following line to your Podfile, then run `pod install`:

```
pod "XirSys"
```

## Getting Started

XirSys is based around the `XSClient` class. `XSClient` takes authentication credentials and uses them to make API requests. You create an authenticated client like so:

```
XSClient *client = [[XSClient alloc] initWithUsername:@"samsymons" secretKey:@"secretkey"];
```

## License

XirSys is available under the MIT license. See the LICENSE file for more info.