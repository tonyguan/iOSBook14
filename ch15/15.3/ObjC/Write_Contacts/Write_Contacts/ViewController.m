//
//  ViewController.m
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

#import "ViewController.h"
#import "DetailViewController.h"
#import "AddViewController.h"

#import <Contacts/Contacts.h>

@interface ViewController () <UISearchBarDelegate, UISearchResultsUpdating>

@property(strong, nonatomic) UISearchController *searchController;

@property(strong, nonatomic) NSArray *listContacts;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //实例化UISearchController
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    //设置self为更新搜索结果对象
    self.searchController.searchResultsUpdater = self;
    //在搜索是背景设置为灰色
    self.searchController.dimsBackgroundDuringPresentation = FALSE;
    //将搜索栏放到表视图的表头中
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:TRUE];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //查询通信录中所有联系人
        self.listContacts = [self findAllContacts];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark --预处理Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        DetailViewController *detailViewController = [segue destinationViewController];
        detailViewController.selectContact = self.listContacts[indexPath.row];
    }
}

#pragma mark --查询通信录中所有联系人

- (NSArray*)findAllContacts {
    
    //返回的联系人集合
    id contacts = [[NSMutableArray alloc] init];
    
    NSArray *keysToFetch = @[CNContactFamilyNameKey, CNContactGivenNameKey];
    CNContactFetchRequest *fetchRequest = [[CNContactFetchRequest alloc] initWithKeysToFetch:keysToFetch];
    
    CNContactStore *contactStore = [[CNContactStore alloc] init];
    NSError *error = nil;
    [contactStore enumerateContactsWithFetchRequest:fetchRequest error:&error usingBlock:^(CNContact *_Nonnull contact, BOOL *_Nonnull stop) {
        if (!error) {
            [contacts addObject:contact];
        } else {
            NSLog(@"error : %@", error.localizedDescription);
        }
    }];
    
    return contacts;
}

#pragma mark --按照姓名查询通信录中的联系人

- (NSArray*)findContactsByName:(NSString *)searchName {
    
    //没有输入任何字符
    if ([searchName length] == 0) {
        //返回通信录中所有联系人
        return [self findAllContacts];
    }
    
    CNContactStore *contactStore = [[CNContactStore alloc] init];
    
    NSArray *keysToFetch = @[CNContactFamilyNameKey, CNContactGivenNameKey];
    NSPredicate *predicate = [CNContact predicateForContactsMatchingName:searchName];
    NSError *error = nil;
    id contacts = [contactStore unifiedContactsMatchingPredicate:predicate keysToFetch:keysToFetch error:&error];
    
    if (!error) {
        //没有错误情况下返回查询结果
        return contacts;
    } else {
        //如果有错误发生，返回通信录中所有联系人
        return [self findAllContacts];
    }
}

#pragma mark --实现UISearchBarDelegate协议方法

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
    [self updateSearchResultsForSearchController:self.searchController];
}

#pragma mark --实现UISearchResultsUpdating协议方法

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchString = searchController.searchBar.text;
    //查询
    self.listContacts = [self findContactsByName:searchString];
    [self.tableView reloadData];
}


#pragma mark - Table view data source

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


@end
