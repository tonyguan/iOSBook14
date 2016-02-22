//
//  ViewController.m
//  MyFriend
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

@interface ViewController () <CNContactPickerDelegate, CNContactViewControllerDelegate>

@property(strong, nonatomic) NSMutableArray *listContacts;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.listContacts = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selectContacts:(id)sender {
    
    CNContactPickerViewController *contactPicker = [[CNContactPickerViewController alloc] init];
    contactPicker.delegate = self;
    contactPicker.displayedPropertyKeys = @[CNContactPhoneNumbersKey];
    
    [self presentViewController:contactPicker animated:TRUE completion:nil];
    
}

#pragma mark --实现表视图数据源协议

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.listContacts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    CNContact *contact = self.listContacts[indexPath.row];
    NSString *firstName = contact.givenName;
    NSString *lastName = contact.familyName;
    
    NSString *name = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
    cell.textLabel.text = name;
    
    return cell;
}

#pragma mark --表视图委托协议
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CNContactStore* contactStore = [[CNContactStore alloc] init];
    
    CNContact *selectedContact = self.listContacts[indexPath.row];
    
    id keysToFetch = @[[CNContactViewController descriptorForRequiredKeys]];
    NSError *error;
    CNContact *contact = [contactStore unifiedContactWithIdentifier:selectedContact.identifier keysToFetch:keysToFetch error:&error];

    if (!error) {
        CNContactViewController* controller = [CNContactViewController viewControllerForContact:contact];
        controller.delegate = self;
        controller.contactStore = contactStore;
        controller.allowsEditing = TRUE;
        controller.allowsActions = TRUE;

        controller.displayedPropertyKeys = @[CNContactPhoneNumbersKey, CNContactEmailAddressesKey];

        [self.navigationController pushViewController:controller animated:TRUE];
    } else {
        NSLog(@"error : %@", error.localizedDescription);
    }

}

#pragma  --实现CNContactPickerDelegate委托协议

- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact {
    
    if (![self.listContacts containsObject:contact]) {
        [self.listContacts addObject:contact];
        [self.tableView reloadData];
    }
}

#pragma  --实现CNContactViewControllerDelegate委托协议

- (BOOL)contactViewController:(CNContactViewController *)viewController
        shouldPerformDefaultActionForContactProperty:(CNContactProperty *)property {
    return TRUE;
}

@end
