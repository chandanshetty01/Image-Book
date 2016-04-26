//
//  IBKBaseAlbum.m
//  ImgBook
//
//  Created by Chandan Shetty SP on 9/4/16.
//  Copyright © 2016 Chandan Shetty SP. All rights reserved.
//

#import "IBKBaseAlbum.h"
#import "IBKImage.h"

@interface IBKBaseAlbum ()

@property (readwrite,nonatomic) NSString *albumID;
@property (readwrite,nonatomic) NSString *title;
@property (readwrite,nonatomic) NSString *albumDescription;
@property (readwrite,nonatomic) NSDate *datetime;
@property (readwrite,nonatomic) NSString *coverID;
@property (readwrite,nonatomic) CGFloat coverWidth;
@property (readwrite,nonatomic) CGFloat coverHeight;
@property (readwrite,nonatomic) NSString *accountURL;
@property (readwrite,nonatomic) NSString *privacy;
@property (readwrite,nonatomic) NSInteger views;
@property (readwrite,nonatomic) NSURL *url;
@property (readwrite,nonatomic) NSInteger imagesCount;
@property (readwrite,nonatomic) NSArray *images;

@end

@implementation IBKBaseAlbum

- (instancetype)initWithJSONObject:(NSDictionary *)jsonData error:(NSError *__autoreleasing *)error
{
    
    if(self = [super init]) {
        
        if(![jsonData isKindOfClass:[NSDictionary class]]){
            
            if(error){
                return nil;
            }
        }
        //clean NSNull
        jsonData = [jsonData IMG_cleanNull];
        
        _albumID = jsonData[@"id"];
        _title = jsonData[@"title"];
        _albumDescription = jsonData[@"description"];
        _datetime = [NSDate dateWithTimeIntervalSince1970:[jsonData[@"datetime"] integerValue]];
        _coverID = jsonData[@"cover"];
        _coverHeight = [jsonData[@"cover_height"] floatValue] / 2.0f;  //assume retina px scaling
        _coverWidth = [jsonData[@"cover_width"] floatValue] / 2.0f;    //assume retina px scaling
        _accountURL = jsonData[@"account_url"];
        _privacy = jsonData[@"privacy"];
        _views = [jsonData[@"views"] integerValue];
        _url = [NSURL URLWithString:jsonData[@"link"]];
        _imagesCount = [jsonData[@"images_count"] integerValue];
        
        //intrepret images if available
        NSMutableArray * images = [NSMutableArray new];
        for(NSDictionary * imageJSON in jsonData[@"images"]){
            
            NSError *JSONError = nil;
            IBKImage * image = [[IBKImage alloc] initWithJSONObject:imageJSON error:&JSONError];
            
            if(!JSONError && image){
                [images addObject:image];
            }
        }
        _images = [NSArray arrayWithArray:images];
        
        if(!_images.count && _coverID){
            //construct cover if not available
            IBKImage * cover  = [[IBKImage alloc] initCoverImageWithAlbum:self error:error];
            [self setCoverImage:cover];
        }
        
        if (!_albumID || !_coverID){
            return nil;
        }
    }
    return self;
}

-(void)setCoverImage:(IBKImage*)coverImage
{
    
    if([self.images containsObject:coverImage])
        return;
    else {
        
        NSMutableArray * marray = [NSMutableArray arrayWithArray:self.images];
        [marray addObject:coverImage];
        self.images = [NSArray arrayWithArray:marray];
    }
}

-(IBKImage *)coverImage
{
    //image should be included in the images array
    __block IBKImage * cover = nil;
    
    [self.images enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        IBKImage * img = obj;
        
        if([self.coverID isEqualToString:img.imageID]){
            //this is the cover
            cover = img;
            *stop = YES;
        }
    }];
    
    return cover;
}

@end
