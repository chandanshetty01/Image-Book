//
//  FTThumbnailCacheManager.h
//  FTWhink
//
//  Created by Chandan on 19/1/16.
//  Copyright © 2016 Fluid Touch Pte Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FTThumbnailCacheManager : NSObject

+(FTThumbnailCacheManager*)sharedManager;

-(UIImage*)cacheImage:(UIImage*)image forURL:(NSURL*)url;
-(UIImage*)imageForURL:(NSURL*)url;
-(void)removeCacheForURL:(NSURL*)url;
-(void)clear;

@end
