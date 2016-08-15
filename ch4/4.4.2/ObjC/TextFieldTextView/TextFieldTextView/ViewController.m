//
//  ViewController.m
//  TextFieldTextView
//
//  Created by 关东升 on 15/12/11.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate, UITextViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect screen = [[UIScreen mainScreen] bounds];
    
    CGFloat textFieldWidth = 223;
    CGFloat textFieldHeight = 30;
    CGFloat textFieldTopView = 150;
    UITextField* textField = [[UITextField alloc] initWithFrame:CGRectMake((screen.size.width - textFieldWidth)/2 , textFieldTopView, textFieldWidth, textFieldHeight)];

    textField.borderStyle = UITextBorderStyleRoundedRect;

    textField.delegate = self;
    
    [self.view addSubview:textField];
    
    //labelName标签与textField之间的距离
    CGFloat labelNameTextFieldSpace = 30;
    UILabel* labelName = [[UILabel alloc] initWithFrame:CGRectMake(textField.frame.origin.x, textField.frame.origin.y - labelNameTextFieldSpace, 51, 21)];
    labelName.text = @"Name:";
    [self.view addSubview:labelName];
    
    CGFloat textViewWidth = 236;
    CGFloat textViewHeight = 198;
    CGFloat textViewTopView = 240;
    UITextView* textView = [[UITextView alloc] initWithFrame:CGRectMake((screen.size.width - textViewWidth)/2 , textViewTopView, textViewWidth, textViewHeight)];
    
    textView.text = @"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.";
    
    textView.delegate = self;
    
    [self.view addSubview:textView];
    
    //labelName标签与textView之间的距离
    CGFloat labelAbstractTextViewSpace = 30;
    UILabel* labelAbstract = [[UILabel alloc] initWithFrame:CGRectMake(textView.frame.origin.x, textView.frame.origin.y - labelAbstractTextViewSpace, 103, 21)];
    labelAbstract.text = @"Abstract:";
    [self.view addSubview:labelAbstract];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 实现UITextFieldDelegate委托协议方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"TextField获得焦点，点击return键");
    return TRUE;
}


#pragma mark - 实现UITextViewDelegate委托协议方法
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if([text isEqualToString:@"\n"]) {
        NSLog(@"TextView获得焦点，点击return键");
        return FALSE;
    }
    return TRUE;
}


@end
