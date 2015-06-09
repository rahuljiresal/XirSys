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
#import <Keys/XirSysKeys.h>

SpecBegin(XSClient)

XirSysKeys *keys = [[XirSysKeys alloc] init];
XSClient *client = [[XSClient alloc] initWithUsername:keys.xirSysUsername secretKey:keys.xirSysSecretKey];

describe(@"initialization", ^{
    it(@"is created with the correct properties", ^{
        expect(client.username).to.equal(keys.xirSysUsername);
        expect(client.secretKey).to.equal(keys.xirSysSecretKey);
    });
});

describe(@"getIceServersForDomain:application:room:secure:completion:", ^{
    it(@"lists the XirSys WebSocket servers", ^{
        waitUntil(^(DoneCallback done) {
            [client getIceServersForDomain:@"perch.co" application:@"default" room:@"default" username:keys.xirSysUsername secure:NO completion:^(NSArray *servers, NSError *error) {
                expect(error).to.beNil();
                done();
            }];
        });
    });
    
    it(@"returns an error when given invalid credentials", ^{
        waitUntil(^(DoneCallback done) {
            XSClient *badClient = [[XSClient alloc] initWithUsername:@"username" secretKey:@"password"];
            
            [badClient getIceServersForDomain:@"perch.co" application:@"default" room:@"default" username:@"username" secure:NO completion:^(NSArray *servers, NSError *error) {
                expect(servers.count).to.equal(0);
                expect(error).toNot.beNil();
                
                done();
            }];
        });
    });
});

describe(@"listDomainsWithCompletion:", ^{
    it(@"lists the XirSys WebSocket servers", ^{
        waitUntil(^(DoneCallback done) {
            [client listWebSocketServersWithCompletion:^(NSDictionary *servers, NSError *error) {
                expect(error).to.beNil();
                done();
            }];
        });
    });
    
    it(@"does not return an error when given invalid credentials", ^{
        waitUntil(^(DoneCallback done) {
            XSClient *badClient = [[XSClient alloc] initWithUsername:@"username" secretKey:@"password"];
            
            [badClient listWebSocketServersWithCompletion:^(NSDictionary *servers, NSError *error) {
                expect(error).to.beNil();
                done();
            }];
        });
    });
});

describe(@"listDomainsWithCompletion:", ^{
    it(@"lists a user's domains", ^{
        waitUntil(^(DoneCallback done) {
            [client listDomainsWithCompletion:^(NSArray *domains, NSError *error) {
                expect(domains).to.contain(@"perch.co");
                
                done();
            }];
        });
    });
    
    it(@"returns an error when given invalid credentials", ^{
        waitUntil(^(DoneCallback done) {
            XSClient *badClient = [[XSClient alloc] initWithUsername:@"username" secretKey:@"password"];
            
            [badClient listDomainsWithCompletion:^(NSArray *domains, NSError *error) {
                expect(domains).to.beNil();
                expect(error).toNot.beNil();
                
                done();
            }];
        });
    });
});

SpecEnd
