//
//  IBKBaseRequest.m
//  ImgBook
//
//  Created by Chandan Shetty SP on 9/4/16.
//  Copyright © 2016 Chandan Shetty SP. All rights reserved.
//

#import "IBKBaseRequest.h"

@implementation IBKBaseRequest

+(NSString *)pathComponent
{
    NSAssert(NO, @"Should be overridden by subclass");
    return nil;
}

+(NSString*)path
{
    return [NSString stringWithFormat:@"%@/%@", IBKAPIVersion, [self pathComponent]];
}

@end
