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

@property (weak, nonatomic) IBOutlet UISwitch *rightSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *leftSwitch;
@property (weak, nonatomic) IBOutlet UILabel *sliderValue;

- (IBAction)switchValueChanged:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//使两个开关的值保持一致
- (IBAction)switchValueChanged:(id)sender {
    UISwitch *witchSwitch = (UISwitch *)sender;
    BOOL setting = witchSwitch.isOn;
    [self.leftSwitch setOn:setting animated:TRUE];
    [self.rightSwitch setOn:setting animated:TRUE];
}

//点击分段控件控制开关控件的隐藏或显示
- (IBAction)touchDown:(id)sender {
    
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
- (IBAction)sliderValueChange:(id)sender {
    UISlider *slider = (UISlider *)sender;
    int progressAsInt = (int)(slider.value);
    NSString *newText = [[NSString alloc]initWithFormat:@"%i",progressAsInt];
    NSLog(@"滑块的值 : %@", newText);
    self.sliderValue.text = newText;
}

@end
