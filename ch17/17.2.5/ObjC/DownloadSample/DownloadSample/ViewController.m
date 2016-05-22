//
//  ViewController.m
//  DownloadSample
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

@interface ViewController () <NSURLSessionDownloadDelegate>

@property(weak, nonatomic) IBOutlet UIProgressView *progressView;
@property(weak, nonatomic) IBOutlet UIImageView *imageView1;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onClick:(id)sender {

    NSString *strURL = [[NSString alloc] initWithFormat:@"http://www.51work6.com/service/download.php?email=%@&FileName=test1.jpg", @"<你的51work6.com用户邮箱>"];

    NSURL *url = [NSURL URLWithString:strURL];

    NSURLSessionConfiguration *defaultConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:defaultConfig delegate:self delegateQueue:[NSOperationQueue mainQueue]];

    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:url];

    [downloadTask resume];

}

#pragma mark -- 实现NSURLSessionDownloadDelegate委托协议

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    
    float progress = totalBytesWritten * 1.0 / totalBytesExpectedToWrite;
    [self.progressView setProgress:progress animated:TRUE];
    NSLog(@"进度= %f", progress);
    NSLog(@"接收: %lld 字节 (已下载: %lld 字节)  期待: %lld 字节.", bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {

    NSLog(@"临时文件: %@\n", location);

    NSString *downloadsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, TRUE) objectAtIndex:0];

    NSString *downloadStrPath = [downloadsDir stringByAppendingPathComponent:@"test1.jpg"];
    NSURL *downloadURLPath = [NSURL fileURLWithPath:downloadStrPath];

    NSFileManager *fileManager = [NSFileManager defaultManager];

    NSError *error = nil;
    if ([fileManager fileExistsAtPath:downloadStrPath]) {
        [fileManager removeItemAtPath:downloadStrPath error:&error];
        if (error) {
            NSLog(@"删除文件失败: %@", error.localizedDescription);
        }
    }

    error = nil;

    if ([fileManager moveItemAtURL:location toURL:downloadURLPath error:&error]) {
        NSLog(@"文件保存: %@", downloadStrPath);
        UIImage *img = [UIImage imageWithContentsOfFile:downloadStrPath];
        self.imageView1.image = img;
        
    } else {
        NSLog(@"保存文件失败: %@", error.localizedDescription);
    }
}

@end
