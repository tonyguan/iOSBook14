//
//  ViewController.m
//  IndexTable
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

@interface ViewController ()

//从plist文件其中读取出来的数据
@property (nonatomic, strong) NSDictionary *dictData;
//小组名集合
@property (nonatomic, strong) NSArray *listGroupname;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"team_dictionary"
                                           ofType:@"plist"];
    //获取属性列表文件中的全部数据
    self.dictData = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    
    NSArray* tempList  = [self.dictData allKeys];
    //对key进行排序
    self.listGroupname = [tempList sortedArrayUsingSelector:@selector(compare:)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark --UITableViewDataSource 协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //按照节索引从小组名数组中获得组名
    NSString *groupName = self.listGroupname[section];
    //按照组名做为key，从字典中取出球队数组集合
    NSArray *listTeams = self.dictData[groupName];
    return [listTeams count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //获得选择的节
    NSUInteger section = [indexPath section];
    //获得选择节中的，选中的行索引
    NSUInteger row = [indexPath row];
    //按照节索引从小组名数组中获得组名
    NSString *groupName = self.listGroupname[section];
    //按照组名做为key，从字典中取出球队数组集合
    NSArray *listTeams = self.dictData[groupName];
    
    cell.textLabel.text = listTeams[row];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.listGroupname count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *groupName = self.listGroupname[section];
    return groupName;
}

-(NSArray *) sectionIndexTitlesForTableView: (UITableView *) tableView {
    NSMutableArray *listTitles = [[NSMutableArray alloc] init];
    //把 A组 -> A
    for (NSString *item in self.listGroupname) {
        NSString *title = [item  substringToIndex:1];
        [listTitles addObject:title];
    }
    return listTitles;
}

@end
