//
//  NSString+HcdCustom.h
//  hcdViewPager
//
//  Created by funmitech-huangchengda on 15/11/18.
//  Copyright © 2015年 Polesapp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (HcdCustom)
- (CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
- (CGFloat)getHeightWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
- (CGFloat)getWidthWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
@end
