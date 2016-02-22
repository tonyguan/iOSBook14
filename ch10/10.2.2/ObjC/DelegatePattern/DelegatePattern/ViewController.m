//
//  ViewController.m
//  DelegatePattern
//
//  Created by 关东升 on 15/12/30.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

#import "ViewController.h"
#import "Philosopher.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Philosopher *tom = [[Philosopher alloc ] init];
    tom.delegate = self;
    [tom start];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma --实现PhilosopherDelegate委托方法
-(void) sleep {
    NSLog(@"sleep...");
}

-(void) eat {
    NSLog(@"eat...");
}

-(void) work {
    NSLog(@"work...");
}

@end
