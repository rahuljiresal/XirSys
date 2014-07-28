//
//  XSClient.h
//  Pods
//
//  Created by Sam Symons on 2014-07-27.
//
//

#import <Foundation/Foundation.h>

typedef void(^XSObjectCompletion)(id object, NSError *error);
typedef void(^XSArrayCompletion)(NSArray *collection, NSError *error);

@interface XSClient : NSObject

/**
 The username attached to your account. This will be used by each request made to the XirSys API.
 */
@property (nonatomic, copy) NSString *username;

/**
 The secret key attached to your account. This will be used by each request made to the XirSys API.
 */
@property (nonatomic, copy) NSString *secretKey;

- (instancetype)initWithUsername:(NSString *)username secretKey:(NSString *)secretKey;

- (NSURLSessionDataTask *)getTokenForDomain:(NSString *)domain application:(NSString *)application room:(NSString *)room secure:(BOOL)secure completion:(XSObjectCompletion)completion;

/**
 List all ICE servers for a given domain.
 */
- (NSURLSessionDataTask *)getIceServersForDomain:(NSString *)domain application:(NSString *)application room:(NSString *)room secure:(BOOL)secure completion:(XSObjectCompletion)completion;

/**
 Lists all of the WebSocket servers provided by XirSys.
 */
- (NSURLSessionDataTask *)listWebSocketServersWithCompletion:(XSObjectCompletion)completion;

/**
 Lists all of the domains available to your account.
 */
- (NSURLSessionDataTask *)listDomainsWithCompletion:(XSArrayCompletion)completion;

@end
