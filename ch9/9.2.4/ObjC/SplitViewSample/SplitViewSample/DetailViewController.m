//
//  DetailViewController.m
//  SplitViewSample
//
//  Created by 关东升 on 16/2/4.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

#import "DetailViewController.h"
#import "YellowViewController.h"
#import "BlueViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"选择的行号： %li", (long)self.selectRow);    
    self.title = @"Detail";

    if (self.selectRow == 0) {
        //蓝色
        UIViewController* blueViewController = [[BlueViewController alloc] init];
        [self addChildViewController:blueViewController];
        [self.view addSubview:blueViewController.view];
    } else {
        //黄色
        UIViewController* yellowViewController = [[YellowViewController alloc] init];
        [self addChildViewController:yellowViewController];
        [self.view addSubview:yellowViewController.view];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
