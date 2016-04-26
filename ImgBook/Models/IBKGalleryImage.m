//
//  IBKGalleryImage.m
//  ImgBook
//
//  Created by Chandan Shetty SP on 9/4/16.
//  Copyright © 2016 Chandan Shetty SP. All rights reserved.
//

#import "IBKGalleryImage.h"
#import "IBKVote.h"

@interface IBKGalleryImage ()

@property (readwrite, nonatomic) IBKVoteType vote;
@property (readwrite, nonatomic) NSString *accountURL;
@property (readwrite, nonatomic) NSInteger ups;
@property (readwrite, nonatomic) NSInteger downs;
@property (readwrite, nonatomic) NSInteger score;
@property (readwrite, nonatomic) BOOL favorite;
@property (readwrite, nonatomic) BOOL nsfw;

@end

@implementation IBKGalleryImage

- (instancetype)initWithJSONObject:(NSDictionary *)jsonData error:(NSError *__autoreleasing *)error
{
    self = [super initWithJSONObject:jsonData error:error];
    
    if(self && !*error) {
        if(![jsonData isKindOfClass:[NSDictionary class]]){
            return nil;
        }
        //clean NSNull
        jsonData = [jsonData IMG_cleanNull];
        
        _ups = [jsonData[@"ups"] integerValue];
        _downs = [jsonData[@"downs"] integerValue];
        _score = [jsonData[@"score"] integerValue];
        _accountURL = jsonData[@"account_url"];
        _vote = [IBKVote voteForStr:jsonData[@"vote"]];
        _nsfw = [jsonData[@"nsfw"] boolValue];
        _favorite = [jsonData[@"favorite"] boolValue];
    }
    return self;
}

-(IBKImage *)coverImage
{
    //for gallery image, the image is the cover image
    return self;
}

@end
