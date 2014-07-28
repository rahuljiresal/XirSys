//
//  XSServer.m
//  Pods
//
//  Created by Sam Symons on 2014-07-28.
//
//

#import "XSServer.h"

@implementation XSServer

- (instancetype)initWithJSON:(NSDictionary *)JSON
{
    NSParameterAssert(JSON);
    
    self = [super init];
    
    if (self) {
        _URL = [NSURL URLWithString:[JSON objectForKey:@"url"]];
        
        NSString *credential = JSON[@"credential"];
        NSString *username = JSON[@"username"];
        
        if (credential && username) {
            _serverType = XSServerTypeTurn;
            
            _credential = credential;
            _username = username;
        }
        else {
            _serverType = XSServerTypeStun;
        }
    }
    
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p, URL: %@>", NSStringFromClass([self class]), self, self.URL];
}

@end
