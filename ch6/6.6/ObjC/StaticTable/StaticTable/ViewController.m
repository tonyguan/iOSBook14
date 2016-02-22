//
//  ViewController.m
//  StaticTable
//
//  Created by 关东升 on 15/12/21.
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

@property (weak, nonatomic) IBOutlet UITextField *txtUserName;
@property (weak, nonatomic) IBOutlet UITextField *txtPwd;

- (IBAction)login:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(id)sender {
    if ([self.txtPwd.text  isEqual: @"123"]
        && [self.txtUserName.text isEqual: @"tony"]) {
        NSLog(@"登录成功。");
        [self.txtPwd resignFirstResponder];
        [self.txtUserName resignFirstResponder];
    }
}

@end
