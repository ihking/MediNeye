//
//  Utils.m
//  MediNeye
//
//  Created by HAN on 2016. 9. 30..
//  Copyright © 2016년 HAN. All rights reserved.
//

#import "Utils.h"


@implementation Utils

+ (CGFloat)getDeviceSize:(NSString *)type {
    CGFloat screenWidth;
    CGFloat screenHeight;
    CGRect screenRect;
    
    screenRect = [[UIScreen mainScreen] bounds];
    screenWidth = screenRect.size.width;
    screenHeight = screenRect.size.height;
    
    if([type isEqualToString:@"width"]) {
        return screenWidth;
    } else {
        return screenHeight;
    }
}

@end
