//
// Philosopher.m
//  DelegatePattern
//
//  Created by 关东升 on 15/12/30.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//


#import "Philosopher.h"

@implementation Philosopher

@synthesize delegate;

-(void) start {
    count= 0;
    timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(handle)userInfo:nil repeats:TRUE];
}

-(void)handle {
    switch (count) {
        case 0:
            [self.delegate sleep];
            count++;
            break;
        case 1:
            [self.delegate eat];
            count++;
            break;
        case 2:
            [self.delegate work];
            [timer  invalidate];
            break;
    }
}

@end
