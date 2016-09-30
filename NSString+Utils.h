//
//  NSString+Utils.h
//  wonnight
//
//  Created by pgonee on 2014. 6. 3..
//  Copyright (c) 2014년 ant-holdings. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Utils)

- (BOOL)containsString:(NSString *)string
               options:(NSStringCompareOptions)options;
- (BOOL)containsString:(NSString *)string;

- (NSString*)sha1;
- (NSString*)urlDecode;
- (NSString*)urlEncode;
- (NSString*)removeAll:(NSString*)text;
- (BOOL) isEmail;
-(NSString *)htmlEntityDecode;
-(NSString *) stringByStrippingHTML;

@end
