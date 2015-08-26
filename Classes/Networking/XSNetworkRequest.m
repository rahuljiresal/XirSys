//
//  XSNetworkRequest.m
//  Pods
//
//  Created by Sam Symons on 2014-07-27.
//
//

#import "XSNetworkRequest.h"

NSString * const XSBaseURL = @"https://service.xirsys.com/";
NSString * const XSErrorDomain = @"com.xirsys.error";

@interface XSNetworkRequest ()

@property (nonatomic, copy) NSDictionary *credentials;

- (NSURLRequest *)requestWithPath:(NSString *)path parameters:(NSDictionary *)parameters method:(NSString *)method;
- (NSString *)parameterStringWithParameters:(NSDictionary *)parameters;
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

- (NSURLSessionDataTask *)postPath:(NSString *)path parameters:(NSDictionary *)parameters completion:(XSNetworkCompletion)completion
{
    return [self method:@"POST" path:path parameters:parameters completion:completion];
}

- (NSURLSessionDataTask *)deletePath:(NSString *)path parameters:(NSDictionary *)parameters completion:(XSNetworkCompletion)completion
{
    return [self method:@"DELETE" path:path parameters:parameters completion:completion];
}

- (NSURLSessionDataTask *)getPath:(NSString *)path parameters:(NSDictionary *)parameters completion:(XSNetworkCompletion)completion
{
    return [self method:@"GET" path:path parameters:parameters completion:completion];
}

#pragma mark - Private

- (NSURLSessionDataTask *)method:(NSString *)method path:(NSString *)path parameters:(NSDictionary *)parameters completion:(XSNetworkCompletion)completion
{
    NSParameterAssert(path);
    
    NSDictionary *requestParameters = [self parametersByMergingCredentials:parameters];
    NSURLRequest *request = [self requestWithPath:path parameters:requestParameters method:method];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (completion) {
            NSDictionary *response = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSError *error = [self errorFromResponse:response];
            
            if (error) {
                completion(nil, error);
            }
            else {
                completion(response, nil);
            }
        }
    }];
    
    task.priority = NSURLSessionTaskPriorityHigh;
    
    return task;
}

- (NSURLRequest *)requestWithPath:(NSString *)path parameters:(NSDictionary *)parameters method:(NSString *)method
{
    NSURL *URL = [[NSURL URLWithString:XSBaseURL] URLByAppendingPathComponent:path];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL];
    NSString *parameterString = [self parameterStringWithParameters:[self parametersByMergingCredentials:parameters]];
    
    [request setHTTPMethod:method];
    [request setHTTPBody:[parameterString dataUsingEncoding:NSUTF8StringEncoding]];
    
    return [request copy];
}

- (NSString *)parameterStringWithParameters:(NSDictionary *)parameters
{
    NSMutableArray *components = [NSMutableArray array];
    
    for (id key in parameters) {
        id value = [parameters objectForKey:key];
        
        NSString *component = [NSString stringWithFormat:@"%@=%@", key, value];
        [components addObject:component];
    }
    
    return [components componentsJoinedByString:@"&"];
}

- (NSDictionary *)parametersByMergingCredentials:(NSDictionary *)parameters
{
    NSMutableDictionary *mutableParameters = parameters ? [parameters mutableCopy] : [NSMutableDictionary dictionary];
    [mutableParameters addEntriesFromDictionary:self.credentials];
    
    return [mutableParameters copy];
}

- (NSError *)errorFromResponse:(NSDictionary *)response
{
    NSUInteger statusCode = [[response objectForKey:@"s"] unsignedIntegerValue];
    NSError *error = nil;
    
    if (statusCode >= 300) {
        NSDictionary *userInfo = @{ NSLocalizedDescriptionKey: [response objectForKey:@"e"], @"status": @(statusCode) };
        
        error = [NSError errorWithDomain:XSErrorDomain code:statusCode userInfo:userInfo];
    }
    
    return error;
}

@end
