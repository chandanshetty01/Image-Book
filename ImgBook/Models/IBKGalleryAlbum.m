//
//  IBKGalleryAlbum.m
//  ImgBook
//
//  Created by Chandan Shetty SP on 9/4/16.
//  Copyright © 2016 Chandan Shetty SP. All rights reserved.
//

#import "IBKGalleryAlbum.h"
#import "IBKImage.h"

@interface IBKGalleryAlbum ()

@property (readwrite, nonatomic) IBKVoteType vote;
@property (readwrite, nonatomic) NSString *section;
@property (readwrite, nonatomic) NSInteger ups;
@property (readwrite, nonatomic) NSInteger downs;
@property (readwrite, nonatomic) NSInteger score;
@property (readwrite, nonatomic) BOOL favorite;
@property (readwrite, nonatomic) BOOL nsfw;

@end

@implementation IBKGalleryAlbum


@end
