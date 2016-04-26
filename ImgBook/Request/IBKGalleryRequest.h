//
//  IBKGallaryRequest.h
//  ImgBook
//
//  Created by Chandan Shetty SP on 9/4/16.
//  Copyright © 2016 Chandan Shetty SP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IBKBaseRequest.h"
#import "IBKSession.h"

typedef NS_ENUM(NSInteger, IMGGallerySectionType) {
    IMGGallerySectionTypeHot, //default
    IMGGallerySectionTypeTop,
    IMGGallerySectionTypeUser
};

typedef NS_ENUM(NSInteger, IMGTopGalleryWindow) {
    IMGTopGalleryWindowDay, //default
    IMGTopGalleryWindowWeek,
    IMGTopGalleryWindowMonth,
    IMGTopGalleryWindowYear,
    IMGTopGalleryWindowAll
};

typedef NS_ENUM(NSInteger, IMGGalleryCommentSortType) {
    IMGGalleryCommentSortBest, //default
    IMGGalleryCommentSortHot,
    IMGGalleryCommentSortNew
};

@interface IBKGalleryRequest : IBKBaseRequest

+(void)galleryPage:(NSInteger)page
              type:(IMGGallerySectionType)type
           perPage:(NSInteger)perPageCount
             viral:(BOOL)isViral
        withWindow:(IMGTopGalleryWindow)window
           success:(void (^)(NSArray * objects))success
           failure:(void (^)(NSError *error))failure;

@end
