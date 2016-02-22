//
//  ViewController.m
//  DeleteAddCell
//
//  Created by 关东升 on 15/12/22.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *txtField;

@property (strong, nonatomic) NSMutableArray *listTeams;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    self.navigationItem.rightBarButtonItem =  self.editButtonItem;
    self.navigationItem.title = @"单元格插入和删除";
    
    //设置单元格文本框
    self.txtField = [[UITextField alloc] init];
    self.txtField.hidden = TRUE;
    self.txtField.delegate = self;
    
    self.listTeams = [[NSMutableArray alloc] initWithObjects:@"黑龙江", @"吉林", @"辽宁", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -- UIViewController生命周期方法，用于响应视图编辑状态变化
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    
    [super setEditing:editing animated:animated];
    
    [self.tableView setEditing:editing animated:TRUE];
    
    if (editing) {
        self.txtField.hidden = FALSE;
    } else {
        self.txtField.hidden = TRUE;
    }
}

#pragma mark --UITableViewDataSource 协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.listTeams count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"CellIdentifier";
    
    BOOL b_addCell = (indexPath.row == self.listTeams.count);
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if (!b_addCell) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = self.listTeams[indexPath.row];
    } else {
        self.txtField.frame = CGRectMake(40,0,300,cell.frame.size.height);
        self.txtField.borderStyle = UITextBorderStyleNone;
        self.txtField.placeholder = @"Add...";
        self.txtField.text = @"";
        [cell addSubview:self.txtField];
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray* indexPaths = [NSArray arrayWithObject:indexPath];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.listTeams removeObjectAtIndex: indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
        [self.listTeams insertObject:self.txtField.text atIndex:[self.listTeams count]];
        [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
        
    }
    [self.tableView reloadData];
}

#pragma mark --UITableViewDelegate 协议方法
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == [self.listTeams count]) {
        return UITableViewCellEditingStyleInsert;
    } else {
        return UITableViewCellEditingStyleDelete;
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == [self.listTeams count]) {
        return FALSE;
    } else {
        return TRUE;
    }
}

#pragma mark -- UITextFieldDelegate委托方法,关闭键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return  TRUE;
}

@end
