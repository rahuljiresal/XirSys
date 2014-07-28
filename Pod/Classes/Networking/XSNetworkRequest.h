//
//  XSNetworkRequest.h
//  Pods
//
//  Created by Sam Symons on 2014-07-27.
//
//

@import Foundation;

typedef void(^XSCompletion)(id response, NSError *error);

@interface XSNetworkRequest : NSObject

- (instancetype)initWithUsername:(NSString *)username secretKey:(NSString *)secretKey;

- (NSURLSessionDataTask *)postPath:(NSString *)path parameters:(NSDictionary *)parameters completion:(XSCompletion)completion;

@end
