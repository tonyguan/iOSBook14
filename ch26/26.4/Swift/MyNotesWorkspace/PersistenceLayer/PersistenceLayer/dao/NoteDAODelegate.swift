//
//  NoteDAODelegate.swift
//  PersistenceLayer
//
//  Created by 关东升 on 15/12/31.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

import Foundation

@objc
public protocol NoteDAODelegate {

    //查询所有数据方法 成功
    optional func findAllFinished(list: NSMutableArray)

    //查询所有数据方法 失败
    optional func findAllFailed(error: NSError)

    //按照主键查询数据方法 成功
    optional func findByIdFinished(model: Note)

    //按照主键查询数据方法 失败
    optional func findByIdFailed(error: NSError)

    //插入Note方法 成功
    optional func createFinished()

    //插入Note方法 失败
    optional func createFailed(error: NSError)

    //删除Note方法 成功
    optional func removeFinished()

    //删除Note方法 失败
    optional func removeFailed(error: NSError)

    //修改Note方法 成功
    optional func modifyFinished()

    //修改Note方法 失败
    optional func modifyFailed(error: NSError)

}