//
//  ViewController.m
//  SwitchSliderSegmentedControl
//
//  Created by 关东升 on 15/12/12.
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

@property (strong, nonatomic) UISwitch *rightSwitch;
@property (strong, nonatomic) UISwitch *leftSwitch;
@property (strong, nonatomic) UILabel *sliderValue;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect screen = [[UIScreen mainScreen] bounds];
    
    /// 1.添加rightSwitch控件
    //rightSwitch与屏幕左边距
    //leftSwitch与屏幕右边距
    CGFloat switchScreenSpace = 39;
    
    self.rightSwitch = [[UISwitch alloc] init];
    CGRect frame = self.rightSwitch.frame;
    frame.origin = CGPointMake(switchScreenSpace, 98);
    //重新设置控件的位置
    self.rightSwitch.frame = frame;
    //设置控件状态
    self.rightSwitch.on = TRUE;
    //指定事件处理方法
    [self.rightSwitch addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:self.rightSwitch];
    
    /// 2.添加rightSwitch控件
    self.leftSwitch = [[UISwitch alloc] init];
    frame = self.leftSwitch.frame;
    frame.origin = CGPointMake(screen.size.width - (frame.size.width + switchScreenSpace), 98);
    //重新设置控件的位置
    self.leftSwitch.frame = frame;
    //设置控件状态
    self.leftSwitch.on = TRUE;
    //指定事件处理方法
    [self.leftSwitch addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:self.leftSwitch];
    
    /// 3.添加segmentedControl控件
    NSArray* segments = @[@"Right", @"Left"];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:segments];
    
    CGFloat scWidth = 220;
    CGFloat scHeight = 29; //29默认高度
    CGFloat scTopView = 186;
    frame = CGRectMake((screen.size.width - scWidth)/2 , scTopView, scWidth, scHeight);
    //重新设置控件的位置
    segmentedControl.frame = frame;
    //指定事件处理方法
    [segmentedControl addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:segmentedControl];
    
    /// 4.添加slider控件
    CGFloat sliderWidth = 300;
    CGFloat sliderHeight = 31; //31默认高度
    CGFloat sliderdTopView = 298;
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake((screen.size.width - sliderWidth)/2 , sliderdTopView, sliderWidth, sliderHeight)];
    
    slider.minimumValue = 0.0f;
    slider.maximumValue = 100.0f;
    slider.value = 50.00f;
    
    //指定事件处理方法
    [slider addTarget:self action:@selector(sliderValueChange:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:slider];
    
    /// 5.添加SliderValue：标签
    //SliderValue：标签与Slider之间的距离
    CGFloat labelSliderValueSliderSpace = 30;
    UILabel* labelSliderValue = [[UILabel alloc] initWithFrame:CGRectMake(slider.frame.origin.x, slider.frame.origin.y - labelSliderValueSliderSpace, 103, 21)];
    labelSliderValue.text = @"SliderValue：";
    [self.view addSubview:labelSliderValue];
    
    /// 6.添加sliderValue标签
    self.sliderValue = [[UILabel alloc] initWithFrame:CGRectMake(labelSliderValue.frame.origin.x + 120, labelSliderValue.frame.origin.y, 50, 21)];
    self.sliderValue.text = @"50";
    [self.view addSubview:self.sliderValue];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//使两个开关的值保持一致
- (void)switchValueChanged:(id)sender {
    UISwitch *witchSwitch = (UISwitch *)sender;
    BOOL setting = witchSwitch.isOn;
    [self.leftSwitch setOn:setting animated:TRUE];
    [self.rightSwitch setOn:setting animated:TRUE];
}

//点击分段控件控制开关控件的隐藏或显示
- (void)touchDown:(id)sender {
    
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    NSLog(@"选择的段 : %li", segmentedControl.selectedSegmentIndex);
    
    if (self.leftSwitch.hidden) {
        self.rightSwitch.hidden = FALSE;
        self.leftSwitch.hidden  = FALSE;
    }else{
        self.leftSwitch.hidden  = TRUE;
        self.rightSwitch.hidden = TRUE;
    }
}

//用标签显示滑块的值
- (void)sliderValueChange:(id)sender {
    UISlider *slider = (UISlider *)sender;
    int progressAsInt = (int)(slider.value);
    NSString *newText = [[NSString alloc]initWithFormat:@"%d",progressAsInt];
    NSLog(@"滑块的值 : %@", newText);
    self.sliderValue.text = newText;
}

@end
