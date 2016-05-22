//
//  DetailViewController.m
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

#import "DetailViewController.h"
#import "NSNumber+Message.h"

@interface DetailViewController () <UITextViewDelegate>

@property(weak, nonatomic) IBOutlet UITextView *txtView;

//开始请求Web Service
- (void)startRequest;

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;

        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        if (self.txtView != nil) {
            NSDictionary *dict = (NSDictionary*)self.detailItem;
            self.txtView.text = dict[@"Content"];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    [self.txtView becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onclickSave:(id)sender {
    [self startRequest];
    [self.txtView resignFirstResponder];
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}


#pragma mark - 开始请求Web Service
- (void)startRequest {
    //准备参数
    NSDate *date = [[NSDate alloc] init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    
    NSDictionary *dict = (NSDictionary*)self.detailItem;
    NSNumber* _id = (NSNumber*)dict[@"ID"];
    
    //设置参数
    NSString *post = [NSString stringWithFormat:@"email=%@&type=%@&action=%@&date=%@&content=%@&id=%@",
                                                @"<你的51work6.com用户邮箱>", @"JSON", @"modify", dateStr, self.txtView.text, _id];
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *strURL = @"http://www.51work6.com/service/mynotes/WebService.php";

    NSURL *url = [NSURL URLWithString:strURL];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];

    NSURLSessionConfiguration *defaultConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:defaultConfig delegate:nil delegateQueue:[NSOperationQueue mainQueue]];

    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:
            ^(NSData *data, NSURLResponse *response, NSError *error) {
                NSLog(@"请求完成...");
                if (!error) {
                    NSDictionary *resDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];

                    NSNumber *resultCode = resDict[@"ResultCode"];
                    NSString *message = @"操作成功。";
                    if ([resultCode integerValue] < 0) {
                        message = [resultCode errorMessage];
                    }

                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示信息" message:message preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler: nil];
                    [alertController addAction:okAction];
                    //显示
                    [self presentViewController:alertController animated:true completion:nil];

                } else {
                    NSLog(@"error : %@", error.localizedDescription);
                }
            }];

    [task resume];
}


@end
