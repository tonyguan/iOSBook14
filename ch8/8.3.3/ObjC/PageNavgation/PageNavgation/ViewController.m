//
//  ViewController.m
//  PageNavgation
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

enum DirectionForward
{
    ForwardBefore = 1 //向前
    ,ForwardAfter =2  //向后
};

@interface ViewController () <UIPageViewControllerDataSource,UIPageViewControllerDelegate> {
    //当前Page的索引
    int pageIndex;
    //翻页的方向 BeforeForward 向前 AfterForward 向后
    int  directionForward;
}

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *viewControllers;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIViewController *page1ViewController = [[UIViewController alloc] init];
    UIViewController *page2ViewController = [[UIViewController alloc] init];
    UIViewController *page3ViewController = [[UIViewController alloc] init];
    
    self.viewControllers = @[page1ViewController, page2ViewController, page3ViewController];
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:self.view.frame];
    imageView1.image = [UIImage imageNamed:@"达芬奇-蒙娜丽莎.png"];
    [page1ViewController.view addSubview:imageView1];
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:self.view.frame];
    imageView2.image = [UIImage imageNamed:@"罗丹-思想者.png"];
    [page2ViewController.view addSubview:imageView2];
    
    UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:self.view.frame];
    imageView3.image = [UIImage imageNamed:@"保罗克利-肖像.png"];
    [page3ViewController.view addSubview:imageView3];
    
    //设置UIPageViewController控制器
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl
                                                              navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    
    //设置首页
    [self.pageViewController setViewControllers:@[page1ViewController]
                                      direction:UIPageViewControllerNavigationDirectionForward animated:TRUE completion:nil];
    
    [self.view addSubview:self.pageViewController.view];
    
    pageIndex = 0;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --实现UIPageViewControllerDataSource协议
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    pageIndex--;
    
    if (pageIndex < 0){
        pageIndex = 0;
        return nil;
    }
    
    directionForward = ForwardBefore;
    return self.viewControllers[pageIndex];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    pageIndex++;
    
    if (pageIndex > 2){
        pageIndex = 2;
        return nil;
    }
    
    directionForward = ForwardAfter;
    return self.viewControllers[pageIndex];
}


#pragma mark --实现UIPageViewControllerDelegate协议
- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation {
    self.pageViewController.doubleSided = FALSE;
    return UIPageViewControllerSpineLocationMin;
}


- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed {
    if (!completed) {
        if (directionForward == ForwardAfter) {
            pageIndex--;
        }
        if (directionForward == ForwardBefore) {
            pageIndex++;
        }
    }
}

@end
