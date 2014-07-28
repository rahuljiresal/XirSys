//
//  XSServer.h
//  Pods
//
//  Created by Sam Symons on 2014-07-28.
//
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, XSServerType) {
    XSServerTypeStun = 1,
    XSServerTypeTurn
};

@interface XSServer : NSObject

@property (nonatomic, assign, readonly) XSServerType serverType;

/**
 The server's URL. This is always present.
 */
@property (nonatomic, strong, readonly) NSURL *URL;

/**
 The server's credential. This is present when using TURN servers.
 */
@property (nonatomic, strong, readonly) NSString *credential;

/**
 The server's username. This is present when using TURN servers.
 */
@property (nonatomic, strong, readonly) NSString *username;

- (instancetype)initWithJSON:(NSDictionary *)JSON;

@end
