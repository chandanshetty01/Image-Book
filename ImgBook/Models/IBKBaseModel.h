//
//  IBKBaseModel.h
//  ImgBook
//
//  Created by Chandan Shetty SP on 9/4/16.
//  Copyright © 2016 Chandan Shetty SP. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface IBKBaseModel : NSObject

/**
 Common initializer for JSON HTTP response which processes the "data" JSON object into model object class
 @return initilialized instancetype object
 */
- (instancetype)initWithJSONObject:(NSDictionary *)jsonData error:(NSError *__autoreleasing *)error;

@end
