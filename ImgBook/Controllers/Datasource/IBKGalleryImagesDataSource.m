//
//  IBKGalleryImagesDataSource.m
//  ImgBook
//
//  Created by Chandan Shetty SP on 10/4/16.
//  Copyright © 2016 Chandan Shetty SP. All rights reserved.
//

#import "IBKGalleryImagesDataSource.h"
#import "IBKGalleryRequest.h"

const NSInteger kPerPageCount = 60;

@interface IBKGalleryImagesDataSource()

@property(nonatomic,assign)BOOL isLoading;

@end

@implementation IBKGalleryImagesDataSource

-(void)setGallerySectionType:(IMGGallerySectionType)gallerySectionType
{
    if(_gallerySectionType != gallerySectionType){
        _gallerySectionType = gallerySectionType;
        
        self.isLoading = NO;
        [self reset];
    }
}

-(void)setIsViral:(BOOL)isViral
{
    if(_isViral != isViral){
        _isViral = isViral;
        
        self.isLoading = NO;
        [self reset];
    }
}

-(void)loadDataForIndex:(NSInteger)index
{
    if(index >= 0 && index >= self.objects.count && !self.isLoading){
        self.isLoading = YES;
        NSInteger pageNumber = index%kPerPageCount;
        
        [IBKGalleryRequest galleryPage:pageNumber
                                  type:self.gallerySectionType
                               perPage:kPerPageCount
                                 viral:self.isViral
                            withWindow:IMGTopGalleryWindowAll
                               success:^(NSArray *objects) {
                                   self.isLoading = NO;
                                   
                                   [self.objects addObjectsFromArray:objects];
                                   if(self.delegate && [self.delegate respondsToSelector:@selector(newDataDidLoaded)]){
                                       [self.delegate newDataDidLoaded];
                                   }
                               }
                               failure:^(NSError *error) {
                                   self.isLoading = NO;
                               }];
    }
}


@end
