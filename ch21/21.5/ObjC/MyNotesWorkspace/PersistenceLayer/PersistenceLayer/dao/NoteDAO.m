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
#import "sqlite3.h"

#define DBFILE_NAME @"NotesList.sqlite3"

//声明NoteDAO扩展
@interface NoteDAO () {
    sqlite3 *db;
}

//NoteDAO扩展中DateFormatter属性是私有的
@property(nonatomic, strong) NSDateFormatter *dateFormatter;

// NoteDAO扩展中沙箱目录中属性列表文件路径是私有的
@property(nonatomic, strong) NSString *plistFilePath;

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

    const char *cpath = [self.plistFilePath UTF8String];

    if (sqlite3_open(cpath, &db) != SQLITE_OK) {
        NSLog(@"数据库打开失败。");
    } else {
        NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS Note (cdate TEXT PRIMARY KEY, content TEXT);"];
        const char *cSql = [sql UTF8String];

        if (sqlite3_exec(db, cSql, NULL, NULL, NULL) != SQLITE_OK) {
            NSLog(@"建表失败。");
        }
    }
    sqlite3_close(db);
}

- (NSString *)applicationDocumentsDirectoryFile {
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, TRUE) lastObject];
    NSString *path = [documentDirectory stringByAppendingPathComponent:DBFILE_NAME];
    return path;
}


//插入Note方法
- (int)create:(Note *)model {

    const char *cpath = [self.plistFilePath UTF8String];

    if (sqlite3_open(cpath, &db) != SQLITE_OK) {
        NSLog(@"数据库打开失败。");
    } else {
        NSString *sql = @"INSERT OR REPLACE INTO note (cdate, content) VALUES (?,?)";
        const char *cSql = [sql UTF8String];
        
        //语句对象
        sqlite3_stmt *statement;
        //预处理过程
        if (sqlite3_prepare_v2(db, cSql, -1, &statement, NULL) == SQLITE_OK) {

            NSString *strDate = [self.dateFormatter stringFromDate:model.date];
            const char *cDate = [strDate UTF8String];

            const char *cContent = [model.content UTF8String];

            //绑定参数开始
            sqlite3_bind_text(statement, 1, cDate, -1, NULL);
            sqlite3_bind_text(statement, 2, cContent, -1, NULL);

            //执行插入数据
            if (sqlite3_step(statement) != SQLITE_DONE) {
                NSLog(@"插入数据失败。");
            }
        }
        sqlite3_finalize(statement);
    }
    sqlite3_close(db);
    return 0;
}

//删除Note方法
- (int)remove:(Note *)model {

    const char *cpath = [self.plistFilePath UTF8String];

    if (sqlite3_open(cpath, &db) != SQLITE_OK) {
        NSLog(@"数据库打开失败。");
    } else {
        NSString *sql = @"DELETE  from note where cdate =?";
        const char *cSql = [sql UTF8String];

        //语句对象
        sqlite3_stmt *statement;
        //预处理过程
        if (sqlite3_prepare_v2(db, cSql, -1, &statement, NULL) == SQLITE_OK) {

            NSString *strDate = [self.dateFormatter stringFromDate:model.date];
            const char *cDate = [strDate UTF8String];

            //绑定参数开始
            sqlite3_bind_text(statement, 1, cDate, -1, NULL);
            //执行删除数据
            if (sqlite3_step(statement) != SQLITE_DONE) {
                NSLog(@"删除数据失败。");
            }
        }
        sqlite3_finalize(statement);
    }
    sqlite3_close(db);
    return 0;
}

//修改Note方法
- (int)modify:(Note *)model {

    const char *cpath = [self.plistFilePath UTF8String];

    if (sqlite3_open(cpath, &db) != SQLITE_OK) {
        NSLog(@"数据库打开失败。");
    } else {

        NSString *sql = @"UPDATE note set content=? where cdate =?";
        const char *cSql = [sql UTF8String];

         //语句对象
        sqlite3_stmt *statement;
        //预处理过程
        if (sqlite3_prepare_v2(db, cSql, -1, &statement, NULL) == SQLITE_OK) {

            NSString *strDate = [self.dateFormatter stringFromDate:model.date];
            const char *cDate = [strDate UTF8String];

            const char *cContent = [model.content UTF8String];

            //绑定参数开始
            sqlite3_bind_text(statement, 1, cContent, -1, NULL);
            sqlite3_bind_text(statement, 2, cDate, -1, NULL);
            //执行
            if (sqlite3_step(statement) != SQLITE_DONE) {
                NSLog(@"修改数据失败。");
            }
        }

        sqlite3_finalize(statement);

    }
    sqlite3_close(db);
    return 0;
}

//查询所有数据方法
- (NSMutableArray *)findAll {

    const char *cpath = [self.plistFilePath UTF8String];
    
    
    if (sqlite3_open(cpath, &db) != SQLITE_OK) {
        NSLog(@"数据库打开失败。");
    } else {

        NSString *sql = @"SELECT cdate,content FROM Note";
        const char *cSql = [sql UTF8String];

         //语句对象
        sqlite3_stmt *statement;
        //预处理过程
        if (sqlite3_prepare_v2(db, cSql, -1, &statement, NULL) == SQLITE_OK) {
            NSMutableArray *listData = [[NSMutableArray alloc] init];
            //执行查询
            while (sqlite3_step(statement) == SQLITE_ROW) {
                char *bufDate = (char *) sqlite3_column_text(statement, 0);
                NSString *strDate = [[NSString alloc] initWithUTF8String:bufDate];
                NSDate *date = [self.dateFormatter dateFromString:strDate];

                char *bufContent = (char *) sqlite3_column_text(statement, 1);
                NSString *strContent = [[NSString alloc] initWithUTF8String:bufContent];

                Note *note = [[Note alloc] initWithDate:date content:strContent];

                [listData addObject:note];
            }
            
            sqlite3_finalize(statement);
            sqlite3_close(db);
            
            return listData;
        }
        sqlite3_finalize(statement);
    }
    sqlite3_close(db);
    return nil;
}

//按照主键查询数据方法
- (Note *)findById:(Note *)model {

    const char *cpath = [self.plistFilePath UTF8String];

    if (sqlite3_open(cpath, &db) != SQLITE_OK) {
        NSLog(@"数据库打开失败。");
    } else {
        NSString *sql = @"SELECT cdate,content FROM Note where cdate =?";
        const char *cSql = [sql UTF8String];

         //语句对象
        sqlite3_stmt *statement;
        //预处理过程
        if (sqlite3_prepare_v2(db, cSql, -1, &statement, NULL) == SQLITE_OK) {
            //准备参数
            NSString *strDate = [self.dateFormatter stringFromDate:model.date];
            const char *cDate = [strDate UTF8String];

            //绑定参数开始
            sqlite3_bind_text(statement, 1, cDate, -1, NULL);

            //执行查询
            if (sqlite3_step(statement) == SQLITE_ROW) {

                char *bufDate = (char *) sqlite3_column_text(statement, 0);
                NSString *strDate = [[NSString alloc] initWithUTF8String:bufDate];
                NSDate *date = [self.dateFormatter dateFromString:strDate];

                char *bufContent = (char *) sqlite3_column_text(statement, 1);
                NSString *strContent = [[NSString alloc] initWithUTF8String:bufContent];

                Note *note = [[Note alloc] initWithDate:date content:strContent];

                sqlite3_finalize(statement);
                sqlite3_close(db);

                return note;
            }
        }
        sqlite3_finalize(statement);
    }
    sqlite3_close(db);
    return nil;
}

@end
