//
//  CustomCell.m
//  CustomCell
//
//  Created by 关东升 on 15/12/20.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

#import "CustomCell.h"

@implementation CustomCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        //单元格的宽度
        CGFloat cellWidth = self.frame.size.width;
        CGFloat cellHeight = self.frame.size.height;
        
        CGFloat imageViewWidth = 49;
        CGFloat imageViewHeight = 35;
        CGFloat imageViewRightView = 38;
        
        /// 1.添加ImageView
        self.myImageView = [[UIImageView alloc] initWithFrame: CGRectMake(cellWidth - (imageViewRightView + imageViewWidth),  (cellHeight - imageViewHeight) / 2, imageViewWidth, imageViewHeight)];
        
        [self addSubview:self.myImageView];
        
        /// 2.添加标签
        CGFloat labelWidth = 101;
        CGFloat labelHeight = 21;
        CGFloat labelLeftView = 38;
        self.myLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelLeftView, (cellHeight - labelHeight) / 2, labelWidth, labelHeight)];
        
        [self addSubview:self.myLabel];
    }
    
    return self;
}

@end
