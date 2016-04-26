//
//  IBKBaseAlbum.h
//  ImgBook
//
//  Created by Chandan Shetty SP on 9/4/16.
//  Copyright © 2016 Chandan Shetty SP. All rights reserved.
//

#import "IBKBaseModel.h"

@interface IBKBaseAlbum : IBKBaseModel

/**
 Album ID
 */
@property (nonatomic, readonly, copy) NSString *albumID;
/**
 Title of album
 */
@property (nonatomic, readonly, copy) NSString *title;
/**
 Album description
 */
@property (nonatomic, readonly, copy) NSString *albumDescription;
/**
 Album creation date
 */
@property (nonatomic, readonly) NSDate *datetime;

/**
 Image Id for cover of album
 */
@property (nonatomic, readonly, copy) NSString *coverID;
/**
 Cover image width in px
 */
@property (nonatomic, readonly) CGFloat coverWidth;
/**
 Cover image height in px
 */
@property (nonatomic, readonly) CGFloat coverHeight;
/**
 account username of album creator, not a URL but named like this anyway. nil if anonymous
 */
@property (nonatomic, readonly, copy) NSString *accountURL;
/**
 Privacy of album
 */
@property (nonatomic, readonly, copy) NSString *privacy;
/**
 Number of views for album
 */
@property (nonatomic, readonly) NSInteger views;
/**
 URL for album link
 */
@property (nonatomic, readonly) NSURL *url;
/**
 Number of images in album
 */
@property (nonatomic, readonly) NSInteger imagesCount; // Optional: can be set to nil
/**
 Array of images in IMGImage form
 */
@property (nonatomic, readonly, copy) NSArray *images; // Optional: can be set to nil


@end
