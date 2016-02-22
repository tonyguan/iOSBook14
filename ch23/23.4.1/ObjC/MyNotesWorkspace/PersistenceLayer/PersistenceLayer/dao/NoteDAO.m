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

@interface NoteDAO() //声明NoteDAO扩展

//NoteDAO扩展中DateFormatter属性是私有的
@property (nonatomic,strong) NSDateFormatter *dateFormatter;

// NoteDAO扩展中沙箱目录中属性列表文件路径是私有的
@property (nonatomic,strong) NSString *plistFilePath;

@end


@implementation NoteDAO

static NoteDAO *sharedSingleton = nil;

+ (NoteDAO *)sharedInstance {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        sharedSingleton = [[self alloc] init];
        
        //初始化沙箱目录中属性列表文件路径
        sharedSingleton.plistFilePath = [sharedSingleton applicationDocumentsDirectoryFile];
        //初始化DateFormatter
        sharedSingleton.dateFormatter = [[NSDateFormatter alloc] init];
        [sharedSingleton.dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        //初始化属性列表文件
        [sharedSingleton createEditableCopyOfDatabaseIfNeeded];
        
    });
    return sharedSingleton;
}

//初始化属性列表文件
- (void)createEditableCopyOfDatabaseIfNeeded {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL dbexits = [fileManager fileExistsAtPath:self.plistFilePath];
    if (!dbexits) {
        
        NSBundle *frameworkBundle = [NSBundle bundleForClass:[NoteDAO class]];
        NSString *frameworkBundlePath = [frameworkBundle resourcePath];
        NSString *defaultDBPath = [frameworkBundlePath stringByAppendingPathComponent:@"NotesList.plist"];
        
        NSError *error;
        BOOL success = [fileManager copyItemAtPath:defaultDBPath toPath:self.plistFilePath error:&error];
        NSAssert(success, @"错误写入文件");
        
    }
    
}

- (NSString *)applicationDocumentsDirectoryFile {
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, TRUE) lastObject];
    NSString *path = [documentDirectory stringByAppendingPathComponent:@"NotesList.plist"];
    return path;
}


//插入Note方法
- (int)create:(Note *)model {
    
    NSMutableArray *array = [self readFromArray:self.plistFilePath];
    NSString *strDate = [self.dateFormatter stringFromDate:model.date];
    NSDictionary *dict = @{@"date" : strDate, @"content" : model.content};
    
    [array addObject:dict];
    
    [self write:array toFilePath:self.plistFilePath];
    
    return 0;
}

//删除Note方法
- (int)remove:(Note *)model {
    
    NSMutableArray *array = [self readFromArray:self.plistFilePath];
    
    for (NSDictionary *dict in array) {
        NSString *strDate = dict[@"date"];
        NSDate *date = [self.dateFormatter dateFromString:strDate];
        
        //比较日期主键是否相等
        if ([date isEqualToDate:model.date]) {
            [array removeObject:dict];
            [self write:array toFilePath:self.plistFilePath];
            break;
        }
    }
    return 0;
}

//修改Note方法
- (int)modify:(Note *)model {
    
    NSMutableArray *array = [self readFromArray:self.plistFilePath];
    
    for (NSDictionary *dict in array) {
        
        NSDate *date = [self.dateFormatter dateFromString:dict[@"date"]];
        
        //比较日期主键是否相等
        if ([date isEqualToDate:model.date]) {
            [dict setValue:model.content forKey:@"content"];
            [self write:array toFilePath:self.plistFilePath];
            break;
        }
    }
    return 0;
}

//查询所有数据方法
- (NSMutableArray *)findAll {
    
    NSMutableArray *array = [self readFromArray:self.plistFilePath];
    
    NSMutableArray *listData = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dict in array) {
        
        NSString *strDate = dict[@"date"];
        NSDate *date = [self.dateFormatter dateFromString:strDate];
        NSString *content = dict[@"content"];
        
        Note *note = [[Note alloc] initWithDate:date content:content];
        
        [listData addObject:note];
        
    }
    return listData;
}

//按照主键查询数据方法
- (Note *)findById:(Note *)model {
    
    NSMutableArray *array = [self readFromArray:self.plistFilePath];
    
    for (NSDictionary *dict in array) {
        
        NSString *strDate = dict[@"date"];
        NSDate *date = [self.dateFormatter dateFromString:strDate];
        NSString *content = dict[@"content"];
        
        //比较日期主键是否相等
        if ([date isEqualToDate:model.date]) {
            Note *note = [[Note alloc] initWithDate:date content:content];
            return note;
        }
    }
    return nil;
}

//从文件中读取数据到NSMutableArray
-(NSMutableArray*) readFromArray: (NSString*) path {
    //从文件读取到NSMutableData
    NSMutableData *data = [[NSMutableData alloc] initWithContentsOfFile:path];
    //反序列化到属性列表对象（NSMutableArray）
    NSMutableArray* array = [NSPropertyListSerialization propertyListWithData:data options:NSPropertyListMutableContainersAndLeaves format: NULL error:NULL];
    
    return array;
}

//写入NSMutableArray数据到文件中
-(void) write:(NSMutableArray*)array toFilePath: (NSString*) path {
    //把属性列表对象（NSMutableArray）序列化为NSData
    NSData * data = [NSPropertyListSerialization dataWithPropertyList:array format:NSPropertyListBinaryFormat_v1_0 options:NSPropertyListMutableContainersAndLeaves error:NULL];
    
    //写入到沙箱目录的序列化文件
    BOOL success = [data writeToFile:path atomically:YES];
    
    if (!success) {
        NSAssert(0, @"错误写入文件");
    }
}

@end
