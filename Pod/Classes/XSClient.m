//
//  XSClient.m
//  Pods
//
//  Created by Sam Symons on 2014-07-27.
//
//

#import "XSClient.h"

#import "XSNetworkRequest.h"

@interface XSClient ()

@property (nonatomic, strong) XSNetworkRequest *request;

@end

@implementation XSClient

- (instancetype)initWithUsername:(NSString *)username secretKey:(NSString *)secretKey
{
    if (self = [super init]) {
        _username = username;
        _secretKey = secretKey;
        
        _request = [[XSNetworkRequest alloc] initWithUsername:_username secretKey:_secretKey];
    }
    
    return self;
}

- (NSURLSessionDataTask *)getTokenForDomain:(NSString *)domain application:(XSApplication *)application room:(NSString *)room secure:(BOOL)secure
{
    return nil;
}

- (NSURLSessionDataTask *)listDomainsWithCompletion:(XSArrayCompletion)completion
{
    NSURLSessionDataTask *task = [self.request postPath:@"listDomains" parameters:nil completion:^(id response, NSError *error) {
        if (completion) {
            completion([response objectForKey:@"d"], nil);
        }
    }];
    
    [task resume];
    
    return task;
}

@end
