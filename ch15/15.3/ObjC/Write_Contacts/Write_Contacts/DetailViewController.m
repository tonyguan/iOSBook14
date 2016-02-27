//
//  DetailViewController.m
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

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CNContactStore *contactStore = [[CNContactStore alloc] init];
    
    NSArray *keysToFetch = @[CNContactFamilyNameKey, CNContactGivenNameKey, CNContactEmailAddressesKey, CNContactPhoneNumbersKey, CNContactImageDataKey];
    NSError *error = nil;
    CNContact *contact = [contactStore unifiedContactWithIdentifier:self.selectContact.identifier keysToFetch:keysToFetch error:&error];
    
    //保存查询出的联系人
    self.selectContact = contact;
    
    if (!error) {
        
        //取得姓名属性
        NSString *firstName = contact.givenName;
        NSString *lastName = contact.familyName;
        
        NSString *name = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
        [self.lblName setText:name];
        
        //取得Email属性
        NSArray<CNLabeledValue<NSString*>*> *emailAddresses = contact.emailAddresses;
        
        for (CNLabeledValue<NSString*>* emailProperty in emailAddresses) {
            
            if ([emailProperty.label isEqualToString:CNLabelWork]) {
                [self.txtWorkEmail setText:emailProperty.value];
            } else if ([emailProperty.label isEqualToString:CNLabelHome]) {
                [self.txtHomeEmail setText:emailProperty.value];
            } else {
                NSLog(@"%@: %@", @"其他Email", emailProperty.value);
            }
        }
        
        //取得电话号码属性
        NSArray<CNLabeledValue<CNPhoneNumber*>*> *phoneNumbers = contact.phoneNumbers;
        
        for (CNLabeledValue<CNPhoneNumber*>* phoneNumberProperty in phoneNumbers) {
            CNPhoneNumber *phoneNumber = phoneNumberProperty.value;
            
            if ([phoneNumberProperty.label isEqualToString:CNLabelPhoneNumberMobile]) {
                [self.txtMobile setText:phoneNumber.stringValue];
            } else if ([phoneNumberProperty.label isEqualToString:CNLabelPhoneNumberiPhone]) {
                [self.txtIPhone setText:phoneNumber.stringValue];
            } else {
                NSLog(@"%@: %@", @"其他电话", phoneNumber.stringValue);
            }
        }
        
        //取得个人图片
        NSData *photoData = contact.imageData;
        if(photoData){
            [self.imageView setImage:[UIImage imageWithData:photoData]];
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)saveClick:(id)sender {
    
    CNMutableContact* contact = [self.selectContact mutableCopy];
    
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
    [request updateContact:contact];
    
    CNContactStore *contactStore = [[CNContactStore alloc] init];
    NSError* error;
    [contactStore executeSaveRequest:request error:&error];
    
    if (!error) {
        //导航回根视图控制器ViewController
        [self.navigationController popToRootViewControllerAnimated:TRUE];
    } else {
        NSLog(@"error : %@", error.localizedDescription);
    }
}

- (IBAction)deleteClick:(id)sender {
    
    CNMutableContact* contact = [self.selectContact mutableCopy];

    CNSaveRequest* request = [[CNSaveRequest alloc] init];
    [request deleteContact:contact];
    
    CNContactStore *contactStore = [[CNContactStore alloc] init];
    NSError* error;
    [contactStore executeSaveRequest:request error:&error];
    
    if (!error) {
        //导航回根视图控制器ViewController
        [self.navigationController popToRootViewControllerAnimated:TRUE];
    } else {
        NSLog(@"error : %@", error.localizedDescription);
    }
    
}

@end
