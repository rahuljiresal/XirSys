//
//  XSNetworkRequest.h
//  Pods
//
//  Created by Sam Symons on 2014-07-27.
//
//

@import Foundation;

typedef void(^XSNetworkCompletion)(id response, NSError *error);

@interface XSNetworkRequest : NSObject

@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *secretKey;

- (instancetype)initWithUsername:(NSString *)username secretKey:(NSString *)secretKey;

/**
 Creates an NSURLSessionDataTask with a given path and set of parameters.
 
 @note This does not start the data task.
 */
- (NSURLSessionDataTask *)postPath:(NSString *)path parameters:(NSDictionary *)parameters completion:(XSNetworkCompletion)completion;

@end
