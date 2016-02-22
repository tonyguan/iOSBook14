//
//  Philosopher.swift
//  DelegatePattern
//
//  Created by 关东升 on 15/12/30.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

import Foundation


class Philosopher : NSObject {
    
    var timer : NSTimer!
    var count : Int = 0
    var delegate: PhilosopherDelegate?
    
    func start() {
        count = 0
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0,
            target: self,
            selector: "handle",
            userInfo: nil,
            repeats: true)
    }
    
    func handle() {
        
        if count == 0 {
            self.delegate?.sleep()
            count++
        } else if  count == 1 {
            self.delegate?.eat()
            count++
        }  else if  count == 2 {
            self.delegate?.work()
            timer.invalidate()
        }
    }
    
}
