# XirSys

An Objective-C wrapper for the [XirSys API](http://xirsys.com/api/), compatible with iOS and OS X.

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

## Usage

`XSClient` automatically authenticates requests based on its `username` and `secretKey` properties. Providing you have them set, the client will take care of the authentication process automatically.

Here's how you would get a list of servers for a given domain:

```
XSClient *client = [[XSClient alloc] initWithUsername:@"samsymons" secretKey:@"secretkey"];
[client getIceServersForDomain:@"perch.co" application:@"default" room:@"default" secure:YES completion:^(NSArray *servers, NSError *error) {
    NSLog(@"Servers: %@", servers);
}];
```

## License

XirSys is available under the MIT license. See the LICENSE file for more info.