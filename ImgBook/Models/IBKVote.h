//
//  IBKVote.h
//  ImgBook
//
//  Created by Chandan Shetty SP on 9/4/16.
//  Copyright © 2016 Chandan Shetty SP. All rights reserved.
//

#import "IBKBaseModel.h"

typedef NS_ENUM(NSInteger, IBKVoteType) {
    IBKDownVote      = -1,
    IBKNeutralVote   = 0,
    IBKUpVote        = 1
};

@interface IBKVote : IBKBaseModel

/**
 up votes
 */
@property (readonly,nonatomic) NSInteger ups;
/**
 down votes
 */
@property (readonly,nonatomic) NSInteger downs;

/**
 Return string for vote value
 @param vote enumerated value with IMGVoteType
 @return string description of vote as per https://api.imgur.com/endpoints/gallery#gallery-voting specifications
 */
+(NSString*)strForVote:(IBKVoteType)vote;
/**
 Return NSInteger from enumerable representing input string
 @param voteStr string description of vote type
 @return integer representing this vote
 */
+(IBKVoteType)voteForStr:(NSString*)voteStr;

@end
