//
//  IBKBaseDatasource.m
//  ImgBook
//
//  Created by Chandan Shetty SP on 10/4/16.
//  Copyright © 2016 Chandan Shetty SP. All rights reserved.
//

#import "IBKBaseDatasource.h"

@interface IBKBaseDatasource ()

@end

@implementation IBKBaseDatasource

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.objects = [NSMutableArray array];
    }
    return self;
}

-(void)loadDataForIndex:(NSInteger)index
{
    //subclass should overhide
}

-(NSInteger)count
{
    return self.objects.count;
}

-(void)reset
{
    [self.objects removeAllObjects];
    if(self.delegate && [self.delegate respondsToSelector:@selector(dataDidReset)]){
        [self.delegate dataDidReset];
    }
    [self loadDataForIndex:0];
}

-(BOOL)validateIndex:(NSInteger)index
{
    if(index >= 0 && index < self.objects.count){
        return TRUE;
    }
    else{
        return FALSE;
    }
}

-(id)dataAtIndex:(NSInteger)index
{
    id object = nil;
    if(index >= self.objects.count-1){
        //Trying to access the last object so load again
        [self loadDataForIndex:self.objects.count];
    }

    if([self validateIndex:index]){
        object = [self.objects objectAtIndex:index];
    }
    return object;
}

@end
