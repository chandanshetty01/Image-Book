//
//  IBKImage.m
//  IBKBook
//
//  Created by Chandan Shetty SP on 9/4/16.
//  Copyright © 2016 Chandan Shetty SP. All rights reserved.
//

#import "IBKImage.h"

@interface IBKImage ()

@property (readwrite,nonatomic) NSString *imageID;
@property (readwrite,nonatomic) NSString *title;
@property (readwrite,nonatomic) NSString * imageDescription;
@property (readwrite,nonatomic) NSDate *datetime;
@property (readwrite,nonatomic) NSString *type;
@property (readwrite,nonatomic) BOOL animated;
@property (readwrite,nonatomic) CGFloat width;
@property (readwrite,nonatomic) CGFloat height;
@property (readwrite,nonatomic) NSInteger size;
@property (readwrite,nonatomic) NSInteger views;
@property (readwrite,nonatomic) NSInteger bandwidth;
@property (readwrite,nonatomic) NSString *deletehash;
@property (readwrite,nonatomic) NSString *section;
@property (readwrite,nonatomic) NSURL *url;

@end

@implementation IBKImage

- (instancetype)initWithJSONObject:(NSDictionary *)jsonData error:(NSError *__autoreleasing *)error{
    
    if(self = [super init]) {
        
        if(![jsonData isKindOfClass:[NSDictionary class]]){
            
            
            return nil;
        } else if (!jsonData[@"id"] || !jsonData[@"link"]){
            

            return nil;
        }
        //clean NSNull
        jsonData = [jsonData IMG_cleanNull];
        
        _imageID = jsonData[@"id"];
        _title = jsonData[@"title"];
        _imageDescription = jsonData[@"description"];
        _type = jsonData[@"type"];
        _section = jsonData[@"section"];
        _animated = [jsonData[@"animated"] boolValue];
        _datetime = [NSDate dateWithTimeIntervalSince1970:[jsonData[@"datetime"] integerValue]];
        _deletehash = jsonData[@"deletehash"];
        _url = [NSURL URLWithString:jsonData[@"link"]];
        
        _width = [jsonData[@"width"] floatValue] / 2.0f;   //assume retina px scaling
        _height = [jsonData[@"height"] floatValue] / 2.0f; //assume retina px scaling
        _size = [jsonData[@"size"] integerValue];
        _views = [jsonData[@"views"] integerValue];
        _bandwidth = [jsonData[@"bandwidth"] integerValue];
        
        if (!_imageID || !_url){

            return nil;
        }
    }
    return self;
}

-(instancetype)initCoverImageWithAlbum:(IBKBaseAlbum*)album error:(NSError *__autoreleasing *)error
{
    if(self = [super init]){
        
        _imageID = album.coverID;
        _height = album.coverHeight;
        _width = album.coverWidth;
        
        //guess at url
        NSString * constructedStr = [NSString stringWithFormat:@"http://i.imgur.com/%@.jpg", _imageID];
        _url = [NSURL URLWithString:constructedStr];
        
        if (!album.coverID){
            return nil;
        }
    }
    return self;
}

-(IBKImage *)coverImage
{
    //for gallery image, the image is the cover image
    return self;
}

#pragma mark - Display

- (NSURL *)URLWithSize:(IBKSize)size{
    
    NSString *path = [[self.url absoluteString] stringByDeletingPathExtension];
    NSString *extension = [self.url pathExtension];
    NSString *stringURL;
    
    switch (size) {
        case IBKSmallSquareSize:
            stringURL = [NSString stringWithFormat:@"%@s.%@", path, extension];
            break;
            
        case IBKBigSquareSize:
            stringURL = [NSString stringWithFormat:@"%@b.%@", path, extension];
            break;
            
            //keeps image proportions below, please use these for better looking design
            
        case IBKSmallThumbnailSize:
            stringURL = [NSString stringWithFormat:@"%@t.%@", path, extension];
            break;
            
        case IBKMediumThumbnailSize:
            stringURL = [NSString stringWithFormat:@"%@m.%@", path, extension];
            break;
            
        case IBKLargeThumbnailSize:
            stringURL = [NSString stringWithFormat:@"%@l.%@", path, extension];
            break;
            
        case IBKHugeThumbnailSize:
            stringURL = [NSString stringWithFormat:@"%@h.%@", path, extension];
            break;
            
        default:
            stringURL = [NSString stringWithFormat:@"%@m.%@", path, extension];
            return nil;
    }
    return [NSURL URLWithString:stringURL];
}

@end
