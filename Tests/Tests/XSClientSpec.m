//
//  XSClientSpec.m
//  XirSys
//
//  Created by Sam Symons on 2014-07-27.
//  Copyright (c) 2014 Sam Symons. All rights reserved.
//

#import <Specta/Specta.h>
#import <Expecta/Expecta.h>
#import <XirSys/XSClient.h>

SpecBegin(XSClient)

describe(@"initialization", ^{
    it(@"is created with the correct properties", ^{
        XSClient *client = [[XSClient alloc] initWithUsername:@"samsymons" secretKey:@"secretkey"];
        
        expect(client.username).to.equal(@"samsymons");
        expect(client.secretKey).to.equal(@"secretkey");
    });
});

describe(@"getIceServersForDomain:application:room:secure:completion:", ^{
    XSClient *client = [[XSClient alloc] initWithUsername:@"samsymons" secretKey:@"secretkey"];
    
    fit(@"lists the XirSys WebSocket servers", ^AsyncBlock {
        [client getIceServersForDomain:@"perch.co" application:@"default" room:@"default" username:@"samsymons" secure:NO completion:^(NSArray *servers, NSError *error) {
            NSLog(@"Servers: %@", servers);
            expect(error).to.beNil();
            done();
        }];
    });
});

describe(@"listDomainsWithCompletion:", ^{
    XSClient *client = [[XSClient alloc] initWithUsername:@"samsymons" secretKey:@"secretkey"];
    
    it(@"lists the XirSys WebSocket servers", ^AsyncBlock {
        [client listWebSocketServersWithCompletion:^(NSDictionary *servers, NSError *error) {
            expect(error).to.beNil();
            done();
        }];
    });
});

describe(@"listDomainsWithCompletion:", ^{
    XSClient *client = [[XSClient alloc] initWithUsername:@"samsymons" secretKey:@"secretkey"];
    
    it(@"lists a user's domains", ^AsyncBlock {
        [client listDomainsWithCompletion:^(NSArray *domains, NSError *error) {
            expect(domains).to.contain(@"perch.co");
            
            done();
        }];
    });
});

SpecEnd
