//
//  IBKImageDetailViewController.m
//  ImgBook
//
//  Created by Chandan Shetty SP on 10/4/16.
//  Copyright © 2016 Chandan Shetty SP. All rights reserved.
//

#import "IBKImageDetailViewController.h"
#import "UIImageView+AFNetworking.h"

@interface IBKImageDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *descriptionHolderView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *upvoteLabel;
@property (weak, nonatomic) IBOutlet UILabel *downVoteLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end

@implementation IBKImageDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    IBKImage *image = [self.imageModel coverImage];
    self.titleLabel.text = image.title;
    self.descriptionLabel.text = image.imageDescription;
    
    self.upvoteLabel.text = [NSString stringWithFormat:@"ups: %ld",(long)[self.imageModel ups]];
    self.scoreLabel.text = [NSString stringWithFormat:@"score: %ld",(long)[self.imageModel score]];
    self.downVoteLabel.text = [NSString stringWithFormat:@"downs: %ld",(long)[self.imageModel downs]];
    
    [self.imageView setImageWithURL:image.url placeholderImage:[UIImage imageNamed:@"placeholder"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    NSLog(@"");
}

@end
