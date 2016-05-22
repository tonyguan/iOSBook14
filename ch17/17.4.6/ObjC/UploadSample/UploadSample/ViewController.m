//
//  ViewController.m
//  UploadSample
//
//  Created by 关东升 on 16/1/11.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

#import "ViewController.h"
#import "AFNetworking.h"

@interface ViewController ()

@property(weak, nonatomic) IBOutlet UIProgressView *progressView;
@property(weak, nonatomic) IBOutlet UIImageView *imageView1;
@property(weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)onClick:(id)sender {
    
    NSString *uploadStrURL = @"http://www.51work6.com/service/upload.php";
    NSDictionary *params = @{@"email" : @"<你的51work6.com用户邮箱>"};
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"test2" ofType:@"jpg"];
    
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST"
                  URLString:uploadStrURL parameters:params
                  constructingBodyWithBlock:^(id <AFMultipartFormData> formData) {
                      [formData appendPartWithFileURL:[NSURL fileURLWithPath:filePath] name:@"file" fileName:@"1.jpg" mimeType:@"image/jpeg" error:nil];
                  } error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager uploadTaskWithStreamedRequest:request
                   progress:^(NSProgress *uploadProgress) {
                       NSLog(@"上传: %@", [uploadProgress localizedDescription]);
                       dispatch_async(dispatch_get_main_queue(), ^{
                           [self.progressView setProgress:uploadProgress.fractionCompleted];
                       });

                   }
                  completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
                      if (!error) {
                          NSLog(@"上传成功");
                          [self download];
                      } else {
                          NSLog(@"上传失败: %@", error.localizedDescription);
                      }
                  }];
    
    [uploadTask resume];
    
    self.label.text = @"上传进度";
    self.progressView.progress = 0.0;
}

- (void)download {

    NSString *strURL = [[NSString alloc] initWithFormat:@"http://www.51work6.com/service/download.php?email=%@&FileName=test1.jpg", @"<你的51work6.com用户邮箱>"];

    NSURL *url = [NSURL URLWithString:strURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    NSURLSessionConfiguration *defaultConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:defaultConfig];

    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress *downloadProgress) {

        NSLog(@"下载: %@", [downloadProgress localizedDescription]);

        dispatch_async(dispatch_get_main_queue(), ^{
            [self.progressView setProgress:downloadProgress.fractionCompleted animated:TRUE];
        });

    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {

        NSString *downloadsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, TRUE) objectAtIndex:0];
        NSString *downloadStrPath = [downloadsDir stringByAppendingPathComponent:[response suggestedFilename]];
        NSURL *downloadURLPath = [NSURL fileURLWithPath:downloadStrPath];

        return downloadURLPath;

    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {

        NSLog(@"下载文件保存: %@", filePath);
        NSData *imgData = [[NSData alloc] initWithContentsOfURL:filePath];
        UIImage *img = [UIImage imageWithData:imgData];
        self.imageView1.image = img;

    }];

    [downloadTask resume];

    self.label.text = @"下载进度";
    self.progressView.progress = 0.0;

}

@end
