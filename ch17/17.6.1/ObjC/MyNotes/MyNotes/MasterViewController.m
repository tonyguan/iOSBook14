//
//  MasterViewController.m
//  MyNotes
//
//  Created by 关东升 on 15/12/31.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "NSNumber+Message.h"

enum ActionTypes {
    QUERY,      //查询操作
    REMOVE,     //删除操作
    ADD,        //添加操作
    MOD         //修改操作
};

@interface MasterViewController () {
    enum ActionTypes action;    //请求动作标识
    NSInteger deleteRowId;      //删除行号
}

@property(strong, nonatomic) DetailViewController *detailViewController;
//保存数据列表
@property(nonatomic, strong) NSMutableArray *listData;

//重新加载表视图
- (void)reloadView:(NSDictionary *)res;

//开始请求Web Service
- (void)startRequest;

@end

@implementation MasterViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.detailViewController = (DetailViewController *) [[self.splitViewController.viewControllers lastObject] topViewController];
    
    //查询请求数据
    action = QUERY;
    [self startRequest];
    
    //初始化UIRefreshControl
    UIRefreshControl *rc = [[UIRefreshControl alloc] init];
    rc.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
    [rc addTarget:self action:@selector(refreshTableView) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = rc;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) refreshTableView {
    if (self.refreshControl.refreshing) {
        self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"加载中..."];
        
        //查询请求数据
        action = QUERY;
        [self startRequest];
    }
}

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:TRUE];
//    action = QUERY;
//    [self startRequest];
//}


#pragma mark - 开始请求Web Service

- (void)startRequest {
    
    NSString *strURL = @"http://www.51work6.com/service/mynotes/WebService.php";
    
    NSURL *url = [NSURL URLWithString:strURL];
    
    NSString *post;
    if (action == QUERY) {//查询处理
        post = [NSString stringWithFormat:@"email=%@&type=%@&action=%@", @"<你的51work6.com用户邮箱>", @"JSON", @"query"];
    } else if (action == REMOVE) {//删除处理
        NSMutableDictionary *dict = self.listData[deleteRowId];
        post = [NSString stringWithFormat:@"email=%@&type=%@&action=%@&id=%@",
                @"<你的51work6.com用户邮箱>", @"JSON", @"remove", dict[@"ID"]];
    }
    
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    
    NSURLSessionConfiguration *defaultConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:defaultConfig delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      NSLog(@"请求完成...");
                                      if (!error) {
                                          NSDictionary *resDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                          
                                          if (action == QUERY) {//查询处理
                                              [self reloadView:resDict];
                                          } else if (action == REMOVE) {//删除处理
                                              
                                              NSNumber *resultCode = resDict[@"ResultCode"];
                                              NSString *message = @"操作成功。";
                                              if ([resultCode integerValue] < 0) {
                                                  message = [resultCode errorMessage];
                                              }
                                              
                                              UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示信息" message:message preferredStyle:UIAlertControllerStyleAlert];
                                              UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                                              [alertController addAction:okAction];
                                              //显示
                                              [self presentViewController:alertController animated:true completion:nil];
                                              
                                              //重新查询
                                              action = QUERY;
                                              [self startRequest];
                                          }
                                          
                                      } else {
                                          NSLog(@"error : %@", error.localizedDescription);
                                      }
                                  }];
    
    [task resume];
    
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSMutableDictionary *dict = self.listData[indexPath.row];
        DetailViewController *controller = (DetailViewController *) [[segue destinationViewController] topViewController];
        [controller setDetailItem:dict];
        //[controller setDetailContent:dict[@"Content"]];
        
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = TRUE;
    }
}

#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSMutableDictionary *dict = self.listData[indexPath.row];
    cell.textLabel.text = dict[@"Content"];
    cell.detailTextLabel.text = dict[@"CDate"];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //删除数据
        action = REMOVE;
        deleteRowId = indexPath.row;
        [self startRequest];
    }
}

#pragma mark - 重新加载表视图

- (void)reloadView:(NSDictionary *)res {
    
    [self.refreshControl endRefreshing];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
    
    NSNumber *resultCode = res[@"ResultCode"];
    
    if ([resultCode integerValue] >= 0) {
        self.listData = res[@"Record"];
        [self.tableView reloadData];
    } else {
        NSString *errorStr = [resultCode errorMessage];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"错误信息" message:errorStr preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:okAction];
        //显示
        [self presentViewController:alertController animated:true completion:nil];
    }
}


@end