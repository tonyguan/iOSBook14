//
//  ScheduleBL.swift
//  BusinessLogicLayer
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
import PersistenceLayer

public class ScheduleBL: NSObject {
    
    //查询所有数据方法
    public func readData() -> NSMutableDictionary {
        
        let scheduleDAO = ScheduleDAO.sharedInstance
        let schedules  = scheduleDAO.findAll()
        let resDict = NSMutableDictionary()
        
        let eventsDAO = EventsDAO.sharedInstance
        
        //延迟加载Events数据
        for item in schedules {
            let schedule = item as! Schedule
            let event = eventsDAO.findById(schedule.Event!)
            schedule.Event = event
            
            let allkey = resDict.allKeys as NSArray
            
            //把NSMutableArray结构转化为NSMutableDictionary结构
            if allkey.containsObject(schedule.GameDate!) {
                let value = resDict[schedule.GameDate!] as! NSMutableArray
                value.addObject(schedule)
            } else {
                let value = NSMutableArray()
                value.addObject(schedule)
                resDict[schedule.GameDate!] = value
            }
        }
        return resDict
    }
}
