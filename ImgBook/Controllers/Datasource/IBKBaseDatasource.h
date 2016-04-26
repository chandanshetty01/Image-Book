//
//  IBKBaseDatasource.h
//  ImgBook
//
//  Created by Chandan Shetty SP on 10/4/16.
//  Copyright © 2016 Chandan Shetty SP. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IBKBaseDatasourceDelegates <NSObject>

-(void)newDataDidLoaded;
-(void)dataDidReset;

@end

@interface IBKBaseDatasource : NSObject

@property(nonatomic,weak)id<IBKBaseDatasourceDelegates> delegate;
@property(nonatomic,strong)NSMutableArray *objects;

-(void)loadDataForIndex:(NSInteger)index;
-(NSInteger)count;
-(id)dataAtIndex:(NSInteger)index;

-(void)reset;

@end
