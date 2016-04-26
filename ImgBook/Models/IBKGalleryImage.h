//
//  IBKGalleryImage.h
//  ImgBook
//
//  Created by Chandan Shetty SP on 9/4/16.
//  Copyright © 2016 Chandan Shetty SP. All rights reserved.
//

#import "IBKImage.h"
#import "IBKVote.h"

/**
 Protocol to represent both IMGGalleryImage and IMGGalleryAlbum which contain similar information.
 */
@protocol IBKGalleryObjectProtocol <IBKObjectProtocol>

@optional

/**
 Has the user favorited the object, false if anon
 */
-(BOOL)isFavorite;
/**
 Is it safe for work?
 */
-(BOOL)isNSFW;
/**
 The user's vote for the object, if authenticated
 */
-(IBKVoteType)usersVote;
/**
 ID for the gallery object
 */
-(NSString*)objectID;
/**
 Score
 */
-(NSInteger)score;
/**
 Ups
 */
-(NSInteger)ups;
/**
 downs
 */
-(NSInteger)downs;
/**
 Username who submitted this gallery image or album.
 */
-(NSString*)fromUsername;
/**
 Sets users vote
 */
-(void)setUsersVote:(IBKVoteType)vote;
/**
 Sets users fav
 */
-(void)setUsersFav:(BOOL)faved;


@end

@interface IBKGalleryImage : IBKImage <IBKGalleryObjectProtocol>

/**
 Users up or down vote on the image
 */
@property (nonatomic, readonly) IBKVoteType vote;
/**
 Username of submitter if not anon
 */
@property (nonatomic, readonly, copy) NSString *accountURL;
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

