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

@property (nonatomic, strong) XSNetworkRequest *networkRequest;

@end

@implementation XSClient

- (instancetype)initWithUsername:(NSString *)username secretKey:(NSString *)secretKey
{
    if (self = [super init]) {
        _username = username;
        _secretKey = secretKey;
        
        _networkRequest = [[XSNetworkRequest alloc] initWithUsername:_username secretKey:_secretKey];
    }
    
    return self;
}

- (NSURLSessionDataTask *)getTokenForDomain:(NSString *)domain application:(XSApplication *)application room:(NSString *)room secure:(BOOL)secure
{
    return nil;
}

- (NSURLSessionDataTask *)listDomainsWithCompletion:(XSArrayCompletion)completion
{
    return [self.networkRequest postPath:@"listApplications" parameters:nil completion:^(id response, NSError *error) {
        NSLog(@"Response: %@", response);
        
        if (completion) {
            completion(nil, nil);
        }
    }];
}

@end
