//
//  ViewController.m
//  MemoryLeakSample
//
//  Created by 关东升 on 16/1/19.
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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSBundle *bundle = [NSBundle mainBundle];
	NSString *plistPath = [bundle pathForResource:@"team"
                                           ofType:@"plist"];
    //获取属性列表文件中的全部数据
    NSArray *array = [[NSArray alloc] initWithContentsOfFile:plistPath];
    self.listTeams = array;
    [array release];
    
    //接收内存警告通知，调用handleMemoryWarning方法处理
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self
               selector:@selector(handleMemoryWarning)
                   name:UIApplicationDidReceiveMemoryWarningNotification
                 object:nil];
    
}

- (void)didReceiveMemoryWarning {
    NSLog(@"ViewController中didReceiveMemoryWarning调用");
    [super didReceiveMemoryWarning];
    //释放成员变量
    [_listTeams release];
}

//处理内存警告
-(void) handleMemoryWarning {
    NSLog(@"ViewController中handleMemoryWarning调用");
}

#pragma mark --UITableViewDataSource 协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.listTeams count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    NSUInteger row = [indexPath row];
    NSDictionary *rowDict = [self.listTeams objectAtIndex:row];
    cell.textLabel.text =  [rowDict objectForKey:@"name"];
    
    NSString *imagePath = [rowDict objectForKey:@"image"];
    imagePath = [imagePath stringByAppendingString:@".png"];
    cell.imageView.image = [UIImage imageNamed:imagePath];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}



#pragma mark --UITableViewDelegate 协议方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSUInteger row = [indexPath row];
    NSDictionary *rowDict = [self.listTeams objectAtIndex:row];
    NSString *rowValue  =  [rowDict objectForKey:@"name"];
    
	
	NSString *message = [[NSString alloc] initWithFormat:@"您选择了%@队。", rowValue];
	UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"请选择球队"
                                                   message:message
                                                  delegate:self
                                         cancelButtonTitle:@"Ok"
                                         otherButtonTitles:nil];
    [alert show];
    [alert release];
    [message release];
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
