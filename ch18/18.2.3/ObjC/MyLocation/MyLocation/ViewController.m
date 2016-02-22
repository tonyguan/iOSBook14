//
//  ViewController.m
//  MyLocation
//
//  Created by 关东升 on 16/1/14.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

#define UpdateLocationNotification @"kUpdateLocationNotification"

@interface ViewController ()

//经度
@property(weak, nonatomic) IBOutlet UITextField *txtLng;
//纬度
@property(weak, nonatomic) IBOutlet UITextField *txtLat;
//高度
@property(weak, nonatomic) IBOutlet UITextField *txtAlt;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLocation:) name:UpdateLocationNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)updateLocation:(NSNotification *)notification {
    
    CLLocation *currLocation = [notification object];
    
    self.txtLat.text = [NSString stringWithFormat:@"%3.5f", currLocation.coordinate.latitude];
    self.txtLng.text = [NSString stringWithFormat:@"%3.5f", currLocation.coordinate.longitude];
    self.txtAlt.text = [NSString stringWithFormat:@"%3.5f", currLocation.altitude];
}


@end
