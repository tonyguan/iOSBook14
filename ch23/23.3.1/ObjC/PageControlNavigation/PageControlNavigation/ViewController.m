//
//  ViewController.m
//  PageControlNavgation
//
//  Created by 关东升 on 2016-2-18.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//


#import "ViewController.h"

#define S_WIDTH  320.0 //屏幕的宽度
#define S_HEIGHT 480.0 //屏幕的高度

@interface ViewController () <UIScrollViewDelegate>

@property (strong, nonatomic) UIImageView *page1;
@property (strong, nonatomic) UIImageView *page2;
@property (strong, nonatomic) UIImageView *page3;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

- (IBAction)changePage:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scrollView.delegate = self;
    
    self.scrollView.frame = self.view.frame;
    self.scrollView.contentSize = CGSizeMake(S_WIDTH * 3, S_HEIGHT);
    
    self.page1 = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, S_WIDTH, S_HEIGHT)];
    self.page1.image = [UIImage imageNamed:@"达芬奇-蒙娜丽莎.png"];
    
    self.page2 = [[UIImageView alloc] initWithFrame:CGRectMake(S_WIDTH, 0.0f, S_WIDTH, S_HEIGHT)];
    self.page2.image = [UIImage imageNamed:@"罗丹-思想者.png"];
    
    self.page3 = [[UIImageView alloc] initWithFrame:CGRectMake(2 * S_WIDTH, 0.0f, S_WIDTH, S_HEIGHT)];
    self.page3.image = [UIImage imageNamed:@"保罗克利-肖像.png"];
    
    [self.scrollView addSubview:self.page1];
    [self.scrollView addSubview:self.page2];
    [self.scrollView addSubview:self.page3];
}


- (void) scrollViewDidScroll: (UIScrollView *) aScrollView {
	CGPoint offset = aScrollView.contentOffset;
	self.pageControl.currentPage = offset.x / S_WIDTH;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 
#pragma mark PageControl stuff
- (IBAction)changePage:(id)sender {
    [UIView animateWithDuration:0.3f animations:^{
        NSInteger whichPage = self.pageControl.currentPage;
        self.scrollView.contentOffset = CGPointMake(S_WIDTH * whichPage, 0.0f);
    }];
}

@end
