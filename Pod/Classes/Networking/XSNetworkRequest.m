//
//  XSNetworkRequest.m
//  Pods
//
//  Created by Sam Symons on 2014-07-27.
//
//

#import "XSNetworkRequest.h"

@interface XSNetworkRequest ()

@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *secretKey;

@property (nonatomic, copy) NSDictionary *credentials;

- (NSDictionary *)parametersByMergingCredentials:(NSDictionary *)parameters;

@end

@implementation XSNetworkRequest

- (instancetype)initWithUsername:(NSString *)username secretKey:(NSString *)secretKey
{
    NSParameterAssert(username);
    NSParameterAssert(secretKey);
    
    if (self = [super init]) {
        _username = username;
        _secretKey = secretKey;
        
        _credentials = @{ @"ident": _username, @"secret": _secretKey };
    }
    
    return self;
}

- (NSURLSessionDataTask *)postPath:(NSString *)path parameters:(NSDictionary *)parameters completion:(XSCompletion)completion
{
    NSParameterAssert(path);
    
    return nil;
}

#pragma mark - Private

- (NSDictionary *)parametersByMergingCredentials:(NSDictionary *)parameters
{
    NSParameterAssert(parameters);
    
    NSMutableDictionary *mutableParameters = [parameters mutableCopy];
    [mutableParameters addEntriesFromDictionary:self.credentials];
    
    return [mutableParameters copy];
}

@end
