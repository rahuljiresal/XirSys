//
//  XSClient.m
//  Pods
//
//  Created by Sam Symons on 2014-07-27.
//
//

#import "XSClient.h"

#import "XSNetworkRequest.h"
#import "XSServer.h"

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

- (NSURLSessionDataTask *)getTokenForDomain:(NSString *)domain application:(NSString *)application room:(NSString *)room secure:(BOOL)secure completion:(XSObjectCompletion)completion
{
    NSString *secureString = secure ? @"1" : @"0";
    NSDictionary *parameters = @{ @"domain": domain, @"application": application, @"room": room, @"secure": secureString };
    
    NSURLSessionDataTask *task = [self.request postPath:@"getToken" parameters:parameters completion:^(id response, NSError *error) {
        if (completion) {
            completion([response objectForKey:@"d"], error);
        }
    }];
    
    [task resume];
    
    return task;
}

- (NSURLSessionDataTask *)getIceServersForDomain:(NSString *)domain application:(NSString *)application room:(NSString *)room secure:(BOOL)secure completion:(XSObjectCompletion)completion
{
    NSString *secureString = secure ? @"1" : @"0";
    NSDictionary *parameters = @{ @"domain": domain, @"application": application, @"room": room, @"secure": secureString };
    
    NSURLSessionDataTask *task = [self.request postPath:@"getIceServers" parameters:parameters completion:^(id response, NSError *error) {
        if (completion) {
            NSArray *servers = [response valueForKeyPath:@"d.iceServers"];
            NSMutableArray *serverObjects = [NSMutableArray array];
            
            for (NSDictionary *serverJSON in servers) {
                XSServer *server = [[XSServer alloc] initWithJSON:serverJSON];
                [serverObjects addObject:server];
            }
            
            completion([serverObjects copy], error);
        }
    }];
    
    [task resume];
    
    return task;
}

- (NSURLSessionDataTask *)listWebSocketServersWithCompletion:(XSObjectCompletion)completion
{
    NSURLSessionDataTask *task = [self.request postPath:@"wsList" parameters:nil completion:^(id response, NSError *error) {
        if (completion) {
            completion([response objectForKey:@"d"], error);
        }
    }];
    
    [task resume];
    
    return task;
}

- (NSURLSessionDataTask *)listDomainsWithCompletion:(XSArrayCompletion)completion
{
    NSURLSessionDataTask *task = [self.request postPath:@"listDomains" parameters:nil completion:^(id response, NSError *error) {
        if (completion) {
            completion([response objectForKey:@"d"], error);
        }
    }];
    
    [task resume];
    
    return task;
}

@end
