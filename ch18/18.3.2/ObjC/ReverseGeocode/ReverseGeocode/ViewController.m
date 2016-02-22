//
//  ViewController.m
//  ReverseGeocode
//
//  Created by 关东升 on 16/1/15.
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

@interface ViewController () <CLLocationManagerDelegate>

//经度
@property(weak, nonatomic) IBOutlet UITextField *txtLng;
//纬度
@property(weak, nonatomic) IBOutlet UITextField *txtLat;
//高度
@property(weak, nonatomic) IBOutlet UITextField *txtAlt;

@property(weak, nonatomic) IBOutlet UITextView *txtView;

@property(nonatomic, strong) CLLocationManager *locationManager;

@property(nonatomic, strong) CLLocation *currLocation;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.txtView.text = @"";

    //定位服务管理对象初始化
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 1000.0f;

    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager requestAlwaysAuthorization];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //开始定位
    [self.locationManager startUpdatingLocation];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //停止定位
    [self.locationManager stopUpdatingLocation];
}

- (IBAction)reverseGeocode:(id)sender {

    CLGeocoder *geocoder = [[CLGeocoder alloc] init];

    [geocoder reverseGeocodeLocation:self.currLocation
       completionHandler:^(NSArray<CLPlacemark *> *placemarks, NSError *error) {
           
           if (error) {
               NSLog(@"Error is %@",error.localizedDescription);
           } else if ([placemarks count] > 0) {

               CLPlacemark *placemark = placemarks[0];
               NSString *name = placemark.name;
               self.txtView.text = name;

           }
       }];
}

#pragma mark -- Core Location委托方法用于实现位置的更新

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {

    self.currLocation = [locations lastObject];
    self.txtLat.text = [NSString stringWithFormat:@"%3.5f", self.currLocation.coordinate.latitude];
    self.txtLng.text = [NSString stringWithFormat:@"%3.5f", self.currLocation.coordinate.longitude];
    self.txtAlt.text = [NSString stringWithFormat:@"%3.5f", self.currLocation.altitude];

}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"error: %@", error);
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {

    if (status == kCLAuthorizationStatusAuthorizedAlways) {
        NSLog(@"已经授权");
    } else if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        NSLog(@"当使用时候授权");
    } else if (status == kCLAuthorizationStatusDenied) {
        NSLog(@"拒绝");
    } else if (status == kCLAuthorizationStatusRestricted) {
        NSLog(@"受限");
    } else if (status == kCLAuthorizationStatusNotDetermined) {
        NSLog(@"用户还没有确定");
    }
}


@end
