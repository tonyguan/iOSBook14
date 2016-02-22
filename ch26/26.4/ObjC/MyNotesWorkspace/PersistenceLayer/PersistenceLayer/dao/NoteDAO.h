//
//  NoteDAO.h
//  PersistenceLayer
//
//  Created by 关东升 on 16/1/1.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

#import <Foundation/Foundation.h>
#import "Note.h"
#import "NoteDAODelegate.h"

@interface NoteDAO : NSObject

@property (weak, nonatomic) id <NoteDAODelegate> delegate;

+ (NoteDAO*)sharedInstance;

//插入Note方法
-(void) create:(Note*)model;

//删除Note方法
-(void) remove:(Note*)model;

//修改Note方法
-(void) modify:(Note*)model;

//查询所有数据方法
-(void) findAll;

//按照主键查询数据方法
-(void) findById:(Note*)model;

@end
