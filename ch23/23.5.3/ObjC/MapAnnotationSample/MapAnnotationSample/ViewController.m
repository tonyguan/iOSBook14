//
//  ViewController.m
//  MapAnnotationSample
//
//  Created by 关东升 on 16/1/17.
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
#import "MyAnnotation.h"

@interface ViewController () <MKMapViewDelegate>

@property(weak, nonatomic) IBOutlet MKMapView *mapView;
@property(weak, nonatomic) IBOutlet UITextField *txtQueryKey;
@property(weak, nonatomic) IBOutlet UITextView *txtView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapView.mapType = MKMapTypeStandard;
    self.mapView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)geocodeQuery:(id)sender {
    
    if (self.txtQueryKey.text == nil || [self.txtQueryKey.text length] == 0) {
        return;
    }

    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:_txtQueryKey.text completionHandler:^(NSArray *placemarks, NSError *error) {
        
        NSLog(@"查询记录数：%lu", [placemarks count]);
        [self.mapView removeAnnotations:self.mapView.annotations];
        
        for (CLPlacemark *placemark in placemarks) {
            
            MyAnnotation *annotation = [[MyAnnotation alloc] initWithCoordinate:placemark.location.coordinate];
            annotation.streetAddress = placemark.thoroughfare;
            annotation.city = placemark.locality;
            annotation.state = placemark.administrativeArea;
            annotation.zip = placemark.postalCode;
            
            [self.mapView addAnnotation:annotation];
        }
        
        if ([placemarks count] > 0) {
            //取出最后一个地标点
            MKPlacemark *lastPlacemark = placemarks.lastObject;
            //调整地图位置和缩放比例
            MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(lastPlacemark.location.coordinate, 10000, 10000);
            [self.mapView setRegion:viewRegion animated:TRUE];
        }
        
        //关闭键盘
        [_txtQueryKey resignFirstResponder];
    }];
}

#pragma mark --实现MKMapViewDelegate协议
- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [self.mapView dequeueReusableAnnotationViewWithIdentifier:@"PIN_ANNOTATION"];
    if (annotationView == nil) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"PIN_ANNOTATION"];
    }
    
    annotationView.pinTintColor = [UIColor redColor];
    annotationView.animatesDrop = TRUE;
    annotationView.canShowCallout = TRUE;
    
    return annotationView;
}

- (void)mapViewDidFailLoadingMap:(MKMapView *)theMapView withError:(NSError *)error {
    NSLog(@"error : %@", [error localizedDescription]);
}

@end
