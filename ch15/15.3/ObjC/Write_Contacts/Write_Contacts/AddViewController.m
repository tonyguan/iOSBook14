//
//  AddViewController.m
//  Write_Contacts
//
//  Created by 关东升 on 16/1/6.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

#import "AddViewController.h"

@interface AddViewController ()

@end

@implementation AddViewController


- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)saveClick:(id)sender {
    
    CNMutableContact* contact = [[CNMutableContact alloc] init];
    
    //设置姓名属性
    contact.familyName =  self.txtFirstName.text;
    contact.givenName =  self.txtLastName.text;
        
    // 设置电话号码
    CNPhoneNumber* mobilePhoneValue = [[CNPhoneNumber alloc] initWithStringValue:self.txtMobile.text];
    CNLabeledValue* mobilePhone = [[CNLabeledValue alloc] initWithLabel:CNLabelPhoneNumberMobile value:mobilePhoneValue];
    
    CNPhoneNumber* iPhoneValue = [[CNPhoneNumber alloc] initWithStringValue:self.txtIPhone.text];
    CNLabeledValue* iPhone = [[CNLabeledValue alloc] initWithLabel:CNLabelPhoneNumberiPhone value:iPhoneValue];
    
    // 添加电话号码到数据库
    contact.phoneNumbers = @[mobilePhone, iPhone];
    
    //设置Email属性
    CNLabeledValue* homeEmail = [[CNLabeledValue alloc] initWithLabel:CNLabelHome value:self.txtHomeEmail.text];
    CNLabeledValue* workEmail = [[CNLabeledValue alloc] initWithLabel:CNLabelWork value:self.txtWorkEmail.text];
    // 添加Email到数据库
    contact.emailAddresses = @[homeEmail, workEmail];
    
    //最后保存
    CNSaveRequest* request = [[CNSaveRequest alloc] init];
    [request addContact:contact toContainerWithIdentifier:nil];
    
    CNContactStore *contactStore = [[CNContactStore alloc] init];
    NSError* error;
    [contactStore executeSaveRequest:request error:&error];
    
    if (!error) {
        //关闭模态视图
        [self dismissViewControllerAnimated:TRUE completion:nil];
    } else {
        NSLog(@"error : %@", error.localizedDescription);
    }
    
}

- (IBAction)cancelClick:(id)sender {
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

@end
