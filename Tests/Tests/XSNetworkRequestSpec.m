//
//  XSNetworkRequestSpec.m
//  XirSys
//
//  Created by Sam Symons on 2014-07-27.
//  Copyright (c) 2014 Sam Symons. All rights reserved.
//

#import <XirSys/Networking/XSNetworkRequest.h>

SpecBegin(XSNetworkRequest)

describe(@"initialization", ^{
    it(@"is created with the correct properties", ^{
        XSNetworkRequest *request = [[XSNetworkRequest alloc] initWithUsername:@"samsymons" secretKey:@"secretkey"];
        
        expect(request.username).to.equal(@"samsymons");
        expect(request.secretKey).to.equal(@"secretkey");
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
