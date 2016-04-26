//
//  SecondViewController.m
//  ImgBook
//
//  Created by Chandan Shetty SP on 9/4/16.
//  Copyright © 2016 Chandan Shetty SP. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()
@property (weak, nonatomic) IBOutlet UILabel *appNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
@property (weak, nonatomic) IBOutlet UILabel *buildTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *AuthorLabel;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *versionNumber = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    
    NSString *compileDate = [NSString stringWithUTF8String:__DATE__];
    NSString *compileTime = [NSString stringWithUTF8String:__TIME__];
    self.buildTimeLabel.text = [NSString stringWithFormat:@"%@,%@",compileDate,compileTime];
    
    self.versionLabel.text = versionNumber;
    self.AuthorLabel.text = @"chandanshetty01@gmail.com";

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
