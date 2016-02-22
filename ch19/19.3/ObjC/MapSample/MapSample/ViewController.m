//
//  ViewController.m
//  MapSample
//
//  Created by 关东升 on 16/1/16.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property(nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear: animated];
    
    self.mapView.mapType = MKMapTypeStandard;

    CLLocation *location = [[CLLocation alloc] initWithLatitude:40.002240 longitude:116.323328];
    //调整地图位置和缩放比例
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 10000, 10000);
    self.mapView.region = viewRegion;
    
    //授权
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager requestAlwaysAuthorization];

    self.mapView.showsUserLocation = TRUE;
    self.mapView.userLocation.title = @"我在这里！";
    self.mapView.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)selectMapViewType:(id)sender {
    
    UISegmentedControl* sc = (UISegmentedControl*)sender;
    
    switch (sc.selectedSegmentIndex) {
        case 1:
            self.mapView.mapType = MKMapTypeSatellite;
            break;
        case 2:
            self.mapView.mapType = MKMapTypeHybrid;
            break;
        default:
            self.mapView.mapType = MKMapTypeStandard;
    }
}

#pragma mark --实现MKMapViewDelegate协议
- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView {
    mapView.userTrackingMode =  MKUserTrackingModeFollowWithHeading;
}

@end
