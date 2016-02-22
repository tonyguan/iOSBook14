//
//  Events.swift
//  PersistenceLayer
//
//  Created by 关东升 on 16/1/31.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//


import Foundation

//比赛项目 实体类

public class Events: NSObject {
    //编号
    public var EventID: Int?
    //项目名
    public  var EventName: NSString?
    //项目图标
    public  var EventIcon: NSString?
    //项目关键信息
    public  var KeyInfo: NSString?
    //项目基本信息
    public  var BasicsInfo: NSString?
    //项目奥运会历史信息
    public  var OlympicInfo: NSString?
}