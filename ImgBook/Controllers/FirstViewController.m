//
//  FirstViewController.m
//  ImgBook
//
//  Created by Chandan Shetty SP on 9/4/16.
//  Copyright © 2016 Chandan Shetty SP. All rights reserved.
//

#import "FirstViewController.h"
#import "IBKGalleryRequest.h"
#import "IBKSession.h"
#import "IBKGalleryCollectionViewCell.h"
#import "IBKGalleryImagesDataSource.h"
#import "RWDropdownMenu.h"
#import "IBKImageDetailViewController.h"

typedef enum : NSUInteger {
    IBKViewModeTypeList,
    IBKViewModeTypeGrid,
    IBKViewModeListTypeStaggard,
} IBKViewModeType;

#define kCollectionViewID @"IBKGalleryCollectionViewCell"

@interface FirstViewController () <IBKBaseDatasourceDelegates>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property(nonatomic,strong)IBKGalleryImagesDataSource *dataSource;

@property(nonatomic,assign)IBKViewModeType viewModeType;

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupMenu];

    self.viewModeType = IBKViewModeTypeGrid;
    
    // Do any additional setup after loading the view, typically from a nib.
    self.dataSource = [[IBKGalleryImagesDataSource alloc] init];
    self.dataSource.gallerySectionType = IMGGallerySectionTypeHot;
    self.dataSource.isViral = YES;
    self.dataSource.delegate = self;
    [self.dataSource loadDataForIndex:0];
}

-(void)setupMenu
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"viral"
                                                                                 style:UIBarButtonItemStylePlain
                                                                                target:self action:@selector(presentSortOptionsMenu:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Grid"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self action:@selector(presentDifferentViewModeMenu:)];
    
    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [titleButton setImage:[[UIImage imageNamed:@"nav_down"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [titleButton setTitle:@"Hot" forState:UIControlStateNormal];
    [titleButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, -5)];
    [titleButton addTarget:self action:@selector(presentGallerySectionSelectionMenu:) forControlEvents:UIControlEventTouchUpInside];
    [titleButton sizeToFit];
    self.navigationItem.titleView = titleButton;
}

- (void)presentSortOptionsMenu:(id)sender
{
    NSAttributedString *(^attributedTitle)(NSString *title) = ^NSAttributedString *(NSString *title) {
        UIColor *textColor = [UIColor lightTextColor];
        return [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:textColor, NSFontAttributeName:[UIFont fontWithName:@"Avenir" size:17.0f]}];
    };
    
    __weak FirstViewController *weakSelf = self;
    NSArray *styleItems =
    @[
      [RWDropdownMenuItem itemWithAttributedText:attributedTitle(@"Viral") image:nil action:^{
          [weakSelf.navigationItem.leftBarButtonItem setTitle:@"Viral"];
          weakSelf.dataSource.isViral = YES;
      }],
      [RWDropdownMenuItem itemWithAttributedText:attributedTitle(@"Non-Viral") image:nil action:^{
          [weakSelf.navigationItem.leftBarButtonItem setTitle:@"Non-Viral"];
          weakSelf.dataSource.isViral = NO;
      }]
      ];
    
    [RWDropdownMenu presentFromViewController:self withItems:styleItems align:RWDropdownMenuCellAlignmentCenter style:RWDropdownMenuStyleTranslucent navBarImage:nil completion:nil];
}

- (void)presentDifferentViewModeMenu:(id)sender
{
    NSAttributedString *(^attributedTitle)(NSString *title) = ^NSAttributedString *(NSString *title) {
        UIColor *textColor = [UIColor lightTextColor];
        return [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:textColor, NSFontAttributeName:[UIFont fontWithName:@"Avenir" size:17.0f]}];
    };
    
    __weak FirstViewController *weakSelf = self;
    NSArray *styleItems =
    @[
      [RWDropdownMenuItem itemWithAttributedText:attributedTitle(@"List") image:nil action:^{
          [weakSelf.navigationItem.rightBarButtonItem setTitle:@"List"];
          weakSelf.viewModeType = IBKViewModeTypeList;
      }],
      [RWDropdownMenuItem itemWithAttributedText:attributedTitle(@"Grid") image:nil action:^{
          [weakSelf.navigationItem.rightBarButtonItem setTitle:@"Grid"];
          weakSelf.viewModeType = IBKViewModeTypeGrid;
      }],
      [RWDropdownMenuItem itemWithAttributedText:attributedTitle(@"Staggard") image:nil action:^{
          [weakSelf.navigationItem.rightBarButtonItem setTitle:@"Staggard"];
          weakSelf.viewModeType = IBKViewModeListTypeStaggard;
      }]
      ];
    
    [RWDropdownMenu presentFromViewController:self withItems:styleItems align:RWDropdownMenuCellAlignmentCenter style:RWDropdownMenuStyleTranslucent navBarImage:nil completion:nil];
}

-(void)presentGallerySectionSelectionMenu:(id)sender
{
    NSAttributedString *(^attributedTitle)(NSString *title) = ^NSAttributedString *(NSString *title) {
        UIColor *textColor = [UIColor lightTextColor];
        return [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:textColor, NSFontAttributeName:[UIFont fontWithName:@"Avenir" size:17.0f]}];
    };
    
    UIButton *titleButton = (UIButton*)self.navigationItem.titleView;

    NSArray *styleItems =
    @[
      [RWDropdownMenuItem itemWithAttributedText:attributedTitle(@"Hot") image:nil action:^{
          [titleButton setTitle:@"Hot" forState:UIControlStateNormal];
          [titleButton sizeToFit];
          self.dataSource.gallerySectionType = IMGGallerySectionTypeHot;
      }],
      [RWDropdownMenuItem itemWithAttributedText:attributedTitle(@"Top") image:nil action:^{
          [titleButton setTitle:@"Top" forState:UIControlStateNormal];
          [titleButton sizeToFit];
          self.dataSource.gallerySectionType = IMGGallerySectionTypeTop;
      }],
      [RWDropdownMenuItem itemWithAttributedText:attributedTitle(@"User") image:nil action:^{
          [titleButton setTitle:@"User" forState:UIControlStateNormal];
          [titleButton sizeToFit];
          self.dataSource.gallerySectionType = IMGGallerySectionTypeUser;
      }],
      ];
    
    [RWDropdownMenu presentFromViewController:self withItems:styleItems align:RWDropdownMenuCellAlignmentCenter style:RWDropdownMenuStyleTranslucent navBarImage:nil completion:nil];
}

#pragma mark - Datasource callbacks -

-(void)newDataDidLoaded
{
    [self.collectionView reloadData];
}

-(void)dataDidReset
{
    [self.collectionView setContentOffset:CGPointZero animated:YES];
}

#pragma mark - Collection View delegates - 

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataSource count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (IBKGalleryCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    IBKGalleryCollectionViewCell *cell = (IBKGalleryCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:kCollectionViewID forIndexPath:indexPath];
    
    id model = [self.dataSource dataAtIndex:[indexPath row]];
    cell.imageModel = model;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ScrollView delegates

// called on start of dragging (may require some time and or distance to move)
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}

// called on finger up if the user dragged. decelerate is true if it will continue moving afterwards
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(!decelerate){
        [[self navigationController] setNavigationBarHidden:NO animated:YES];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
}

#pragma mark - storyboard - 

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"detailImageController"]){
        IBKImageDetailViewController *controller = (IBKImageDetailViewController *)segue.destinationViewController;
        IBKGalleryCollectionViewCell *cell = sender;
        controller.imageModel = cell.imageModel;
    }
}

@end
