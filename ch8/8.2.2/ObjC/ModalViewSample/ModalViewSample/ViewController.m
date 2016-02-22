//
//  ViewController.m
//  ModalViewSample
//
//  Created by 关东升 on 15/12/22.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

#import "ViewController.h"
#import "RegisterViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect screen = [[UIScreen mainScreen] bounds];
    
    self.navigationItem.title = @"登录";
    
    /// 1.添加用户ID：标签
    UILabel* labelId = [[UILabel alloc] initWithFrame:CGRectMake(59,115, 68, 21)];    
    labelId.text = @"用户ID：";
    [self.view addSubview:labelId];
    
    /// 2.添加用户ID TextField
    UITextField* textFieldId = [[UITextField alloc] initWithFrame:CGRectMake(141, 106, 100, 30)];
    textFieldId.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:textFieldId];
    
    /// 3.添加密码：标签
    UILabel* labelPwd = [[UILabel alloc] initWithFrame:CGRectMake(76, 178, 51, 21)];
    labelPwd.text = @"密码：";
    [self.view addSubview:labelPwd];
    
    /// 4.添加密码 TextField
    UITextField* textFieldPwd = [[UITextField alloc] initWithFrame:CGRectMake(141, 169, 100, 30)];
    textFieldPwd.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:textFieldPwd];
    
    /// 5.添加 登录按钮
    UIButton* buttonLogin = [UIButton buttonWithType:UIButtonTypeSystem];
    buttonLogin.frame = CGRectMake((screen.size.width - 30)/2, 231, 30, 30);
    [buttonLogin setTitle:@"登录" forState:UIControlStateNormal];
    [self.view addSubview:buttonLogin];
    
    /// 6.添加 注册按钮
    UIButton* buttonReg = [UIButton buttonWithType:UIButtonTypeSystem];
    buttonReg.frame = CGRectMake((screen.size.width - 30)/2, 294, 30, 30);
    [buttonReg setTitle:@"注册" forState:UIControlStateNormal];
    [buttonReg addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:buttonReg];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(registerCompletion:) name:@"RegisterCompletionNotification" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)onClick:(id)sender {
    
    RegisterViewController* registerViewController = [[RegisterViewController alloc] init];
    UINavigationController* navigationController = [[UINavigationController alloc] initWithRootViewController:registerViewController];
   
    [self presentViewController:navigationController animated:TRUE completion:nil];
}


-(void)registerCompletion:(NSNotification*)notification {
    
    NSDictionary *theData = [notification userInfo];
    NSString *username = theData[@"username"];
    
    NSLog(@"username = %@",username);
}

@end
