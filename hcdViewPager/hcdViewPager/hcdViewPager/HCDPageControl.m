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
//  HCDPageControl.m
//  hcdViewPager
//
//  Created by funmitech-huangchengda on 15/11/18.
//  Copyright © 2015年 Polesapp. All rights reserved.
//

#import "HCDPageControl.h"
#import "UIColor+HcdCustom.h"
#import "UIView+HcdCustom.h"

#define kHCDPageControlItemFont (15)
#define kHCDPageControlHSpace (0)
#define kHCDPageControlLineHeight (2)
#define kHCDPageControlAnimationTime (0.3)
#define kHCDPageControlIconWidth (50)
#define kHCDPageControlIconSpace (4)
#define kScreen_Height [UIScreen mainScreen].bounds.size.height
#define kScreen_Width [UIScreen mainScreen].bounds.size.width

typedef NS_ENUM(NSInteger, HCDPageControlItemType)
{
    HCDPageControlItemTypeTitle = 0,
    HCDPageControlItemTypeIconUrl,
    HCDPageControlItemTypeTitleAndIcon
};

@interface HCDPageControlItem : UIView

@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UIImageView * titleIconView;
@property (nonatomic, assign) HCDPageControlItemType type;

- (void)setSelected:(BOOL)selected;
@end

@implementation HCDPageControlItem

- (id)initWithFrame:(CGRect)frame title:(NSString *)title type:(HCDPageControlItemType)type
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _type = type;
        switch (_type) {
            case HCDPageControlItemTypeIconUrl:
            {
                _titleIconView = [[UIImageView alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.bounds)-40)/2, (CGRectGetHeight(self.bounds)-40)/2, 40, 40)];
                [_titleIconView doCircleFrame];
                if (title) {
                    
                }else{
                    [_titleIconView setImage:[UIImage imageNamed:@"tasks_all"]];
                }
                [self addSubview:_titleIconView];
            }
                break;
            case HCDPageControlItemTypeTitleAndIcon:
            {
                _titleLabel = ({
                    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
                    
                    label.font = [UIFont systemFontOfSize:kHCDPageControlItemFont];
                    label.textAlignment = NSTextAlignmentCenter;
                    label.text = title;
                    label.textColor = [UIColor colorWithHexString:@"0x222222"];
                    label.backgroundColor = [UIColor clearColor];
                    [label sizeToFit];
                    if (label.frame.size.width > CGRectGetWidth(self.bounds) - kHCDPageControlIconSpace - 10) {
                        CGRect frame = label.frame;
                        frame.size.width = CGRectGetWidth(self.bounds) - kHCDPageControlIconSpace - 10;
                        label.frame = frame;
                    }
                    label.center = CGPointMake((CGRectGetWidth(self.bounds) - kHCDPageControlIconSpace - 10) * 0.5, CGRectGetHeight(self.bounds) * 0.5);
                    label;
                });
                
                [self addSubview:_titleLabel];
                
                CGFloat x = CGRectGetMaxX(_titleLabel.frame) + kHCDPageControlIconSpace;
                _titleIconView = [[UIImageView alloc] initWithFrame:CGRectMake(x, (CGRectGetHeight(self.bounds) - 10) * 0.5, 10, 10)];
                [_titleIconView setImage:[UIImage imageNamed:@"tag_list_up"]];
                [self addSubview:_titleIconView];
            }
                break;
            case HCDPageControlItemTypeTitle:
            default:
            {
                _titleLabel = ({
                    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kHCDPageControlHSpace, 0, CGRectGetWidth(self.bounds) - 2 * kHCDPageControlHSpace, CGRectGetHeight(self.bounds))];
                    label.font = [UIFont systemFontOfSize:kHCDPageControlItemFont];
                    label.textAlignment = NSTextAlignmentCenter;
                    label.text = title;
                    label.textColor = [UIColor colorWithHexString:@"0x222222"];
                    label.backgroundColor = [UIColor clearColor];
                    label;
                });
                
                [self addSubview:_titleLabel];
            }
                break;
        }
    }
    return self;
}

- (void)setSelected:(BOOL)selected
{
    switch (_type) {
        case HCDPageControlItemTypeIconUrl:
        {
        }
            break;
        case HCDPageControlItemTypeTitleAndIcon:
        {
            if (_titleLabel) {
                [_titleLabel setTextColor:(selected ? [UIColor colorWithHexString:@"0x1488F4"]:[UIColor colorWithHexString:@"0x222222"])];
            }
            if (_titleIconView) {
                [_titleIconView setImage:[UIImage imageNamed: selected ? @"tag_list_down" : @"tag_list_up"]];
            }
        }
            break;
        default:
        {
            if (_titleLabel) {
                [_titleLabel setTextColor:(selected ? [UIColor colorWithHexString:@"0x1488F4"]:[UIColor colorWithHexString:@"0x222222"])];
            }
        }
            break;
    }
}

- (void)resetTitle:(NSString *)title
{
    if (_titleLabel) {
        _titleLabel.text = title;
    }
    if (_type == HCDPageControlItemTypeTitleAndIcon) {
        [_titleLabel sizeToFit];
        if (_titleLabel.frame.size.width > CGRectGetWidth(self.bounds) - kHCDPageControlIconSpace - 10) {
            CGRect frame = _titleLabel.frame;
            frame.size.width = CGRectGetWidth(self.bounds) - kHCDPageControlIconSpace - 10;
            _titleLabel.frame = frame;
        }
        _titleLabel.center = CGPointMake((CGRectGetWidth(self.bounds) - kHCDPageControlIconSpace - 10) * 0.5, CGRectGetHeight(self.bounds) * 0.5);
        
        CGRect frame = _titleIconView.frame;
        frame.origin.x = CGRectGetMaxX(_titleLabel.frame) + kHCDPageControlIconSpace;
        _titleIconView.frame = frame;
    }
}

@end

@interface HCDPageControl()<UIScrollViewDelegate>

@property (nonatomic , strong) UIScrollView *contentView;

@property (nonatomic , strong) UIView *leftShadowView;

@property (nonatomic , strong) UIView *rightShadowView;

@property (nonatomic , strong) UIView *lineView;

@property (nonatomic , strong) NSMutableArray *itemFrames;

@property (nonatomic , strong) NSMutableArray *items;

@property (nonatomic , weak) id <HCDPageControlDelegate> delegate;

@property (nonatomic , copy) HCDPageControlBlock block;

@end

@implementation HCDPageControl

- (id)initWithFrame:(CGRect)frame items:(NSArray *)titleItem withIcon:(BOOL)withIcon
{
    if (self = [super initWithFrame:frame]) {
        [self initUIWith:withIcon Items:titleItem];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame items:(NSArray *)titleItem
{
    if (self = [super initWithFrame:frame]) {
        [self initUIWith:NO Items:titleItem];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items delegate:(id<HCDPageControlDelegate>)delegate
{
    if (self = [self initWithFrame:frame items:items]) {
        self.delegate = delegate;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items selectedBlock:(HCDPageControlBlock)selectedHandle
{
    if (self = [self initWithFrame:frame items:items]) {
        self.block = selectedHandle;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items withIcon:(BOOL)withIcon selectedBlock:(HCDPageControlBlock)selectedHandle
{
    if (self = [self initWithFrame:frame items:items withIcon:withIcon]) {
        self.block = selectedHandle;
    }
    return self;
}

- (void)doTap:(UITapGestureRecognizer *)sender
{
    CGPoint point = [sender locationInView:sender.view];
    
    __weak typeof(self) weakSelf = self;
    
    [_itemFrames enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        CGRect rect = [obj CGRectValue];
        
        if (CGRectContainsPoint(rect, point)) {
            
            [weakSelf selectIndex:idx];
            
            [weakSelf transformAction:idx];
            
            *stop = YES;
        }
    }];
}

- (void)transformAction:(NSInteger)index
{
    if (self.delegate && [self.delegate conformsToProtocol:@protocol(HCDPageControlDelegate)] && [self.delegate respondsToSelector:@selector(pageControl:selectedIndex:)]) {
        
        [self.delegate pageControl:self selectedIndex:index];
        
    }else if (self.block) {
        
        self.block(index);
    }
}

- (void)initUIWith:(BOOL)isIcon Items:(NSArray *)titleItem
{
    _contentView = ({
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        scrollView.backgroundColor = [UIColor clearColor];
        scrollView.delegate = self;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.scrollsToTop = NO;
        [self addSubview:scrollView];
        
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doTap:)];
        [scrollView addGestureRecognizer:tapGes];
        [tapGes requireGestureRecognizerToFail:scrollView.panGestureRecognizer];
        scrollView;
    });
    
    [self initItemsWithTitleArray:titleItem withIcon:isIcon];
}

- (void)initItemsWithTitleArray:(NSArray *)titleArray withIcon:(BOOL)withIcon
{
    _itemFrames = @[].mutableCopy;
    _items = @[].mutableCopy;
    float y = 0;
    float height = CGRectGetHeight(self.bounds);
    
    NSObject *obj = [titleArray firstObject];
    if ([obj isKindOfClass:[NSString class]]) {
        for (int i = 0; i < titleArray.count; i++) {
            float x = i > 0 ? CGRectGetMaxX([_itemFrames[i-1] CGRectValue]) : 0;
            float width = kScreen_Width/titleArray.count;
            CGRect rect = CGRectMake(x, y, width, height);
            [_itemFrames addObject:[NSValue valueWithCGRect:rect]];
        }
        
        for (int i = 0; i < titleArray.count; i++) {
            CGRect rect = [_itemFrames[i] CGRectValue];
            NSString *title = titleArray[i];
            HCDPageControlItem *item = [[HCDPageControlItem alloc] initWithFrame:rect title:title type: withIcon ?
                                               HCDPageControlItemTypeTitleAndIcon : HCDPageControlItemTypeTitle];
            if (!withIcon && i == 0) {
                [item setSelected:YES];
            }
            [_items addObject:item];
            [_contentView addSubview:item];
        }
    }
    
    [_contentView setContentSize:CGSizeMake(CGRectGetMaxX([[_itemFrames lastObject] CGRectValue]), CGRectGetHeight(self.bounds))];
    self.currentIndex = 0;
    [self selectIndex:0];
    if (withIcon) {
        [self selectIndex:-1];
        for (int i=1; i<_itemFrames.count; i++) {
            CGRect rect = [_itemFrames[i] CGRectValue];
            
            UIView *lineView  = [[UIView alloc] initWithFrame:CGRectMake(
                                                                         CGRectGetMinX(rect),
                                                                         (CGRectGetHeight(rect) - 14) * 0.5,
                                                                         1,
                                                                         14)];
            lineView.backgroundColor = [UIColor colorWithHexString:@"0xdddddd"];
            [self addSubview:lineView];
        }
    }
}

- (void)addRedLine
{
    if (!_lineView) {
        CGRect rect = [_itemFrames[0] CGRectValue];
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(
                                                             CGRectGetMinX(rect),
                                                             CGRectGetHeight(rect) - kHCDPageControlLineHeight,
                                                             CGRectGetWidth(rect) - 2 * kHCDPageControlHSpace,
                                                             kHCDPageControlLineHeight)];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"0x1488F4"];
        [_contentView addSubview:_lineView];
        
        UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(rect)-0.5, CGRectGetWidth(self.bounds), 0.5)];
        bottomLineView.backgroundColor = [UIColor colorWithHexString:@"0xc8c7cc"];
        [self addSubview:bottomLineView];
    }
}

- (void)setTitle:(NSString *)title withIndex:(NSInteger)index
{
    HCDPageControlItem *curItem = [_items objectAtIndex:index];
    [curItem resetTitle:title];
}

- (void)selectIndex:(NSInteger)index
{
    [self addRedLine];
    if (index < 0) {
        _currentIndex = -1;
        _lineView.hidden = TRUE;
        for (HCDPageControlItem *curItem in _items) {
            [curItem setSelected:NO];
        }
    } else {
        _lineView.hidden = FALSE;
        
        if (index != _currentIndex) {
            HCDPageControlItem *curItem = [_items objectAtIndex:index];
            CGRect rect = [_itemFrames[index] CGRectValue];
            CGRect lineRect = CGRectMake(CGRectGetMinX(rect) + kHCDPageControlHSpace, CGRectGetHeight(rect) - kHCDPageControlLineHeight, CGRectGetWidth(rect) - 2 * kHCDPageControlHSpace, kHCDPageControlLineHeight);
            if (_currentIndex < 0) {
                _lineView.frame = lineRect;
                [curItem setSelected:YES];
                _currentIndex = index;
            } else {
                [UIView animateWithDuration:kHCDPageControlAnimationTime animations:^{
                    _lineView.frame = lineRect;
                } completion:^(BOOL finished) {
                    [_items enumerateObjectsUsingBlock:^(HCDPageControlItem *item, NSUInteger idx, BOOL *stop) {
                        [item setSelected:NO];
                    }];
                    [curItem setSelected:YES];
                    _currentIndex = index;
                }];
            }
        }
        [self setScrollOffset:index];
    }
}

- (void)moveIndexWithProgress:(float)progress
{
    progress = MAX(0, MIN(progress, _items.count));
    
    float delta = progress - _currentIndex;
    
    CGRect origionRect = [_itemFrames[_currentIndex] CGRectValue];;
    
    CGRect origionLineRect = CGRectMake(CGRectGetMinX(origionRect) + kHCDPageControlHSpace, CGRectGetHeight(origionRect) - kHCDPageControlLineHeight, CGRectGetWidth(origionRect) - 2 * kHCDPageControlHSpace, kHCDPageControlLineHeight);
    
    CGRect rect;
    
    if (delta > 0) {
        //        如果delta大于1的话，不能简单的用相邻item间距的乘法来计算距离
        if (delta > 1) {
            self.currentIndex += floorf(delta);
            delta -= floorf(delta);
            origionRect = [_itemFrames[_currentIndex] CGRectValue];;
            origionLineRect = CGRectMake(CGRectGetMinX(origionRect) + kHCDPageControlHSpace, CGRectGetHeight(origionRect) - kHCDPageControlLineHeight, CGRectGetWidth(origionRect) - 2 * kHCDPageControlHSpace, kHCDPageControlLineHeight);
        }
        
        
        
        if (_currentIndex == _itemFrames.count - 1) {
            return;
        }
        
        rect = [_itemFrames[_currentIndex + 1] CGRectValue];
        
        CGRect lineRect = CGRectMake(CGRectGetMinX(rect) + kHCDPageControlHSpace, CGRectGetHeight(rect) - kHCDPageControlLineHeight, CGRectGetWidth(rect) - 2 * kHCDPageControlHSpace, kHCDPageControlLineHeight);
        
        CGRect moveRect = CGRectZero;
        
        moveRect.size = CGSizeMake(CGRectGetWidth(origionLineRect) + delta * (CGRectGetWidth(lineRect) - CGRectGetWidth(origionLineRect)), CGRectGetHeight(lineRect));
        moveRect.origin = CGPointMake(CGRectGetMidX(origionLineRect) + delta * (CGRectGetMidX(lineRect) - CGRectGetMidX(origionLineRect)) - CGRectGetMidX(moveRect), CGRectGetMidY(origionLineRect) - CGRectGetMidY(moveRect));
        _lineView.frame = moveRect;
    } else if (delta < 0){
        
        if (_currentIndex == 0) {
            return;
        }
        rect = [_itemFrames[_currentIndex - 1] CGRectValue];
        CGRect lineRect = CGRectMake(CGRectGetMinX(rect) + kHCDPageControlHSpace, CGRectGetHeight(rect) - kHCDPageControlLineHeight, CGRectGetWidth(rect) - 2 * kHCDPageControlHSpace, kHCDPageControlLineHeight);
        CGRect moveRect = CGRectZero;
        moveRect.size = CGSizeMake(CGRectGetWidth(origionLineRect) - delta * (CGRectGetWidth(lineRect) - CGRectGetWidth(origionLineRect)), CGRectGetHeight(lineRect));
        moveRect.origin = CGPointMake(CGRectGetMidX(origionLineRect) - delta * (CGRectGetMidX(lineRect) - CGRectGetMidX(origionLineRect)) - CGRectGetMidX(moveRect), CGRectGetMidY(origionLineRect) - CGRectGetMidY(moveRect));
        _lineView.frame = moveRect;
        if (delta < -1) {
            self.currentIndex -= 1;
        }
    }
}

- (void)setCurrentIndex:(NSInteger)currentIndex
{
    currentIndex = MAX(0, MIN(currentIndex, _items.count));
    
    if (currentIndex != _currentIndex) {
        HCDPageControlItem *preItem = [_items objectAtIndex:_currentIndex];
        HCDPageControlItem *curItem = [_items objectAtIndex:currentIndex];
        [preItem setSelected:NO];
        [curItem setSelected:YES];
        _currentIndex = currentIndex;
    }
    [self setScrollOffset:currentIndex];
}

- (void)endMoveIndex:(NSInteger)index
{
    [self selectIndex:index];
}

- (void)setScrollOffset:(NSInteger)index
{
    if (_contentView.contentSize.width <= kScreen_Width) {
        return;
    }
    
    CGRect rect = [_itemFrames[index] CGRectValue];
    
    float midX = CGRectGetMidX(rect);
    
    float offset = 0;
    
    float contentWidth = _contentView.contentSize.width;
    
    float halfWidth = CGRectGetWidth(self.bounds) / 2.0;
    
    if (midX < halfWidth) {
        offset = 0;
    }else if (midX > contentWidth - halfWidth){
        offset = contentWidth - 2 * halfWidth;
    }else{
        offset = midX - halfWidth;
    }
    
    [UIView animateWithDuration:kHCDPageControlAnimationTime animations:^{
        [_contentView setContentOffset:CGPointMake(offset, 0) animated:NO];
    }];
}

@end
