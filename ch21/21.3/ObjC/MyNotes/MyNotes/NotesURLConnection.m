//
//  NotesURLConnection.m
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


#import "NotesURLConnection.h"

@implementation NotesURLConnection

//查询所有数据方法
- (void)findAll {

    NSString *strURL = @"http://www.51work6.com/service/mynotes/WebService.php";

    NSURL *url = [NSURL URLWithString:strURL];

    NSString *post = [NSString stringWithFormat:@"email=%@&type=%@&action=%@", @"<你的51work6.com用户邮箱>", @"JSON", @"query"];
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];

    NSURLSessionConfiguration *defaultConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:defaultConfig delegate:nil delegateQueue:[NSOperationQueue mainQueue]];

    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:
            ^(NSData *data, NSURLResponse *response, NSError *error) {
                NSLog(@"请求完成...");
                if (!error) {
                    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                    [self.delegate findAllFinished:dict];
                } else {
                    NSLog(@"error : %@", error.localizedDescription);
                    [self.delegate findAllFailed:error];
                }
            }];

    [task resume];

}

@end
