//
//  NoteDAO.m
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

#import "NoteDAO.h"
#import "NSNumber+Message.h"
#import <AFNetworking/AFNetworking.h>

#define WEBSERVICE_URL @"http://www.51work6.com/service/mynotes/WebService.php"
#define USER_ID  @"<你的51work6.com用户邮箱>"

@implementation NoteDAO

static NoteDAO *sharedSingleton = nil;

+ (NoteDAO *)sharedInstance {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedSingleton = [[self alloc] init];
    });
    return sharedSingleton;
}

#pragma mark --发出请求公共方法
- (void)requestWithURLString:(NSString *)aURLString
                      params:(NSString *)params
                  httpMethod:(NSString *)method
           completionHandler:(void (^)(id responseObject, NSError *error))completionHandler {
    
    NSURL *url = [NSURL URLWithString:aURLString];
    
    //设置参数
    NSData *postData = [params dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:method];
    [request setHTTPBody:postData];
    
    NSURLSessionConfiguration *defaultConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:defaultConfig];
    
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        NSLog(@"请求完成...");
        if (!error) {
            NSNumber *resultCodeNumber = [responseObject objectForKey:@"ResultCode"];
            NSInteger resultCode = [resultCodeNumber integerValue];
            
            if (resultCode >= 0) {
                if (completionHandler) {
                    completionHandler(responseObject, nil);
                }
            } else {
                NSString *message = [resultCodeNumber errorMessage];
                NSDictionary *userInfo = [NSDictionary dictionaryWithObject:message forKey:NSLocalizedDescriptionKey];
                NSError *error = [NSError errorWithDomain:@"DAO" code:resultCode userInfo:userInfo];
                
                if (completionHandler) {
                    completionHandler(responseObject, error);
                }
            }
        } else {
            NSLog(@"error : %@", error.localizedDescription);
            if (completionHandler) {
                completionHandler(responseObject, error);
            }
        }
    }];
    
    [task resume];
    
}


//插入Note方法
- (void)create:(Note *)model {
    //设置参数
    NSString *params = [NSString stringWithFormat:@"email=%@&type=%@&action=%@&date=%@&content=%@",
                    USER_ID, @"JSON", @"add", model.date, model.content];

    [self requestWithURLString:WEBSERVICE_URL
                        params:params
                    httpMethod:@"POST"
         completionHandler:^(id responseObject, NSError *error) {
             if (!error) {
                 [self.delegate createFinished];
             } else {
                 [self.delegate createFailed:error];
             }
         }];
}

//删除Note方法
- (void)remove:(Note *)model {
    //设置参数
    NSString *params = [NSString stringWithFormat:@"email=%@&type=%@&action=%@&id=%@",
                    USER_ID, @"JSON", @"remove", model.ID];

    [self requestWithURLString:WEBSERVICE_URL
                        params:params
                    httpMethod:@"POST"
         completionHandler:^(id responseObject, NSError *error) {
             if (!error) {
                 [self.delegate removeFinished];
             } else {
                 [self.delegate removeFailed:error];
             }
         }];
}

//修改Note方法
- (void)modify:(Note *)model {
    //设置参数
    NSString *params = [NSString stringWithFormat:@"email=%@&type=%@&action=%@&date=%@&content=%@&id=%@",
                    USER_ID, @"JSON", @"modify", model.date, model.content, model.ID];

    [self requestWithURLString:WEBSERVICE_URL
                        params:params
                    httpMethod:@"POST"
         completionHandler:^(id responseObject, NSError *error) {
             if (!error) {
                 [self.delegate modifyFinished];
             } else {
                 [self.delegate modifyFailed:error];
             }
         }];
}

//查询所有数据方法
- (void)findAll {
    //设置参数
    NSString *params = [NSString stringWithFormat:@"email=%@&type=%@&action=%@", USER_ID, @"JSON", @"query"];

    [self requestWithURLString:WEBSERVICE_URL
                        params:params
                    httpMethod:@"POST"
     completionHandler:^(id responseObject, NSError *error) {
         if (!error) {
             //从服务器返回数据
             NSMutableArray *listDict = [responseObject objectForKey:@"Record"];
             //准备返回给上层数据
             NSMutableArray *listData = [[NSMutableArray alloc] init];

             for (NSDictionary *dic in listDict) {
                 Note *note = [[Note alloc] init];
                 note.ID = dic[@"ID"];

                 NSString* strDate = dic[@"CDate"];
                 note.date = strDate;

                 note.content = dic[@"Content"];
                 [listData addObject:note];
             }
             [self.delegate findAllFinished:listData];
         } else {
             [self.delegate findAllFailed:error];
         }
     }];
}

//按照主键查询数据方法
- (void)findById:(Note *)model {
    //设置参数
    NSString *params = [NSString stringWithFormat:@"email=%@&type=%@&action=%@&id=%@", USER_ID, @"JSON", @"query", model.ID];

    [self requestWithURLString:WEBSERVICE_URL
                        params:params
                    httpMethod:@"POST"
             completionHandler:^(id responseObject, NSError *error) {
                 if (!error) {
                     //从服务器返回数据
                     NSMutableArray *listDict = [responseObject objectForKey:@"Record"];
                     NSDictionary *dic = listDict.lastObject;
                     Note *note = [[Note alloc] init];
                     note.ID = dic[@"ID"];
                     
                     NSString* strDate = dic[@"CDate"];
                     note.date = strDate;
                     
                     note.content = dic[@"Content"];
                     [self.delegate findByIdFinished:note];
                 } else {
                     [self.delegate findByIdFailed:error];
                 }
             }];
}


@end
