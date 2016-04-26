//
//  IBKSession.h
//  ImgBook
//
//  Created by Chandan Shetty SP on 9/4/16.
//  Copyright © 2016 Chandan Shetty SP. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@protocol IBKSessionDelegates <NSObject>

@optional
-(void)imgurRequestFailed:(NSError*)error;

@end

@interface IBKSession : AFHTTPSessionManager

@property (readonly, nonatomic,copy) NSString *clientID;
@property (readonly, nonatomic, copy) NSString *secret;
@property (readwrite, nonatomic) BOOL isAnonymous;

@property (weak) id<IBKSessionDelegates> delegate;

+ (instancetype)sharedInstance;

+(instancetype)authenticatedSessionWithClientID:(NSString *)clientID secret:(NSString *)secret  withDelegate:(id<IBKSessionDelegates>)delegate;

@end


