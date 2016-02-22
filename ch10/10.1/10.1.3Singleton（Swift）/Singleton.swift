//
//  Created by 关东升 on 2016-2-18.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//


/// 1.简单种单例模式的实现
class Singleton {
    static let sharedInstance = Singleton()
}


/// 2.带有闭包形式代码
class Singleton {
    static let sharedInstance: Singleton = {
      	let instance = Singleton()
       	// 初始化处理
       	return instance
    }()
}