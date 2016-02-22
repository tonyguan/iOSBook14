//
//  ViewController.m
//  AppSetting
//
//  Created by 关东升 on 16/1/3.
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
//用户名
@property(weak, nonatomic) IBOutlet UILabel *username;
//密码
@property(weak, nonatomic) IBOutlet UILabel *password;
//每月是否清除缓存
@property(weak, nonatomic) IBOutlet UILabel *clearCache;
//每月流量限制
@property(weak, nonatomic) IBOutlet UILabel *flowmeter;
//服务器
@property(weak, nonatomic) IBOutlet UILabel *serverName;
//通知-声音
@property(weak, nonatomic) IBOutlet UILabel *notiSound;
//通知-震动
@property(weak, nonatomic) IBOutlet UILabel *notiVibrate;

//读取设置数据
- (IBAction)getData:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)viewWillAppear:(BOOL)animated {
    [self getData:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)getData:(id)sender {

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];


    self.username.text = [defaults stringForKey:@"name_preference"];
    self.password.text = [defaults stringForKey:@"password_preference"];

    if ([defaults boolForKey:@"enabled_preference"]) {
        self.clearCache.text = @"YES";
    } else {
        self.clearCache.text = @"NO";
    }

    self.flowmeter.text = [NSString stringWithFormat:@"%.2fGB", [defaults doubleForKey:@"slider_preference"]];

    self.serverName.text = [defaults stringForKey:@"multivaule_preference"];

    if ([defaults boolForKey:@"sound_enabled_preference"]) {
        self.notiSound.text = @"YES";
    } else {
        self.notiSound.text = @"NO";
    }


    if ([defaults boolForKey:@"vibrate_enabled_preference"]) {
        self.notiVibrate.text = @"YES";
    } else {
        self.notiVibrate.text = @"NO";
    }
}

@end
