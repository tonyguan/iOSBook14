//
//  Schedule.swift
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

// 比赛日程表 实体类

public class Schedule: NSObject {
    //编号
    public var ScheduleID: Int?
    //比赛日期
    public var GameDate: NSString?
    //比赛时间
    public var GameTime: NSString?
    //比赛描述
    public var GameInfo: NSString?
    //比赛项目
    public var Event: Events?

}
