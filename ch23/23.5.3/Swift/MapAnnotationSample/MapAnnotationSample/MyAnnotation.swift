//
//  MyAnnotation.swift
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

import MapKit

class MyAnnotation: NSObject, MKAnnotation {
    //街道信息属性
    var streetAddress: String!
    //城市信息属性
    var city: String!
    //州、省、市信息
    var state: String!
    //邮编
    var zip: String!
    //地理坐标
    var coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
    
    var title: String? {
        return "您的位置!"
    }
    var subtitle: String? {
        
        let res = NSMutableString()
        if  (self.state != nil) {
            res.appendFormat("%@", self.state)
        }
        
        if  (self.city != nil) {
            res.appendFormat(" • %@", self.state)
        }
        
        if  (self.zip != nil) {
            res.appendFormat(" • %@", self.zip)
        }
        
        if  (self.streetAddress != nil) {
            res.appendFormat(" • %@", self.streetAddress)
        }
        return res as String
    }
    
}