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

#define FILE_NAME @"NotesList.archive"
#define ARCHIVE_KEY @"NotesList"

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

//初始化文件
- (void)createEditableCopyOfDatabaseIfNeeded {

    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL dbexits = [fileManager fileExistsAtPath:self.plistFilePath];

    if (!dbexits) {
        //添加一些测试数据
        NSDate *date1 = [self.dateFormatter dateFromString:@"2016-01-01 16:01:03"];
        Note *note1 = [[Note alloc] initWithDate:date1 content:@"Welcome to MyNote."];

        NSDate *date2 = [self.dateFormatter dateFromString:@"2016-01-02 8:01:03"];
        Note *note2 = [[Note alloc] initWithDate:date2 content:@"欢迎使用MyNote。"];

        NSMutableArray *array = [[NSMutableArray alloc] init];
        [array addObject:note1];
        [array addObject:note2];

        NSMutableData *theData = [NSMutableData data];
        NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:theData];
        [archiver encodeObject:array forKey:ARCHIVE_KEY];
        [archiver finishEncoding];

        [theData writeToFile:self.plistFilePath atomically:TRUE];
    }

}

- (NSString *)applicationDocumentsDirectoryFile {
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, TRUE) lastObject];
    NSString *path = [documentDirectory stringByAppendingPathComponent:FILE_NAME];
    return path;
}


//插入Note方法
- (int)create:(Note *)model {

    NSMutableArray *array = [self findAll];
    [array addObject:model];

    NSMutableData *theData = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:theData];
    [archiver encodeObject:array forKey:ARCHIVE_KEY];
    [archiver finishEncoding];

    [theData writeToFile:self.plistFilePath atomically:TRUE];

    return 0;
}

//删除Note方法
- (int)remove:(Note *)model {

    NSMutableArray *array = [self findAll];

    for (Note *note in array) {

        //比较日期主键是否相等
        if ([note.date isEqualToDate:model.date]) {
            [array removeObject:note];

            NSMutableData *theData = [NSMutableData data];
            NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:theData];
            [archiver encodeObject:array forKey:ARCHIVE_KEY];
            [archiver finishEncoding];
            [theData writeToFile:self.plistFilePath atomically:TRUE];

            break;
        }
    }

    return 0;
}

//修改Note方法
- (int)modify:(Note *)model {

    NSMutableArray *array = [self findAll];

    for (Note *note in array) {

        //比较日期主键是否相等
        if ([note.date isEqualToDate:model.date]) {

            note.content = model.content;

            NSMutableData *theData = [NSMutableData data];
            NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:theData];
            [archiver encodeObject:array forKey:ARCHIVE_KEY];
            [archiver finishEncoding];

            [theData writeToFile:self.plistFilePath atomically:TRUE];

            break;
        }
    }
    return 0;
}

//查询所有数据方法
- (NSMutableArray *)findAll {

    NSData *theData = [NSData dataWithContentsOfFile:self.plistFilePath];

    if ([theData length] > 0) {
        NSKeyedUnarchiver *archiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:theData];
        NSMutableArray *listData = [archiver decodeObjectForKey:ARCHIVE_KEY];
        [archiver finishDecoding];
        
        return listData;
    }
    return nil;
}

//按照主键查询数据方法
- (Note *)findById:(Note *)model {

    NSData *theData = [NSData dataWithContentsOfFile:self.plistFilePath];

    if ([theData length] > 0) {
        NSKeyedUnarchiver *archiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:theData];
        NSMutableArray *listData = [archiver decodeObjectForKey:ARCHIVE_KEY];
        [archiver finishDecoding];

        for (Note *note in listData) {
            //比较日期主键是否相等
            if ([note.date isEqualToDate:model.date]) {
                return note;
            }
        }
    }
    return nil;
}


@end
