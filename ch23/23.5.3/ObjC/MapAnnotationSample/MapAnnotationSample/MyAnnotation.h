//
//  MyAnnotation.h
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

#import <MapKit/MapKit.h>

@interface MyAnnotation : NSObject <MKAnnotation>

-(instancetype)initWithCoordinate:(CLLocationCoordinate2D) coordinate;

//街道信息属性
@property(nonatomic, copy) NSString *streetAddress;
//城市信息属性
@property(nonatomic, copy) NSString *city;
//州、省、市信息
@property(nonatomic, copy) NSString *state;
//邮编
@property(nonatomic, copy) NSString *zip;
//地理坐标
@property(nonatomic, readwrite) CLLocationCoordinate2D coordinate;

@end
