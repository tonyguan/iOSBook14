//
//  ViewController.m
//  GeocodeQuery
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

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextView *txtView;
@property (weak, nonatomic) IBOutlet UITextField *txtQueryKey;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.txtView.text = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)geocodeQuery:(id)sender {
    
    if (self.txtQueryKey.text == nil) {
        return;
    }
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    [geocoder geocodeAddressString:self.txtQueryKey.text completionHandler:^(NSArray<CLPlacemark *> * placemarks, NSError * error) {
        
        if (error) {
            NSLog(@"Error is %@",error.localizedDescription);
        } else if ([placemarks count] > 0) {
            
            CLPlacemark* placemark = placemarks[0];
            
            NSString* name = placemark.name;
            
            CLLocation *location = placemark.location;
            
            double lng = location.coordinate.longitude;
            double lat = location.coordinate.latitude;
            
            self.txtView.text = [NSString stringWithFormat:@"经度：%3.5f \n纬度：%3.5f \n%@", lng, lat, name];
            
        }
        
    }];
    //关闭键盘
    [self.txtQueryKey resignFirstResponder];

//    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
//    CLLocation *location = [[CLLocation alloc] initWithLatitude:40.002240 longitude:116.323328];
//    
//    CLCircularRegion* region = [[CLCircularRegion alloc] initWithCenter:location.coordinate radius:5000 identifier:@"GeocodeRegion"];
//    
//    [geocoder geocodeAddressString:self.txtQueryKey.text inRegion:region completionHandler:^(NSArray<CLPlacemark *> * placemarks, NSError * error) {
//        //TODO
//    }];
    

}

@end
