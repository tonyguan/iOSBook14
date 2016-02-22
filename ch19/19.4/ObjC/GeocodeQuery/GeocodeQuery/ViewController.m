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
#import <MapKit/MapKit.h>

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
    
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = self.txtQueryKey.text;
    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
    
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {

        if ([response.mapItems count] > 0) {
            //取出最后一个地标点
            MKMapItem *lastMapItem = response.mapItems.lastObject;
            [lastMapItem openInMapsWithLaunchOptions:nil];
            //地图上设置行车路线
//            NSDictionary* options = @{MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving};
//            [lastMapItem openInMapsWithLaunchOptions:options];
            
             //多个点标注线
//            [MKMapItem openMapsWithItems:response.mapItems launchOptions:nil];
        }
        
    }];

    //关闭键盘
    [self.txtQueryKey resignFirstResponder];
}

@end
