//
//  ViewController.m
//  Create_Contacts
//
//  Created by 关东升 on 16/1/7.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

#import "ViewController.h"
#import <ContactsUI/ContactsUI.h>

@interface ViewController () <CNContactViewControllerDelegate>

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

//点击New Contact按钮
- (IBAction)newContactClick:(id)sender {
    
    CNMutableContact* contact = [[CNMutableContact alloc] init];
    contact.givenName = @"Tony";
    contact.familyName = @"Guan";
    
    CNContactViewController* controller = [CNContactViewController viewControllerForNewContact:contact];
    
    CNContactStore *contactStore = [[CNContactStore alloc] init];
    controller.contactStore = contactStore;
    controller.delegate = self;
    
    [self.navigationController pushViewController:controller animated:TRUE];

}

//点击Unknown Contact
- (IBAction)unknownContactClick:(id)sender {
    
    CNMutableContact* contact = [[CNMutableContact alloc] init];
    contact.givenName = @"Tony";
    contact.familyName = @"Guan";
    
    //设置Email属性
    CNLabeledValue* homeEmail = [[CNLabeledValue alloc] initWithLabel:CNLabelHome value:@"tony@sina.com"];
    CNLabeledValue* workEmail = [[CNLabeledValue alloc] initWithLabel:CNLabelWork value:@"tony@163.com"];
    // 添加Email到数据库
    contact.emailAddresses = @[homeEmail, workEmail];
    
    CNContactViewController* controller = [CNContactViewController viewControllerForUnknownContact:contact];
    
    CNContactStore *contactStore = [[CNContactStore alloc] init];
    
    controller.contactStore = contactStore;
    controller.delegate = self;
    
    [self.navigationController pushViewController:controller animated:TRUE];
    
}


@end
