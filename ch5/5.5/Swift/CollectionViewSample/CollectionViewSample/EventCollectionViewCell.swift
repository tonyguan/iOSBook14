//
//  EventCollectionViewCell.swift
//  CollectionViewSample
//
//  Created by 关东升 on 15/12/15.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

import UIKit

class EventCollectionViewCell: UICollectionViewCell {
    
    var imageView: UIImageView!
    var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        /// 1.添加ImageView
        let cellWidth: CGFloat = self.frame.size.width
        
        let imageViewWidth: CGFloat = 101
        let imageViewHeight: CGFloat = 101
        let imageViewTopView: CGFloat = 15
        
        /// 1.添加ImageView
        self.imageView = UIImageView(frame: CGRectMake((cellWidth - imageViewWidth) / 2, imageViewTopView, imageViewWidth, imageViewHeight))
        
        self.addSubview(self.imageView)
        
        /// 2.添加标签
        let labelWidth: CGFloat = 101
        let labelHeight: CGFloat = 16
        let labelTopView: CGFloat = 120
        
        self.label = UILabel(frame: CGRectMake((cellWidth - labelWidth) / 2, labelTopView, labelWidth, labelHeight))
        
        //字体左右居中
        self.label.textAlignment = .Center
        //设置字体
        self.label.font = UIFont.systemFontOfSize(13)
        self.addSubview(self.label)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
