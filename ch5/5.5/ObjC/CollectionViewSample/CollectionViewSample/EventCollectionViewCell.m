//
//  EventCollectionViewCell.m
//  CollectionViewSample
//
//  Created by 关东升 on 2016-2-18.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

#import "EventCollectionViewCell.h"

@implementation EventCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //单元格的宽度
        CGFloat cellWidth = self.frame.size.width;
        
        CGFloat imageViewWidth = 101;
        CGFloat imageViewHeight = 101;
        CGFloat imageViewTopView = 15;
        
        /// 1.添加ImageView
        self.imageView = [[UIImageView alloc] initWithFrame: CGRectMake((cellWidth - imageViewWidth) / 2, imageViewTopView, imageViewWidth, imageViewHeight)];
        
        [self addSubview:self.imageView];
        
        /// 2.添加标签
        CGFloat labelWidth = 101;
        CGFloat labelHeight = 16;
        CGFloat labelTopView = 120;
        self.label = [[UILabel alloc] initWithFrame:CGRectMake((cellWidth - labelWidth) / 2, labelTopView, labelWidth, labelHeight)];
        //字体左右居中
        self.label.textAlignment = NSTextAlignmentCenter;
        //设置字体
        self.label.font = [UIFont systemFontOfSize:13];
        [self addSubview:self.label];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
