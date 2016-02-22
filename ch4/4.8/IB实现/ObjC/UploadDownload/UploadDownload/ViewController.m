//
//  ViewController.m
//  UploadDownload
//
//  Created by 关东升 on 15/12/13.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property(nonatomic,strong) NSTimer *timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)startToMove:(id)sender {
    if ([self.activityIndicatorView isAnimating]) {
        [self.activityIndicatorView stopAnimating];
    }else{
        [self.activityIndicatorView startAnimating];
    }
}

- (IBAction)downloadProgress:(id)sender {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                    target:self
                                                  selector:@selector(download)
                                                  userInfo:nil
                                                   repeats:YES];
}

-(void)download{
    self.progressView.progress = self.progressView.progress+0.1;
    if (self.progressView.progress == 1.0) {
        [self.timer invalidate];
        
        UIAlertController* alertController  = [UIAlertController alertControllerWithTitle:@"download completed！" message: @"" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil];
        
        [alertController addAction:okAction];
        
        //显示
        [self presentViewController:alertController animated:true completion:nil];
    }
    
}

@end
