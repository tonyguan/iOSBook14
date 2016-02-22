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
        
        if (error) {
            NSAssert(success, @"错误写入文件");
        }
    }

}

- (NSString *)applicationDocumentsDirectoryFile {
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, TRUE) lastObject];
    NSString *path = [documentDirectory stringByAppendingPathComponent:@"NotesList.plist"];
    return path;
}


//插入Note方法
- (int)create:(Note *)model {

    NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:self.plistFilePath];
    NSString *strDate = [self.dateFormatter stringFromDate:model.date];
    NSDictionary *dict = @{@"date" : strDate, @"content" : model.content};

    [array addObject:dict];

    [array writeToFile:self.plistFilePath atomically:TRUE];

    return 0;
}

//删除Note方法
- (int)remove:(Note *)model {

    NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:self.plistFilePath];

    for (NSDictionary *dict in array) {
        NSString *strDate = dict[@"date"];
        NSDate *date = [self.dateFormatter dateFromString:strDate];

        //比较日期主键是否相等
        if ([date isEqualToDate:model.date]) {
            [array removeObject:dict];
            [array writeToFile:self.plistFilePath atomically:TRUE];
            break;
        }
    }
    return 0;
}

//修改Note方法
- (int)modify:(Note *)model {

    NSArray *array = [[NSArray alloc] initWithContentsOfFile:self.plistFilePath];

    for (NSDictionary *dict in array) {

        NSDate *date = [self.dateFormatter dateFromString:dict[@"date"]];

        //比较日期主键是否相等
        if ([date isEqualToDate:model.date]) {
            [dict setValue:model.content forKey:@"content"];
            [array writeToFile:self.plistFilePath atomically:TRUE];
            break;
        }
    }
    return 0;
}

//查询所有数据方法
- (NSMutableArray *)findAll {

    NSArray *array = [[NSArray alloc] initWithContentsOfFile:self.plistFilePath];

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

    NSArray *array = [[NSArray alloc] initWithContentsOfFile:self.plistFilePath];

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


@end
