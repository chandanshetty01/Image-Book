//
//  IBKGalleryCollectionViewCell.m
//  ImgBook
//
//  Created by Chandan Shetty SP on 9/4/16.
//  Copyright © 2016 Chandan Shetty SP. All rights reserved.
//

#import "IBKGalleryCollectionViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "FTThumbnailCacheManager.h"

@interface IBKGalleryCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation IBKGalleryCollectionViewCell

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.imageView.contentMode = UIViewContentModeCenter;
    }
    return self;
}

-(void)setImageModel:(id<IBKGalleryObjectProtocol>)imageModel
{
    _imageModel = imageModel;
    IBKImage *actualImageModel = [imageModel coverImage];
    
    self.label.text = actualImageModel.title;
    NSURL * coverURL = [actualImageModel URLWithSize:IBKMediumThumbnailSize];
    
    [self reset];
    __weak IBKGalleryCollectionViewCell *weakSelf = self;
    [self setImageForImageView:coverURL
                       failure:^(NSURLRequest *request, NSHTTPURLResponse * _Nullable response, NSError *error) {
                           //Try big image
                           [weakSelf setImageForImageView:actualImageModel.url
                                                  failure:nil];
                       }];
}

-(void)setImageForImageView:(NSURL*)url failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse * _Nullable response, NSError *error))block
{
    UIImage *image = [[FTThumbnailCacheManager sharedManager] imageForURL:url];
    if(!image){
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request addValue:@"image/*" forHTTPHeaderField:@"Accept"];
        
        [self.imageView setImageWithURLRequest:request
                              placeholderImage:[UIImage imageNamed:@"placeholder"]
                                       success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
                                           [[FTThumbnailCacheManager sharedManager] cacheImage:image forURL:url];
                                           [self.imageView setImage:image];
                                       }
                                       failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error){
                                           if(block){
                                               block(request,response,error);
                                           }
                                       }];
    }
    else{
        [self.imageView setImage:image];
    }
}

-(void)reset
{
    [self.imageView cancelImageDownloadTask];
    [self.imageView setImage:nil];
}

- (void)dealloc
{
    [self reset];
}

@end
