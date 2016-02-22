//
//  ViewController.m
//  UITextFieldDelegateSample
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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textField.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -- UITextFieldDelegate method
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    NSLog(@"call textFieldShouldBeginEditing:");
    return TRUE;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    NSLog(@"call textFieldDidBeginEditing:");
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    NSLog(@"call textFieldShouldEndEditing:");
    return TRUE;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSLog(@"call textFieldDidEndEditing:");
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"call textFieldShouldReturn:");
    [textField resignFirstResponder];
    return TRUE;
}

@end
