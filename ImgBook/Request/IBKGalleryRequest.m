//
//  IBKGallaryRequest.m
//  ImgBook
//
//  Created by Chandan Shetty SP on 9/4/16.
//  Copyright © 2016 Chandan Shetty SP. All rights reserved.
//

#import "IBKGalleryRequest.h"
#import "IBKGalleryAlbum.h"
#import "IBKGalleryImage.h"

@implementation IBKGalleryRequest

+(NSString*)pathComponent{
    return @"gallery";
}

+(void)galleryPage:(NSInteger)page
              type:(IMGGallerySectionType)type
           perPage:(NSInteger)perPageCount
             viral:(BOOL)showViral
        withWindow:(IMGTopGalleryWindow)window
           success:(void (^)(NSArray * objects))success
           failure:(void (^)(NSError *error))failure
{
    switch (type) {
        case IMGGallerySectionTypeHot:{
            [self hotGalleryPage:page perPage:perPageCount withViralSort:NO showViral:showViral success:success failure:failure];
        }
            break;
            
        case IMGGallerySectionTypeUser:{
            [self userGalleryPage:page perPage:perPageCount showViral:showViral success:success failure:failure];
        }
            break;
            
        case IMGGallerySectionTypeTop:{
            [self topGalleryPage:page perPage:perPageCount withViralSort:NO showViral:showViral withWindow:window success:success failure:failure];
        }
            break;
            
        default:
            break;
    }
}

+(void)hotGalleryPage:(NSInteger)page  perPage:(NSInteger)perPageCount withViralSort:(BOOL)viralSort showViral:(BOOL)showViral success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure{
    
    NSDictionary * params = @{@"section":@"hot",
                              @"perPage":[NSNumber numberWithInteger:perPageCount],
                              @"page":[NSNumber numberWithInteger:page],
                              @"sort":(viralSort ? @"viral" : @"time"),
                              @"showViral": (showViral ? @"true" : @"false")};
    
    [self galleryWithParameters:params success:success failure:failure];
}

+(void)topGalleryPage:(NSInteger)page perPage:(NSInteger)perPageCount withViralSort:(BOOL)viralSort showViral:(BOOL)showViral withWindow:(IMGTopGalleryWindow)window success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure{
    
    [self topGalleryPage:page perPage:perPageCount withWindow:window withViralSort:YES showViral:showViral success:success failure:failure];
}

+(void)topGalleryPage:(NSInteger)page perPage:(NSInteger)perPageCount withWindow:(IMGTopGalleryWindow)window withViralSort:(BOOL)viralSort showViral:(BOOL)showViral success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure{
    
    NSString * windowStr;
    switch (window) {
        case IMGTopGalleryWindowDay:
            windowStr = @"day";
            break;
        case IMGTopGalleryWindowWeek:
            windowStr = @"week";
            break;
        case IMGTopGalleryWindowMonth:
            windowStr = @"month";
            break;
        case IMGTopGalleryWindowYear:
            windowStr = @"year";
            break;
        case IMGTopGalleryWindowAll:
            windowStr = @"all";
            break;
        default:
            windowStr = @"day";
            break;
    }
    
    //defauts are viral sort
    NSDictionary * params = @{@"section" : @"top",
                              @"perPage":[NSNumber numberWithInteger:perPageCount],
                              @"page":[NSNumber numberWithInteger:page],
                              @"window": windowStr,
                              @"sort":(viralSort ? @"viral" : @"time"),
                              @"showViral": (showViral ? @"true" : @"false")};
    
    [self galleryWithParameters:params success:success failure:failure];
}

+(void)userGalleryPage:(NSInteger)page perPage:(NSInteger)perPageCount showViral:(BOOL)showViral success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure{
    
    [self userGalleryPage:page perPage:perPageCount withViralSort:NO showViral:showViral success:success failure:failure];
}

+(void)userGalleryPage:(NSInteger)page perPage:(NSInteger)perPageCount withViralSort:(BOOL)viralSort showViral:(BOOL)showViral success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure{
    
    NSDictionary * params = @{@"section":@"user",
                              @"perPage":[NSNumber numberWithInteger:perPageCount],
                              @"page":[NSNumber numberWithInteger:page],
                              @"sort":(viralSort ? @"viral" : @"time"),
                              @"showViral": (showViral ? @"true" : @"false" )};
    
    [self galleryWithParameters:params success:success failure:failure];
}


+(void)galleryWithParameters:(NSDictionary *)parameters success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure{
    
    NSString *path = [self path];
    
    if(parameters[@"section"]){
        path = [path stringByAppendingPathComponent:parameters[@"section"]];
    }
    
    if(parameters[@"sort"]){
        path = [path stringByAppendingPathComponent:parameters[@"sort"]];
    }
    
    if(parameters[@"page"]){
        
        NSInteger perPageCount = 50;
        if(parameters[@"perPage"]){
            perPageCount = [(NSNumber*)parameters[@"perPage"] integerValue];
        }
        
        path = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%ld?perPage=%ld&page=%ld",(long)[(NSNumber*)parameters[@"page"] integerValue],(long)perPageCount,(long)[(NSNumber*)parameters[@"page"] integerValue]]];
    }
    
    if(parameters[@"showViral"]){
        path = [path stringByAppendingString:[NSString stringWithFormat:@"&showViral=%@",[(NSNumber*)parameters[@"showViral"] boolValue] ? @"true" : @"false"]];
    }
    
    //https://api.imgur.com/3/account/imgur/images/0.json?perPage=42&page=6
    [[IBKSession sharedInstance] GET:path
                          parameters:nil
                            progress:^(NSProgress * _Nonnull downloadProgress) {
                                
                            }
                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                 
                                 NSInteger dataSucccess = [responseObject[@"success"] boolValue];
                                 if(dataSucccess){
                                     NSArray *jsonArray = responseObject[@"data"];
                                     NSMutableArray * images = [NSMutableArray new];
                                     
                                     for(NSDictionary * json in jsonArray){
                                         
                                         if([json[@"is_album"] boolValue]){
                                             NSError *JSONError = nil;
                                             IBKGalleryAlbum * album = [[IBKGalleryAlbum alloc] initWithJSONObject:json error:&JSONError];
                                             if(!JSONError && album)
                                                 [images addObject:album];
                                         } else {
                                             
                                             NSError *JSONError = nil;
                                             IBKGalleryImage * image = [[IBKGalleryImage alloc] initWithJSONObject:json error:&JSONError];
                                             if(!JSONError && image)
                                                 [images addObject:image];
                                         }
                                     }

                                     
                                     if(success){
                                         success([NSArray arrayWithArray:images]);
                                     }
                                 }
                                 else{
                                     success(nil);
                                 }

                             }
                             failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                 NSLog(@"Error loading %@ for Task %@",error,task);
                             }];
}

@end
