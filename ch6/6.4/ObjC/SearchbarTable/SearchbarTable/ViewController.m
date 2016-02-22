//
//  ViewController.m
//  SimpleTable
//
//  Created by 关东升 on 15/12/16.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

#import "ViewController.h"

@interface ViewController ()  <UISearchBarDelegate, UISearchResultsUpdating>

@property (strong, nonatomic) UISearchController *searchController;

//全部数据
@property (nonatomic, strong) NSArray *listTeams;
//过滤后的数据
@property (nonatomic, strong) NSMutableArray *listFilterTeams;

//内容过滤方法
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSUInteger)scope;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"team"
                                           ofType:@"plist"];
    //获取属性列表文件中的全部数据
    self.listTeams = [[NSArray alloc] initWithContentsOfFile:plistPath];
    
    //初次进入查询所有数据
    [self filterContentForSearchText:@"" scope:-1];
    
    //实例化UISearchController
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    //设置self为更新搜索结果对象
    self.searchController.searchResultsUpdater = self;
    //在搜索是背景设置为灰色
    self.searchController.dimsBackgroundDuringPresentation = FALSE;
    
    //设置搜索范围栏中的按钮
    self.searchController.searchBar.scopeButtonTitles = @[@"中文", @"英文"];
    self.searchController.searchBar.delegate = self;
    
    //将搜索栏放到表视图的表头中
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    [self.searchController.searchBar sizeToFit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark --内容过滤方法
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSUInteger)scope {
    
    if([searchText length]==0) {
        //查询所有
        self.listFilterTeams = [NSMutableArray arrayWithArray:self.listTeams];
        return;
    }
    
    NSPredicate *scopePredicate;
    NSArray *tempArray ;
    
    switch (scope) {
        case 0://中文 name字段是中文名
            scopePredicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@",searchText];
            tempArray =[self.listTeams filteredArrayUsingPredicate:scopePredicate];
            self.listFilterTeams = [NSMutableArray arrayWithArray:tempArray];
            break;
        case 1: //英文 image字段保存英文名
            scopePredicate = [NSPredicate predicateWithFormat:@"SELF.image contains[c] %@",searchText];
            tempArray =[self.listTeams filteredArrayUsingPredicate:scopePredicate];
            self.listFilterTeams = [NSMutableArray arrayWithArray:tempArray];
            break;
        default:
            //查询所有
            self.listFilterTeams = [NSMutableArray arrayWithArray:self.listTeams];
            break;
    }
}


#pragma mark --UITableViewDataSource 协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.listFilterTeams count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *) indexPath {
  
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    
    NSUInteger row = [indexPath row];
    
    NSDictionary *rowDict = self.listFilterTeams[row];
    cell.textLabel.text = rowDict[@"name"];
    cell.detailTextLabel.text = rowDict[@"image"];
    
    NSString *imagePath = [[NSString alloc] initWithFormat: @"%@.png", rowDict[@"image"]];
    cell.imageView.image = [UIImage imageNamed:imagePath];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark --实现UISearchBarDelegate协议方法
- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
    [self updateSearchResultsForSearchController:self.searchController];
}

#pragma mark --实现UISearchResultsUpdating协议方法
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchString = searchController.searchBar.text;
    //查询
    [self filterContentForSearchText:searchString scope:searchController.searchBar.selectedScopeButtonIndex];
    [self.tableView reloadData];
}

@end
