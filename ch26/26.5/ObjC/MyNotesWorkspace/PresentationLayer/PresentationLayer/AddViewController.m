//
//  AddViewController.m
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

#import "AddViewController.h"
#import <BusinessLogicLayer/NoteBL.h>

@interface AddViewController () <UITextViewDelegate>

@property(weak, nonatomic) IBOutlet UITextView *txtView;
//BL对象
@property (nonatomic,strong) NoteBL *bl;

@end

@implementation AddViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.txtView becomeFirstResponder];
    
    self.bl = [[NoteBL alloc] init];
    [self.txtView becomeFirstResponder];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(createNoteFinished:)
                                                 name:BLCreateNoteFinishedNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(createNoteFailed:)
                                                 name:BLCreateNoteFailedNotification
                                               object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (IBAction)onclickCancel:(id)sender {
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

- (IBAction)onclickSave:(id)sender {

    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSDate *date = [[NSDate alloc] init];
    NSString* strDate  = [dateFormatter stringFromDate:date];
    
    Note *note = [[Note alloc] init];
    note.date = strDate;
    note.content = self.txtView.text;
    [self.bl createNote: note];
    
    [self.txtView resignFirstResponder];

}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return FALSE;
    }
    return TRUE;
}

//插入Note方法 成功
- (void)createNoteFinished:(NSNotification*)notification {
    
    UIAlertController* alertController  = [UIAlertController alertControllerWithTitle:@"操作信息" message: @"插入成功。"preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* noAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [self dismissViewControllerAnimated:TRUE completion:nil];
    }];
    
    UIAlertAction* yesAction = [UIAlertAction actionWithTitle:@"继续" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        self.txtView.text = @"";
        [self.txtView becomeFirstResponder];
    }];
    
    [alertController addAction:noAction];
    [alertController addAction:yesAction];
    
    //显示
    [self presentViewController:alertController animated:TRUE completion:nil];
}

//插入Note方法 失败
- (void)createNoteFailed:(NSNotification*)notification {
    
    NSError *error = [notification object];
    NSString *errorStr = [error localizedDescription];
    
    UIAlertController* alertController  = [UIAlertController alertControllerWithTitle:@"操作信息" message: errorStr preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction* noAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [self dismissViewControllerAnimated:TRUE completion:nil];
    }];
    
    UIAlertAction* yesAction = [UIAlertAction actionWithTitle:@"继续" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        self.txtView.text = @"";
        [self.txtView becomeFirstResponder];
    }];
    
    [alertController addAction:noAction];
    [alertController addAction:yesAction];
    
    //显示
    [self presentViewController:alertController animated:TRUE completion:nil];
}

@end
