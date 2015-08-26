//
//  XSClient.h
//  Pods
//
//  Created by Sam Symons on 2014-07-27.
//
//

#import <Foundation/Foundation.h>

typedef void(^XSCompletion)(NSError *error);
typedef void(^XSObjectCompletion)(id object, NSError *error);
typedef void(^XSArrayCompletion)(NSArray *collection, NSError *error);

typedef NS_ENUM(NSUInteger, XSSignalingType) {
    XSSignalingTypePeer,
};

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

- (NSURLSessionDataTask *)getTokenForDomain:(NSString *)domain application:(NSString *)application room:(NSString *)room username:(NSString *)username secure:(BOOL)secure completion:(XSObjectCompletion)completion;

/**
 List all ICE servers for a given domain.
 */
- (NSURLSessionDataTask *)getIceServersForDomain:(NSString *)domain application:(NSString *)application room:(NSString *)room username:(NSString *)username secure:(BOOL)secure completion:(XSArrayCompletion)completion;

/**
 List all ICE servers for a given domain.
 @timeout Timeout interval for the ICE Credentials. Maximum of 30 minutes.
 */
- (NSURLSessionDataTask *)getIceServersForDomain:(NSString *)domain application:(NSString *)application room:(NSString *)room username:(NSString *)username secure:(BOOL)secure timeout:(NSTimeInterval)timeout completion:(XSArrayCompletion)completion;

/**
 Lists all of the WebSocket servers provided by XirSys.
 */
- (NSURLSessionDataTask *)listWebSocketServersWithCompletion:(XSObjectCompletion)completion;

/**
 Lists all of the domains available to your account.
 */
- (NSURLSessionDataTask *)listDomainsWithCompletion:(XSArrayCompletion)completion;

/**
 Lists all of the applications available to in a given domain.
 */
- (NSURLSessionDataTask *)listApplicationsWithDomain:(NSString *)domain completion:(XSArrayCompletion)completion;

/**
 Creates a new domain in an account.
 */
- (NSURLSessionDataTask *)addDomain:(NSString *)domain completion:(XSCompletion)completion;

/**
 Creates a new application in a domain.
 */
- (NSURLSessionDataTask *)addApplication:(NSString *)application toDomain:(NSString *)domain completion:(XSCompletion)completion;

/**
 Creates a new room in an application.
 */
- (NSURLSessionDataTask *)addRoom:(NSString *)room toApplication:(NSString *)application inDomain:(NSString *)domain completion:(XSCompletion)completion;

/**
 *  Destroys the given room in an application
 *
 *  @param room        Room Name
 *  @param application Application Name
 *  @param domain      Domain Name
 *  @param completion  Completion Block
 *
 *  @return Object of the NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)destroyRoom:(NSString *)room fromApplication:(NSString *)application inDomain:(NSString *)domain completion:(XSCompletion)completion;


@end
