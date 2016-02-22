//
//  NoteDAO.m
//  MyNotes
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


#import "NoteDAO.h"

@implementation NoteDAO


static NoteDAO *sharedSingleton = nil;

+ (NoteDAO*)sharedInstance {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        sharedSingleton = [[self alloc] init];
        
        //添加一些测试数据
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NSDate *date1 = [dateFormatter dateFromString:@"2016-01-01 16:01:03"];
        Note* note1 = [[Note alloc] initWithDate:date1 content:@"Welcome to MyNote."];
        
        NSDate *date2 = [dateFormatter dateFromString:@"2016-01-02 8:01:03"];
        Note* note2 = [[Note alloc] initWithDate:date2 content:@"欢迎使用MyNote。"];
        
        sharedSingleton.listData = [[NSMutableArray alloc] init];
        [sharedSingleton.listData addObject:note1];
        [sharedSingleton.listData addObject:note2];
        
    });
    return sharedSingleton;
}

//插入Note方法
-(int) create:(Note*)model {
    [self.listData addObject:model];
    return 0;
}

//删除Note方法
-(int) remove:(Note*)model {
    for (Note* note in self.listData) {
        //比较日期主键是否相等
        if ([note.date isEqualToDate:model.date]){
            [self.listData removeObject: note];
            break;
        }
    }
    
    return 0;
}

//修改Note方法
-(int) modify:(Note*)model {
    for (Note* note in self.listData) {
        //比较日期主键是否相等
        if ([note.date isEqualToDate:model.date]){
            note.content = model.content;
            break;
        }
    }
    return 0;
}

//查询所有数据方法
-(NSMutableArray*) findAll {
    return self.listData;
}

//按照主键查询数据方法
-(Note*) findById:(Note*)model {
    for (Note* note in self.listData) {
        //比较日期主键是否相等
        if ([note.date isEqualToDate:model.date]){
            return note;
        }
    }
    return nil;
}


@end
