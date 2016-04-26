//
//  FTThumbnailCacheManager.m
//  FTWhink
//
//  Created by Chandan on 19/1/16.
//  Copyright © 2016 Fluid Touch Pte Ltd. All rights reserved.
//

#import "FTThumbnailCacheManager.h"

@interface FTThumbnailCacheManager()
@property(atomic,strong)NSMutableDictionary *cacheDictionary;
@end

@implementation FTThumbnailCacheManager

+(id)sharedManager
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cacheDictionary = [NSMutableDictionary dictionary];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleMemoryWarning:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(NSString*)hashForURL:(NSURL*)url
{
    NSString *hashKey = [url absoluteString];;
    return hashKey;
}

-(UIImage*)imageForURL:(NSURL*)url
{
    @synchronized(self.cacheDictionary) {
        return [self.cacheDictionary objectForKey:[self hashForURL:url]];
    }
}

-(UIImage*)cacheImage:(UIImage*)image forURL:(NSURL*)url
{
    @synchronized(self.cacheDictionary) {
        UIImage *outImage = image;
        if(image && url){
            [self.cacheDictionary setObject:image forKey:[self hashForURL:url]];
        }
        if(!outImage){
            outImage = [self imageForURL:url];
        }
        
        return outImage;
    }
}

-(void)removeCacheForURL:(NSURL*)url
{
    @synchronized(self.cacheDictionary) {
        [self.cacheDictionary removeObjectForKey:[self hashForURL:url]];
    }
}

-(void)handleMemoryWarning:(NSNotification*)notification
{
    [self clear];
}

-(void)clear
{
    @synchronized(self.cacheDictionary) {
        [self.cacheDictionary removeAllObjects];
    }
}

@end
