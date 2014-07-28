//
//  XSClient.h
//  Pods
//
//  Created by Sam Symons on 2014-07-27.
//
//

#import <Foundation/Foundation.h>

@interface XSClient : NSObject

@property (nonatomic, copy) NSString *username;

@property (nonatomic, copy) NSString *secretKey;

- (instancetype)initWithUsername:(NSString *)username secretKey:(NSString *)secretKey;

@end
