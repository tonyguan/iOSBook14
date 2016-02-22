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

#import <PersistenceLayer/Note.h>
#import <BusinessLogicLayer/NoteBL.h>

@interface MasterViewController ()

//保存数据列表
@property(nonatomic, strong) NSMutableArray *listData;
//业务逻辑对象BL
@property(nonatomic, strong) NoteBL *bl;
//删除数据索引
@property (nonatomic,assign) NSUInteger deletedIndex;
//删除数据
@property (nonatomic,strong) Note *deletedNote;

@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

//    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
//    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (DetailViewController *) [[self.splitViewController.viewControllers lastObject] topViewController];

    self.bl = [[NoteBL alloc] init];
    [self.bl findAllNotes];

    //初始化UIRefreshControl
    UIRefreshControl *rc = [[UIRefreshControl alloc] init];
    rc.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
    [rc addTarget:self action:@selector(refreshTableView) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = rc;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(findAllNotesFinished:)
                                                 name:BLFindAllFinishedNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(findAllNotesFailed:)
                                                 name:BLFindAllFailedNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(removeNoteFinished:)
                                                 name:BLRemoveFinishedNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(removeNoteFailed:)
                                                 name:BLRemoveFailedNotification
                                               object:nil];
    
}

-(void) refreshTableView {
    if (self.refreshControl.refreshing) {
        self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"加载中..."];
        [self.bl findAllNotes];
    }
}


- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//- (void)insertNewObject:(id)sender {
//    if (!self.objects) {
//        self.objects = [[NSMutableArray alloc] init];
//    }
//    [self.objects insertObject:[NSDate date] atIndex:0];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Note *note = self.listData[indexPath.row];
        DetailViewController *controller = (DetailViewController *) [[segue destinationViewController] topViewController];
        [controller setDetailItem:note];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    Note *note = self.listData[indexPath.row];
    cell.textLabel.text = note.content;
    cell.detailTextLabel.text = note.date;

    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return TRUE;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        self.deletedIndex = indexPath.row;
        self.deletedNote = self.listData[indexPath.row];
        [self.bl removeNote: self.deletedNote];        
    }
}

#pragma mark - 处理通知
//查询所有数据方法 成功
- (void)findAllNotesFinished:(NSNotification*)notification {
    self.listData  =  [notification object];
    [self.tableView reloadData];
    if (self.refreshControl) {
        [self.refreshControl endRefreshing];
        self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
    }
}

//查询所有数据方法 失败
- (void)findAllNotesFailed:(NSNotification*)notification {
    
    NSError *error = [notification object];
    NSString *errorStr = [error localizedDescription];
    
    UIAlertController* alertController  = [UIAlertController alertControllerWithTitle:@"操作信息" message: errorStr preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [self dismissViewControllerAnimated:TRUE completion:nil];
    }];

    [alertController addAction:okAction];
    
    //显示
    [self presentViewController:alertController animated:TRUE completion:nil];

    if (self.refreshControl) {
        [self.refreshControl endRefreshing];
        self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
    }
}


//删除Note方法 成功
- (void)removeNoteFinished:(NSNotification*)notification {
    
    UIAlertController* alertController  = [UIAlertController alertControllerWithTitle:@"操作信息" message: @"删除成功。" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [self dismissViewControllerAnimated:TRUE completion:nil];
    }];
    
    [alertController addAction:okAction];
    
    //显示
    [self presentViewController:alertController animated:TRUE completion:nil];

    [self.listData removeObjectAtIndex: self.deletedIndex];
    
    [self.tableView reloadData];
    
}

//删除Note方法 失败
- (void)removeNoteFailed:(NSNotification*)notification {
    
    NSError *error = [notification object];
    NSString *errorStr = [error localizedDescription];
    
    UIAlertController* alertController  = [UIAlertController alertControllerWithTitle:@"操作信息" message: errorStr preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [self dismissViewControllerAnimated:TRUE completion:nil];
    }];
    
    [alertController addAction:okAction];
    
    //显示
    [self presentViewController:alertController animated:TRUE completion:nil];
    
    if (self.refreshControl) {
        [self.refreshControl endRefreshing];
        self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
    }    
}

@end
