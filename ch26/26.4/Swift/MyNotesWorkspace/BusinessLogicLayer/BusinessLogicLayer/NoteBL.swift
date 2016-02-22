//
//  NoteBL.swift
//  BusinessLogicLayer
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
import PersistenceLayer

public class NoteBL: NSObject, NoteDAODelegate {

    public var delegate: NoteBLDelegate!

    public override init() {
    }

    //插入Note方法
    public func createNote(model: Note) {
        let dao = NoteDAO.sharedInstance
        dao.delegate = self
        dao.create(model)
    }
    
    //修改Note方法
    public func modifyNote(model: Note) {
        let dao = NoteDAO.sharedInstance
        dao.delegate = self
        dao.modify(model)
    }
    
    //删除Note方法
    public func removeNote(model: Note) {
        let dao = NoteDAO.sharedInstance
        dao.delegate = self
        dao.remove(model)
    }
    
    //查询所用数据方法
    public func findAllNotes() {
        let dao = NoteDAO.sharedInstance
        dao.delegate = self
        dao.findAll()
    }

    //MARK: --NoteDAODelegate 委托方法
    //查询所有数据方法 成功
    public func findAllFinished(list: NSMutableArray) {
        self.delegate.findAllNotesFinished?(list)
    }

    //查询所有数据方法 失败
    public func findAllFailed(error: NSError) {
        self.delegate.findAllNotesFailed?(error)
    }

    //插入Note方法 成功
    public func createFinished() {
        self.delegate.createNoteFinished?()
    }

    //插入Note方法 失败
    public func createFailed(error: NSError) {
        self.delegate.createNoteFailed?(error)
    }

    //删除Note方法 成功
    public func removeFinished() {
        self.delegate.removeNoteFinished?()
    }
    //删除Note方法 失败
    public func removeFailed(error: NSError) {
        self.delegate.removeNoteFailed?(error)
    }

    //修改Note方法 成功
    public func modifyFinished() {
        self.delegate.modifyNoteFinished?()
    }
    //修改Note方法 失败
    public func modifyFailed(error: NSError) {
        self.delegate.modifyNoteFailed?(error)
    }

}
