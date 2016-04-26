//
//  IBKImage.h
//  ImgBook
//
//  Created by Chandan Shetty SP on 9/4/16.
//  Copyright © 2016 Chandan Shetty SP. All rights reserved.
//

#import "IBKBaseModel.h"
#import "IBKBaseAlbum.h"

typedef NS_ENUM(NSInteger, IBKSize) {
    IBKSmallSquareSize,
    IBKBigSquareSize,
    IBKSmallThumbnailSize,
    IBKMediumThumbnailSize,
    IBKLargeThumbnailSize,
    IBKHugeThumbnailSize
};

@class IBKImage;

@protocol IBKObjectProtocol <NSObject>

@optional
/**
 Is the object an an album
 */
-(BOOL)isAlbum;
/**
 Get the cover image representation of object
 */
-(IBKImage*)coverImage;
/**
 Set the cover image representation of object
 */
-(void)setCoverImage:(IBKImage*)coverImage;
/**
 ID for the  object
 */
-(NSString*)objectID;
/**
 Title of object
 */
-(NSString*)title;
/**
 ID of cover Image
 */
-(NSString*)coverID;
/**
 Views
 */
-(NSInteger)views;
/**
 description
 */
-(NSString*)galleryDescription;
/**
 Get thumbnails for image/album
 */
- (NSURL *)URLWithSize:(IBKSize)size;
/**
 Get date object was created
 */
- (NSDate *)datetime;
/**
 Get imgur web page for object
 */
-(NSURL*)link;

@end

@interface IBKImage : IBKBaseModel <IBKObjectProtocol>

/**
 Image ID to reference in Imgur globally
 */
@property (nonatomic, readonly, copy) NSString *imageID;
/**
 Title of image. This is the heading on the imgur image page where the joke usually is.
 */
@property (nonatomic, readonly, copy) NSString *title;
/**
 Description of image. Never seen this filled out
 */
@property (nonatomic, readonly, copy) NSString * imageDescription;
/**
 Date image was submitted.
 */
@property (nonatomic, readonly) NSDate *datetime;

/**
 Type of image from HTTP header. JPEG/GIF, maybe other types
 */
@property (nonatomic, readonly, copy) NSString *type;
/**
 Is the image animated
 */
@property (nonatomic, readonly) BOOL animated;
/**
 Image width in px
 */
@property (nonatomic, readonly) CGFloat width;
/**
 Image height in px
 */
@property (nonatomic, readonly) CGFloat height;
/**
 Image size in bytes
 */
@property (nonatomic, readonly) NSInteger size;
/**
 Number of page impressions/image views on imgur
 */
@property (nonatomic, readonly) NSInteger views;
/**
 Image bandwidth transmitted to users in bytes
 */
@property (nonatomic, readonly) NSInteger bandwidth;
/**
 Hash to send DELETE request with to delete image when session is using anonymous authentication.
 */
@property (nonatomic, readonly, copy) NSString *deletehash;
/**
 Imgur section the image belongs to if applicable
 */
@property (nonatomic, readonly, copy) NSString *section;
/**
 URL to actual image file. Use URLWithSize to retrieve various image sizes.
 */
@property (nonatomic, readonly, copy) NSURL *url;

/**
 For creating constructed cover image from the cover paramaters in basicAlbum
 */
-(instancetype)initCoverImageWithAlbum:(IBKBaseAlbum*)album error:(NSError *__autoreleasing *)error;

/**
 Retrieves various image sizes using the url with the letter specifier model as described at https://api.imgur.com/models/image
 @param size constant to specify requested image size
 @return URL for image of that size
 */
- (NSURL *)URLWithSize:(IBKSize)size;

@end
