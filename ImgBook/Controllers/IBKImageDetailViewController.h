//
//  IBKImageDetailViewController.h
//  ImgBook
//
//  Created by Chandan Shetty SP on 10/4/16.
//  Copyright © 2016 Chandan Shetty SP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IBKGalleryImage.h"

@interface IBKImageDetailViewController : UIViewController

@property(nonatomic,strong)id<IBKGalleryObjectProtocol> imageModel;

@end
