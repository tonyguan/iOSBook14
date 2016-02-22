//
//  ViewController.swift
//  CollectionViewSample
//
//  Created by 关东升 on 15/12/16.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var COL_NUM = 2;//每一行有几个单元格
    var events : NSArray!
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bundle = NSBundle.mainBundle()
        let plistPath = bundle.pathForResource("events", ofType: "plist")
        //获取属性列表文件中的全部数据
        self.events = NSArray(contentsOfFile: plistPath!)
        
        self.setupCollectionView()
        
    }
    
    func setupCollectionView() {
        
        // 1.创建流式布局布局
        let layout = UICollectionViewFlowLayout()
        // 2.设置每个单元格的尺寸
        layout.itemSize = CGSizeMake(150, 150)
        // 3.设置整个collectionView的内边距
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        // 4.设置每一行之间的间距
        layout.minimumLineSpacing = 10
        // 5.设置单元格之间的间距
        layout.minimumInteritemSpacing = 10
        
        self.collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        
        //设置可重用单元格标识与单元格类型
        self.collectionView.registerClass(EventCollectionViewCell.self, forCellWithReuseIdentifier: "cellIdentifier" )
        
        self.collectionView.backgroundColor = UIColor.whiteColor()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.view.addSubview(self.collectionView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: -- UICollectionViewDataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        let num = self.events.count % COL_NUM
        if (num == 0) {//偶数
            return self.events.count / COL_NUM
        } else {        //奇数
            return self.events.count / COL_NUM + 1
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return COL_NUM
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cellIdentifier", forIndexPath: indexPath) as! EventCollectionViewCell
        
        let event = self.events[indexPath.section * COL_NUM + indexPath.row] as! NSDictionary
        cell.label.text = event["name"] as? String
        cell.imageView.image = UIImage(named: event["image"] as! String)
        
        return cell
    }
    
    //MARK: --UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let event = self.events[indexPath.section * COL_NUM + indexPath.row] as! NSDictionary
        NSLog("select event name : %@", event["name"] as! String)
        
    }
}

