//
//  UIColor+Utils.h
//  wonnight
//
//  Created by pgonee on 2014. 6. 5..
//  Copyright (c) 2014년 ant-holdings. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Utils)

+ (UIColor *) colorWithHexString:(NSString *)hexstr;
+ (UIColor *) colorWithHexValue: (NSInteger) rgbValue;

@end
