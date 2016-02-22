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

@interface ViewController () <CNContactPickerDelegate>

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

#pragma mark - 实现表视图数据源协议

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


#pragma  --实现CNContactPickerDelegate委托协议

- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact {

    if (![self.listContacts containsObject:contact]) {
        [self.listContacts addObject:contact];
        [self.tableView reloadData];
    }

}

//- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContacts:(NSArray<CNContact *> *)contacts {
//
//    for (CNContact *contact in contacts) {
//        if (![self.listContacts containsObject:contact]) {
//            [self.listContacts addObject:contact];
//        }
//    }
//    [self.tableView reloadData];
//}

//- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty {
//    CNContact* contact = contactProperty.contact;
//    CNPhoneNumber* phoneNumber = (CNPhoneNumber*)contactProperty.value;
//
//    NSLog(@"%@", contact.givenName);
//    NSLog(@"%@", phoneNumber.stringValue);
//
//}

@end
