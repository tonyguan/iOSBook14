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

#import <CoreData/CoreData.h>
#import "NoteDAO.h"
#import "NoteManagedObject.h"

@interface NoteDAO() //声明NoteDAO扩展

//NoteDAO扩展中DateFormatter属性是私有的
@property (nonatomic,strong) NSDateFormatter *dateFormatter;

@end

@implementation NoteDAO

static NoteDAO *sharedSingleton = nil;

+ (NoteDAO *)sharedInstance {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        sharedSingleton = [[self alloc] init];
        
        //初始化DateFormatter
        sharedSingleton.dateFormatter = [[NSDateFormatter alloc] init];
        [sharedSingleton.dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
    });
    return sharedSingleton;
}

//插入Note方法
- (int)create:(Note *)model {
    
    NSManagedObjectContext *cxt = [self managedObjectContext];
    
    NoteManagedObject *note = [NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:cxt];
    note.date = model.date;
    note.content = model.content;
    
    //保存数据
    [self saveContext];
    
    return 0;
}

//删除Note方法
- (int)remove:(Note *)model {
    
    NSManagedObjectContext *cxt = [self managedObjectContext];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Note" inManagedObjectContext:cxt];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"date = %@", model.date];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *listData = [cxt executeFetchRequest:request error:&error];
    
    if (error == nil && [listData count] > 0) {
        NoteManagedObject *note = [listData lastObject];
        [self.managedObjectContext deleteObject:note];
        //保存数据
        [self saveContext];
    }
    
    return 0;
}

//修改Note方法
- (int)modify:(Note *)model {
    
    NSManagedObjectContext *cxt = [self managedObjectContext];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Note" inManagedObjectContext:cxt];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"date = %@", model.date];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *listData = [cxt executeFetchRequest:request error:&error];
    
    if (error == nil && [listData count] > 0) {
        NoteManagedObject *note = [listData lastObject];
        note.content = model.content;
        //保存数据
        [self saveContext];
    }
    return 0;
}

//查询所有数据方法
- (NSMutableArray *)findAll {
    
    NSManagedObjectContext *cxt = [self managedObjectContext];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Note" inManagedObjectContext:cxt];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = entity;
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:TRUE];
    NSArray *sortDescriptors = @[sortDescriptor];
    fetchRequest.sortDescriptors = sortDescriptors;
    
    NSError *error = nil;
    NSArray *listData = [cxt executeFetchRequest:fetchRequest error:&error];
    
    if (error != nil) {
        return nil;
    }
    
    NSMutableArray *resListData = [[NSMutableArray alloc] init];
    for (NoteManagedObject *mo in listData) {
        Note *note = [[Note alloc] initWithDate:mo.date content:mo.content];
        [resListData addObject:note];
    }
    
    return resListData;
}

//按照主键查询数据方法
- (Note *)findById:(Note *)model {
    
    NSManagedObjectContext *cxt = [self managedObjectContext];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Note" inManagedObjectContext:cxt];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = entity;
    fetchRequest.predicate = [NSPredicate predicateWithFormat: @"date = %@",model.date];
    
    NSError *error = nil;
    NSArray *listData = [cxt executeFetchRequest:fetchRequest error:&error];

    if (error == nil && [listData count] > 0) {
        NoteManagedObject *mo = [listData lastObject];
        Note *note = [[Note alloc] initWithDate:mo.date content:mo.content];
        return note;
    }
    return nil;
}


@end
