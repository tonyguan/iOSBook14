//
//  ViewController.m
//  PickerViewSample
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

@interface ViewController () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) UIPickerView *pickerView;
@property (strong, nonatomic) UILabel *label;

@property (nonatomic, strong) NSDictionary  *pickerData; //保存全部数据
@property (nonatomic, strong) NSArray  *pickerProvincesData;//当前的省数据
@property (nonatomic, strong) NSArray  *pickerCitiesData;//当前的省下面的市数据

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"provinces_cities"
                                           ofType:@"plist"];
    //获取属性列表文件中的全部数据
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    self.pickerData = dict;
    
    //省份名数据
    self.pickerProvincesData =  [self.pickerData allKeys];
    
    //默认取出第一个省的所有市的数据
    NSString *seletedProvince = [self.pickerProvincesData objectAtIndex:0];
    self.pickerCitiesData = [self.pickerData objectForKey:seletedProvince];
  
    CGRect screen = [[UIScreen mainScreen] bounds];
    
    /// 1.选择器
    CGFloat pickerViewWidth = 320;
    CGFloat pickerViewHeight = 162;
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, pickerViewWidth, pickerViewHeight)];
    
    //设置self为委托对象、self为数据源对象
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    
    [self.view addSubview:self.pickerView];
    
    /// 2.添加标签
    CGFloat labelWidth = 200;
    CGFloat labelHeight = 21;
    CGFloat labelTopView = 273;    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake((screen.size.width - labelWidth)/2 , labelTopView, labelWidth, labelHeight)];
    
    self.label.text = @"Label";
    //字体左右居中
    self.label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.label];
    
    /// 3.Button按钮
    UIButton* button= [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"Button" forState:UIControlStateNormal];
    
    CGFloat buttonWidth = 46;
    CGFloat buttonHeight = 30;
    CGFloat buttonTopView = 374;
    
    button.frame = CGRectMake((screen.size.width - buttonWidth)/2 , buttonTopView, buttonWidth, buttonHeight);
    //指定事件处理方法
    [button addTarget:self action:@selector(onclick:) forControlEvents: UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onclick:(id)sender {
    
    NSInteger row1 = [self.pickerView selectedRowInComponent:0];
    NSInteger row2 = [self.pickerView selectedRowInComponent:1];
    NSString *selected1 = [self.pickerProvincesData objectAtIndex:row1];
    NSString *selected2 = [self.pickerCitiesData objectAtIndex:row2];
    
    NSString *title = [[NSString alloc] initWithFormat:@"%@，%@市", selected1,selected2];
    
    self.label.text = title;
    
}

#pragma mark --实现协议UIPickerViewDataSource方法
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
        numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {//省份个数
        return [self.pickerProvincesData count];
    } else {//市的个数
        return [self.pickerCitiesData count];
    }
    
}

#pragma mark --实现协议UIPickerViewDelegate方法
-(NSString *)pickerView:(UIPickerView *)pickerView
            titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {//选择省份名
        return [self.pickerProvincesData objectAtIndex:row];
    } else {//选择市名
        return [self.pickerCitiesData objectAtIndex:row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView
            didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        NSString *seletedProvince = [self.pickerProvincesData objectAtIndex:row];
        NSArray *array = [self.pickerData objectForKey:seletedProvince];
        self.pickerCitiesData = array;
        [self.pickerView reloadComponent:1];
    }
}

@end
