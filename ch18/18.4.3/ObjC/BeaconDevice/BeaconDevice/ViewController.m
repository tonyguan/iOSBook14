//
//  ViewController.m
//  BeaconDevice
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
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>

#define kUUID   @"533F8EF4-EED2-4FEC-8566-84C242B0C636"
#define kID     @"com.51work6.AirLocate"
#define kPower  @-59   //采用字面量表示NSNumber对象

@interface ViewController () <CBPeripheralManagerDelegate>

@property(nonatomic, strong) CBPeripheralManager* peripheralManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];    
    self.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma --实现CBPeripheralManagerDelegate协议
- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral {
    NSLog(@"外设状态变化");
}

- (IBAction)valueChanged:(id)sender {
    UISwitch* swc =  (UISwitch*)sender;
    
    if (swc.on) {
        NSUUID* uuid = [[NSUUID alloc] initWithUUIDString: kUUID];
        CLBeaconRegion* region = [[CLBeaconRegion alloc] initWithProximityUUID:uuid identifier:kID];
        
        NSDictionary* peripheralData = [region peripheralDataWithMeasuredPower:kPower];

        [self.peripheralManager startAdvertising:peripheralData];
        
    } else {
        [self.peripheralManager stopAdvertising];
    }
}

@end
