//
//  IBKSession.m
//  ImgBook
//
//  Created by Chandan Shetty SP on 9/4/16.
//  Copyright © 2016 Chandan Shetty SP. All rights reserved.
//

#import "IBKSession.h"

@interface IBKSession ()

@property (readwrite, nonatomic,copy) NSString *clientID;
@property (readwrite, nonatomic, copy) NSString *secret;

@end

@implementation IBKSession

+ (instancetype)sharedInstance
{
    
    static dispatch_once_t onceToken;
    static IBKSession *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[IBKSession alloc] init];
    });
    
    return sharedInstance;
}

- (instancetype)init
{    
    if(self = [self initWithBaseURL:[NSURL URLWithString:IBK_BASE_URL]]){
    }
    return self;
}

+(instancetype)authenticatedSessionWithClientID:(NSString *)clientID secret:(NSString *)secret  withDelegate:(id<IBKSessionDelegates>)delegate
{
    [[IBKSession sharedInstance] setupClientWithID:clientID secret:secret withDelegate:delegate];
    return [self sharedInstance];
}

#pragma mark - Authorization Header

/**
 Configure session with client credentials. Anonymous session if secret is null
 */
-(void)setupClientWithID:(NSString*)clientID secret:(NSString*)secret withDelegate:(id<IBKSessionDelegates>)delegate
{
    //clear header
    AFHTTPRequestSerializer * serializer = self.requestSerializer;
    [serializer clearAuthorizationHeader];
    
    self.clientID = clientID;
    self.delegate = delegate;
    
    //assumed anon if no secret given
    self.isAnonymous = YES;
    //change the serializer to include this authorization header
    [serializer setValue:[NSString stringWithFormat:@"Client-ID %@", clientID] forHTTPHeaderField:@"Authorization"];
}


@end
