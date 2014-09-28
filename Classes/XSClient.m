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

- (NSURLSessionDataTask *)basicRequestWithPath:(NSString *)path parameters:(NSDictionary *)parameters completion:(XSCompletion)completion;

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

- (NSURLSessionDataTask *)getTokenForDomain:(NSString *)domain application:(NSString *)application room:(NSString *)room username:(NSString *)username secure:(BOOL)secure completion:(XSObjectCompletion)completion
{
    NSString *secureString = secure ? @"1" : @"0";
    NSDictionary *parameters = @{ @"domain": domain, @"application": application, @"room": room, @"username" : username, @"secure": secureString };

    NSURLSessionDataTask *task = [self.request postPath:@"getToken" parameters:parameters completion:^(id response, NSError *error) {
        if (completion) {
            completion([response objectForKey:@"d"], error);
        }
    }];
    
    [task resume];
    
    return task;
}

- (NSURLSessionDataTask *)getIceServersForDomain:(NSString *)domain application:(NSString *)application room:(NSString *)room username:(NSString *)username secure:(BOOL)secure completion:(XSArrayCompletion)completion
{
    NSString *secureString = secure ? @"1" : @"0";
    NSDictionary *parameters = @{ @"domain": domain, @"application": application, @"room": room, @"username" : username, @"secure": secureString };

    NSURLSessionDataTask *task = [self.request postPath:@"getIceServers" parameters:parameters completion:^(id response, NSError *error) {
        if (completion) {
            id servers = [response valueForKeyPath:@"d.iceServers"];
            NSMutableArray *serverObjects = [NSMutableArray array];
            
            if (servers && servers != [NSNull null]) {
                for (NSDictionary *serverJSON in servers) {
                    XSServer *server = [[XSServer alloc] initWithJSON:serverJSON];
                    [serverObjects addObject:server];
                }
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

- (NSURLSessionDataTask *)addDomain:(NSString *)domain completion:(XSCompletion)completion
{
    NSDictionary *parameters = @{ @"domain": domain };
    return [self basicRequestWithPath:@"addDomain" parameters:parameters completion:completion];
}

- (NSURLSessionDataTask *)addApplication:(NSString *)application toDomain:(NSString *)domain completion:(XSCompletion)completion
{
    NSDictionary *parameters = @{ @"domain": domain, @"application": application };
    return [self basicRequestWithPath:@"addApplication" parameters:parameters completion:completion];
}

- (NSURLSessionDataTask *)addRoom:(NSString *)domain toApplication:(NSString *)application inRoom:(NSString *)room completion:(XSCompletion)completion
{
    NSDictionary *parameters = @{ @"domain": domain, @"application": application, @"room": room };
    return [self basicRequestWithPath:@"addRoom" parameters:parameters completion:completion];
}

#pragma mark - Private

- (NSURLSessionDataTask *)basicRequestWithPath:(NSString *)path parameters:(NSDictionary *)parameters completion:(XSCompletion)completion
{
    NSURLSessionDataTask *task = [self.request postPath:path parameters:parameters completion:^(id response, NSError *error) {
        if (completion) {
            completion(error);
        }
    }];
    
    [task resume];
    
    return task;
}

@end
