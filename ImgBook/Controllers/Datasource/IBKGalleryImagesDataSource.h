//
//  IBKGalleryImagesDataSource.h
//  ImgBook
//
//  Created by Chandan Shetty SP on 10/4/16.
//  Copyright © 2016 Chandan Shetty SP. All rights reserved.
//

#import "IBKBaseDatasource.h"
#import "IBKGalleryRequest.h"

@interface IBKGalleryImagesDataSource : IBKBaseDatasource

@property(nonatomic,assign)IMGGallerySectionType gallerySectionType;
@property(nonatomic,assign)BOOL isViral;

@end
