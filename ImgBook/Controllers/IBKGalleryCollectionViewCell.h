//
//  IBKGalleryCollectionViewCell.h
//  ImgBook
//
//  Created by Chandan Shetty SP on 9/4/16.
//  Copyright © 2016 Chandan Shetty SP. All rights reserved.
//

#import "IBKGalleryImage.h"

@interface IBKGalleryCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong)id<IBKGalleryObjectProtocol> imageModel;

@end
