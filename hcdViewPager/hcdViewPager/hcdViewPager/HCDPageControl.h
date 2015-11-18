//
//  ____    ___   _        ___  _____  ____  ____  ____
// |    \  /   \ | T      /  _]/ ___/ /    T|    \|    \
// |  o  )Y     Y| |     /  [_(   \_ Y  o  ||  o  )  o  )
// |   _/ |  O  || l___ Y    _]\__  T|     ||   _/|   _/
// |  |   |     ||     T|   [_ /  \ ||  _  ||  |  |  |
// |  |   l     !|     ||     T\    ||  |  ||  |  |  |
// l__j    \___/ l_____jl_____j \___jl__j__jl__j  l__j
//
//
//	Powered by Polesapp.com
//
//
//  HCDPageControl.h
//  hcdViewPager
//
//  Created by funmitech-huangchengda on 15/11/18.
//  Copyright © 2015年 Polesapp. All rights reserved.
//

/**
 *  点击左右切换的pageControl
 */

#import <UIKit/UIKit.h>

typedef void(^HCDPageControlBlock)(NSInteger index);

@class HCDPageControl;

@protocol HCDPageControlDelegate <NSObject>

- (void)pageControl:(HCDPageControl *)pageControl selectedIndex:(NSInteger)index;

@end

@interface HCDPageControl : UIView

@property (nonatomic) NSInteger currentIndex;

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items delegate:(id<HCDPageControlDelegate>)delegate;
- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items selectedBlock:(HCDPageControlBlock)selectedHandle;
- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items withIcon:(BOOL)withIcon selectedBlock:(HCDPageControlBlock)selectedHandle;

- (void)selectIndex:(NSInteger)index;

- (void)moveIndexWithProgress:(float)progress;

- (void)endMoveIndex:(NSInteger)index;

- (void)setTitle:(NSString *)title withIndex:(NSInteger)index;

@end
