//
//  IBKBaseModel.m
//  ImgBook
//
//  Created by Chandan Shetty SP on 9/4/16.
//  Copyright © 2016 Chandan Shetty SP. All rights reserved.
//

#import "IBKBaseModel.h"

@interface IBKBaseModel()

@end

@implementation IBKBaseModel

- (instancetype)initWithJSONObject:(NSDictionary *)jsonData error:(NSError *__autoreleasing *)error{
    NSAssert(NO, @"Should be overridden by subclass");
    return nil;
}

@end
