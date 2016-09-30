//
//  UIFont+Utils.m
//  wonnight
//
//  Created by pgonee on 2014. 6. 5..
//  Copyright (c) 2014년 ant-holdings. All rights reserved.
//

#import "UIFont+Utils.h"

@implementation UIFont (Utils)

+ (UIFont*) defaultRegular:(float)size {
    return [UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:size];
}

+ (UIFont*) defaultMedium:(float)size {
    return [UIFont fontWithName:@"AppleSDGothicNeo-Medium" size:size];
}

+ (UIFont*) defaultSemiBold:(float)size {
    return [UIFont fontWithName:@"AppleSDGothicNeo-SemiBold" size:size];
}

+ (UIFont*) defaultBold:(float)size {
    return [UIFont fontWithName:@"AppleSDGothicNeo-Bold" size:size];
}

+ (UIFont*) defaultThin:(float)size {
    return [UIFont fontWithName:@"AppleSDGothicNeo-Thin" size:size];
}

+ (UIFont*) defaultLight:(float)size {
    return [UIFont fontWithName:@"AppleSDGothicNeo-Light" size:size];
}

@end
