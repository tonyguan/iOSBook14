//
//  ViewController.m
//  CollectionViewSample
//
//  Created by 关东升 on 15/12/14.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

#import "ViewController.h"
#import "EventCollectionViewCell.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
{
    int COL_NUM;//每一行有几个单元格
}

@property (strong, nonatomic) NSArray * events;

@property (strong, nonatomic) UICollectionView* collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"events"
                                           ofType:@"plist"];
    //获取属性列表文件中的全部数据
    self.events = [[NSArray alloc] initWithContentsOfFile:plistPath];
    
    COL_NUM = 2;
    
    [self setupCollectionView];

}

- (void) setupCollectionView {
    
    // 1.创建流式布局布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // 2.设置每个格子的尺寸
    layout.itemSize = CGSizeMake(150, 150);
    // 3.设置整个collectionView的内边距
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    // 4.设置每一行之间的间距
    layout.minimumLineSpacing = 10;
    // 5.设置单元格之间的间距
    layout.minimumInteritemSpacing = 10;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    
    //设置可重用单元格标识与单元格类型
    [self.collectionView registerClass:[EventCollectionViewCell class]  forCellWithReuseIdentifier:@"cellIdentifier" ];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;

    [self.view addSubview:self.collectionView];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    int num = [self.events count] % COL_NUM;
    if (num == 0) {//偶数
        return [self.events count] / COL_NUM;
    } else {        //奇数
        return [self.events count] / COL_NUM + 1;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return COL_NUM;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    EventCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    NSDictionary *event = self.events[indexPath.section * COL_NUM + indexPath.row];
    cell.label.text = event[@"name"];
    cell.imageView.image = [UIImage imageNamed:event[@"image"]];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *event = self.events[indexPath.section * COL_NUM  + indexPath.row];
    NSLog(@"select event name : %@", event[@"name"]);
    
}


@end
