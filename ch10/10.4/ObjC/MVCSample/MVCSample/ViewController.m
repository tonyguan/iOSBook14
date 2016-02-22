//
//  ViewController.m
//  MVCSample
//
//  Created by 关东升 on 15/12/31.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

#import "ViewController.h"

@interface ViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *myButton;
@property (weak, nonatomic) IBOutlet UITextField *myTextField;

- (IBAction)myAction:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myTextField.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)myAction:(id)sender {
    NSLog(@"call myAction:");
}

#pragma mark --实现UITextFieldDelegate协议方法
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
