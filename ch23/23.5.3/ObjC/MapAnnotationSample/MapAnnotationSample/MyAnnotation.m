//
//  MyAnnotation.m
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

#import "MyAnnotation.h"

@implementation MyAnnotation

-(instancetype)initWithCoordinate:(CLLocationCoordinate2D) coordinate {
    self = [super init];
    if (self) {
        self.coordinate = coordinate;
    }
    return self;
}

- (NSString *)title {
    return @"您的位置!";
}

- (NSString *)subtitle {
    
    NSMutableString *res = [[NSMutableString alloc] init];
    if  (self.state != nil) {
        [res appendFormat:@"%@", self.state];
    }
    
    if  (self.city != nil) {
        [res appendFormat:@" • %@", self.state];
    }
    
    if  (self.zip != nil) {
        [res appendFormat:@" • %@", self.zip];
    }
    
    if  (self.streetAddress != nil) {
        [res appendFormat:@" • %@", self.streetAddress];
    }
    
    return res;
}


@end
