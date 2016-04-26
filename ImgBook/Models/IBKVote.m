//
//  IBKVote.m
//  ImgBook
//
//  Created by Chandan Shetty SP on 9/4/16.
//  Copyright © 2016 Chandan Shetty SP. All rights reserved.
//

#import "IBKVote.h"

@interface IBKVote ()

@property (readwrite, nonatomic) NSInteger ups;
@property (readwrite, nonatomic) NSInteger downs;

@end

@implementation IBKVote

+(NSString*)strForVote:(IBKVoteType)vote{
    NSString * str;
    switch (vote) {
        case IBKDownVote:
            str = @"down";
            break;
            
        case IBKUpVote:
            str = @"up";
            break;
        case IBKNeutralVote:
            str = @"";
            break;
        default:
            break;
    }
    return str;
}

+(IBKVoteType)voteForStr:(NSString*)voteStr{
    
    if([voteStr isEqualToString:@"up"])
        return IBKUpVote;
    else if([voteStr isEqualToString:@"down"])
        return IBKDownVote;
    else
        return IBKNeutralVote;
}

@end
