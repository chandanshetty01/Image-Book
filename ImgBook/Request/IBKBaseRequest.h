//
//  IBKBaseRequest.h
//  ImgBook
//
//  Created by Chandan Shetty SP on 9/4/16.
//  Copyright © 2016 Chandan Shetty SP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IBKSession.h"

@interface IBKBaseRequest : NSObject

/**
 @return path component common to this endpoint
 */
+(NSString*)pathComponent;

/**
 @return full path to this endpoint
 */
+(NSString*)path;

@end
