//
//  XSNetworkRequestSpec.m
//  XirSys
//
//  Created by Sam Symons on 2014-07-27.
//  Copyright (c) 2014 Sam Symons. All rights reserved.
//

#import <XirSys/Networking/XSNetworkRequest.h>
#import <Specta/Specta.h>
#import <Keys/XirSysKeys.h>

SpecBegin(XSNetworkRequest)

XirSysKeys *keys = [[XirSysKeys alloc] init];

describe(@"initialization", ^{
    it(@"is created with the correct properties", ^{
        XSNetworkRequest *request = [[XSNetworkRequest alloc] initWithUsername:keys.xirSysUsername secretKey:keys.xirSysSecretKey];
        
        expect(request.username).to.equal(keys.xirSysUsername);
        expect(request.secretKey).to.equal(keys.xirSysSecretKey);
    });
});

describe(@"postPath:parameters:completion:", ^{
    XSNetworkRequest *request = [[XSNetworkRequest alloc] initWithUsername:@"samsymons" secretKey:@"secretkey"];
    
    it(@"returns an NSURLSessionDataTask", ^{
        NSURLSessionDataTask *task = [request postPath:@"path" parameters:nil completion:nil];
        NSURLRequest *request = task.originalRequest;
        
        expect(request.URL).to.equal([NSURL URLWithString:@"https://api.xirsys.com/path"]);
    });
});

SpecEnd
