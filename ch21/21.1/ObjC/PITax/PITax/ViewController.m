//
//  ViewController.m
//  PITax
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

@property (weak, nonatomic) IBOutlet UITextField *txtRevenue;
@property (weak, nonatomic) IBOutlet UILabel *lblTax;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onClick:(id)sender {
    //关闭键盘
    [self.txtRevenue resignFirstResponder];
    
    self.lblTax.text =[self calculate:self.txtRevenue.text];
}

//计算个人所得税
-(NSString*) calculate:(NSString*)revenue {
    
    //月应纳个人所得税税额
    double tax = 0.0f;
    
    if ([revenue length] > 0) {
        
        double dbRevenue = [revenue doubleValue];
        
        //月应纳税所得额
        double dbTaxRevenue = dbRevenue - 3500;
        
        //月应纳税所得额不超过1500元
        if (dbTaxRevenue <= 1500) {//失败 if (dbTaxRevenue >= 1500)
            tax = dbTaxRevenue * 0.03;
            //月应纳税所得额超过1500元至4500元
        } else if (dbTaxRevenue > 1500 && dbTaxRevenue <=4500) {
            tax = dbTaxRevenue * 0.1 - 105;
            //月应纳税所得额超过4500元至9000元
        } else if (dbTaxRevenue > 4500 && dbTaxRevenue <=9000) {
            tax = dbTaxRevenue * 0.2 - 555;
            //月应纳税所得额超过9000元至35000元
        } else if (dbTaxRevenue > 9000 && dbTaxRevenue <=35000) {
            tax = dbTaxRevenue * 0.25 - 1005;
            //月应纳税所得额超过35000元至55000元
        } else if (dbTaxRevenue > 35000 && dbTaxRevenue <=55000) {
            tax = dbTaxRevenue * 0.3 - 2755;
            //月应纳税所得额超过55000元至80000元
        } else if (dbTaxRevenue > 55000 && dbTaxRevenue <=80000) {
            tax = dbTaxRevenue * 0.35 - 5505;
            //月应纳税所得额超过80000元
        } else if (dbTaxRevenue > 80000) {
            tax = dbTaxRevenue * 0.45 - 13505;
        }
    }
    
    NSString* strTax = [NSString stringWithFormat:@"%.2f",tax<0?0:tax];
    return strTax;
}

@end
