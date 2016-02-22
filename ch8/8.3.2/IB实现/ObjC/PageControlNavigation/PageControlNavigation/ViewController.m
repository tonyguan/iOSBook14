//
//  ViewController.m
//  PageControlNavigation
//
//  Created by 关东升 on 15/12/24.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

#import "ViewController.h"

@interface ViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (strong, nonatomic) UIImageView *imageView1;
@property (strong, nonatomic) UIImageView *imageView2;
@property (strong, nonatomic) UIImageView *imageView3;

- (IBAction)changePage:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scrollView.delegate = self;
    
    self.scrollView.contentSize  = CGSizeMake(self.view.frame.size.width*3, self.scrollView.frame.size.height);
    self.scrollView.frame = self.view.frame;
    
    self.imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 480.0f)];
    self.imageView1.image = [UIImage imageNamed:@"达芬奇-蒙娜丽莎.png"];
    [self.scrollView addSubview:self.imageView1];
    
    self.imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(320.0f, 0.0f, 320.0f, 480.0f)];
    [self.scrollView addSubview:self.imageView2];
    self.imageView2.image = [UIImage imageNamed:@"罗丹-思想者.png"];
    
    self.imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(2 * 320.0f, 0.0f, 320.0f, 480.0f)];
    [self.scrollView addSubview:self.imageView3];
    self.imageView3.image = [UIImage imageNamed:@"保罗克利-肖像.png"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --实现UIScrollViewDelegate委托协议
- (void) scrollViewDidScroll: (UIScrollView *) scrollView {
    CGPoint offset = scrollView.contentOffset;
    self.pageControl.currentPage = offset.x / 320.0f;
}

#pragma mark --实现UIPageControl事件处理
- (IBAction)changePage:(id)sender {
    [UIView animateWithDuration:0.3f animations:^{
        NSInteger whichPage = self.pageControl.currentPage;
        self.scrollView.contentOffset = CGPointMake(320.0f * whichPage, 0.0f);
    }];
}


@end
