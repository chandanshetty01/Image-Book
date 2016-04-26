//
//  IBKGalleryAlbum.h
//  ImgBook
//
//  Created by Chandan Shetty SP on 9/4/16.
//  Copyright © 2016 Chandan Shetty SP. All rights reserved.
//

#import "IBKBaseAlbum.h"
#import "IBKVote.h"

@interface IBKGalleryAlbum : IBKBaseAlbum

/**
 Users up or down vote on the image
 */
@property (nonatomic, readonly) IBKVoteType vote;
/**
 Section description of album
 */
@property (nonatomic, readonly, copy) NSString *section;
/**
 Global up votes
 */
@property (nonatomic, readonly) NSInteger ups;
/**
 Global down votes
 */
@property (nonatomic, readonly) NSInteger downs;
/**
 Up votes minus down vote.
 */
@property (nonatomic, readonly) NSInteger score;
/**
 Has the user favorited?
 */
@property (nonatomic, readonly) BOOL favorite;
/**
 Is it flagged NSFW>
 */
@property (nonatomic, readonly) BOOL nsfw;

@end
