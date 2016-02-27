//
//  DetailViewController.m
//  Read_Contacts
//
//  Created by 关东升 on 16/1/4.
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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CNContactStore *contactStore = [[CNContactStore alloc] init];
    
    NSArray *keysToFetch = @[CNContactFamilyNameKey, CNContactGivenNameKey, CNContactEmailAddressesKey, CNContactPhoneNumbersKey, CNContactImageDataKey];
    NSError *error = nil;
    CNContact *contact = [contactStore unifiedContactWithIdentifier:self.selectContact.identifier keysToFetch:keysToFetch error:&error];
    
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
                [self.lblWorkEmail setText:emailProperty.value];
            } else if ([emailProperty.label isEqualToString:CNLabelHome]) {
                [self.lblHomeEmail setText:emailProperty.value];
            } else {
                NSLog(@"%@: %@", @"其他Email", emailProperty.value);
            }
        }
        
        //取得电话号码属性
        NSArray<CNLabeledValue<CNPhoneNumber*>*> *phoneNumbers = contact.phoneNumbers;
        
        for (CNLabeledValue<CNPhoneNumber*>* phoneNumberProperty in phoneNumbers) {
            CNPhoneNumber *phoneNumber = phoneNumberProperty.value;
            
            if ([phoneNumberProperty.label isEqualToString:CNLabelPhoneNumberMobile]) {
                [self.lblMobile setText:phoneNumber.stringValue];
            } else if ([phoneNumberProperty.label isEqualToString:CNLabelPhoneNumberiPhone]) {
                [self.lblIPhone setText:phoneNumber.stringValue];
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
    // Dispose of any resources that can be recreated.
}

@end
