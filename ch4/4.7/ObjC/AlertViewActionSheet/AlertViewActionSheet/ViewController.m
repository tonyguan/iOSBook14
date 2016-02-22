//
//  ViewController.m
//  AlertViewActionSheet
//
//  Created by 关东升 on 15/12/13.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect screen = [[UIScreen mainScreen] bounds];
    
    UIButton* buttonAlertView = [UIButton buttonWithType:UIButtonTypeSystem];
    [buttonAlertView setTitle:@"Test警告框" forState:UIControlStateNormal];
    
    CGFloat buttonAlertViewWidth = 100;
    CGFloat buttonAlertViewHeight = 30;
    CGFloat buttonAlertViewTopView = 130;
    
    buttonAlertView.frame = CGRectMake((screen.size.width - buttonAlertViewWidth)/2 , buttonAlertViewTopView, buttonAlertViewWidth, buttonAlertViewHeight);
    //指定事件处理方法
    [buttonAlertView addTarget:self action:@selector(testAlertView:) forControlEvents: UIControlEventTouchUpInside];
    [self.view addSubview:buttonAlertView];
    
    
    UIButton* buttonActionSheet = [UIButton buttonWithType:UIButtonTypeSystem];
    [buttonActionSheet setTitle:@"Test操作表" forState:UIControlStateNormal];
    
    CGFloat buttonActionSheetWidth = 100;
    CGFloat buttonActionSheetHeight = 30;
    CGFloat buttonActionSheetTopView = 260;
    
    buttonActionSheet.frame = CGRectMake((screen.size.width - buttonActionSheetWidth)/2 , buttonActionSheetTopView, buttonActionSheetWidth, buttonActionSheetHeight);
    //指定事件处理方法
    [buttonActionSheet addTarget:self action:@selector(testActionSheet:) forControlEvents: UIControlEventTouchUpInside];
    [self.view addSubview:buttonActionSheet];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)testAlertView:(id)sender {
    
    UIAlertController* alertController  = [UIAlertController alertControllerWithTitle:@"Alert" message: @"Alert text goes here" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* noAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"Tap No Button");
    }];
    
    UIAlertAction* yesAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"Tap Yes Button");
    }];
    
    [alertController addAction:noAction];
    [alertController addAction:yesAction];
    
    //显示
    [self presentViewController:alertController animated:TRUE completion:nil];
    
}

- (void)testActionSheet:(id)sender {
    
    UIAlertController* actionSheetController = [[UIAlertController alloc] init];
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"Tap 取消 Button");
    }];
    
    UIAlertAction* destructiveAction = [UIAlertAction actionWithTitle:@"破坏性按钮" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        NSLog(@"Tap 破坏性按钮 Button");
    }];
    
    UIAlertAction* otherAction = [UIAlertAction actionWithTitle:@"新浪微博" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"Tap 新浪微博 Button");
    }];
    
    [actionSheetController addAction:cancelAction];
    [actionSheetController addAction:destructiveAction];
    [actionSheetController addAction:otherAction];
    
    //显示
    [self presentViewController:actionSheetController animated:TRUE completion:nil];
}


@end
