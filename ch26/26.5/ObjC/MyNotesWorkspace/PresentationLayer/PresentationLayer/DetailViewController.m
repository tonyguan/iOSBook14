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

#import <BusinessLogicLayer/NoteBL.h>
#import <PersistenceLayer/Note.h>

@interface DetailViewController () <UITextViewDelegate>

@property(weak, nonatomic) IBOutlet UITextView *txtView;
//BL对象
@property (nonatomic,strong) NoteBL *bl;

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
        Note *note = self.detailItem;
        self.txtView.text = note.content;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureView];
    
    self.bl = [[NoteBL alloc] init];
    [self.txtView becomeFirstResponder];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(modifyNoteFinished:)
                                                 name:BLModifyFinishedNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(modifyNoteFailed:)
                                                 name:BLModifyFailedNotification
                                               object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (IBAction)onclickSave:(id)sender {
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSDate *date = [[NSDate alloc] init];
    NSString* strDate  = [dateFormatter stringFromDate:date];

    Note *note = self.detailItem;
    note.date = strDate;
    note.content = self.txtView.text;
    
    [self.bl modifyNote:note];
    
    [self.txtView resignFirstResponder];
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

//修改Note方法 成功
- (void)modifyNoteFinished:(NSNotification*)notification {
    
    UIAlertController* alertController  = [UIAlertController alertControllerWithTitle:@"操作信息" message: @"修改成功。" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [self dismissViewControllerAnimated:TRUE completion:nil];
    }];
    
    [alertController addAction:okAction];
    
}

//修改Note方法 失败
- (void)modifyNoteFailed:(NSNotification*)notification {
    
    NSError *error = [notification object];
    NSString *errorStr = [error localizedDescription];
    UIAlertController* alertController  = [UIAlertController alertControllerWithTitle:@"操作信息" message: errorStr preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [self dismissViewControllerAnimated:TRUE completion:nil];
    }];
    
    [alertController addAction:okAction];    
}


@end
