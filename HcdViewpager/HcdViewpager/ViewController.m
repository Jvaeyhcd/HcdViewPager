//
//  ViewController.m
//  hcdViewPager
//
//  Created by funmitech-huangchengda on 15/11/18.
//  Copyright © 2015年 Polesapp. All rights reserved.
//

#import "ViewController.h"
#import "hcdViewPager/HCDPageControl.h"
#import "UIColor+HcdCustom.h"
#import "iCarousel.h"

@interface ViewController ()<iCarouselDataSource,iCarouselDelegate>
@property (nonatomic , strong) HCDPageControl *pageControl;
@property (strong, nonatomic) NSMutableArray *pageControlItems;
@property (strong, nonatomic) iCarousel *myCarousel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _pageControlItems = [[NSMutableArray alloc]initWithObjects:@"课程列表",@"课程列表", nil];
    _pageControl = [[HCDPageControl alloc]initWithFrame:CGRectMake(0, 64, 320, 40) items:_pageControlItems selectedBlock:^(NSInteger index){
        
    }];
    _pageControl.backgroundColor = [UIColor colorWithHexString:@"0xFFFFFF"];
    
    [self.view addSubview:_pageControl];
    [self.view addSubview:self.myCarousel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (iCarousel *)myCarousel
{
    if (!_myCarousel) {
        _myCarousel = [[iCarousel alloc] init];
        _myCarousel.dataSource = self;
        _myCarousel.delegate = self;
        _myCarousel.decelerationRate = 1.0;
        _myCarousel.scrollSpeed = 1.0;
        _myCarousel.type = iCarouselTypeLinear;
        _myCarousel.pagingEnabled = YES;
        _myCarousel.clipsToBounds = YES;
        _myCarousel.bounceDistance = 0.2;
        _myCarousel.frame = CGRectMake(0, CGRectGetMaxY(_pageControl.frame), 320, 400);
    }
    return _myCarousel;
}



#pragma mark iCarousel M

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return _pageControlItems.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view{
    
    UIView * contentView = view;
    if (!contentView) {
        contentView = [[UIView alloc]initWithFrame:_myCarousel.frame];
        contentView.backgroundColor = [UIColor whiteColor];
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, 320, 20)];
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        label.tag = 100;
        
        [contentView addSubview:label];
    }
    UILabel * label = [contentView viewWithTag:100];
    label.text = [NSString stringWithFormat:@"第%lu页", (unsigned long)index+1];
    return contentView;
}

- (void)carouselDidScroll:(iCarousel *)carousel{
    [self.view endEditing:YES];
    if (_pageControl) {
        float offset = carousel.scrollOffset;
        if (offset > 0) {
            [_pageControl moveIndexWithProgress:offset];
        }
    }
}

- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel
{
    if (_pageControl) {
        _pageControl.currentIndex = carousel.currentItemIndex;
    }
    //    if (_oldSelectedIndex != carousel.currentItemIndex) {
    //        _oldSelectedIndex = carousel.currentItemIndex;
    //        ProjectListView *curView = (ProjectListView *)carousel.currentItemView;
    //        [curView refreshToQueryData];
    //    }
//    [carousel.visibleItemViews enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
//        [obj setSubScrollsToTop:(obj == carousel.currentItemView)];
//    }];
}

@end
