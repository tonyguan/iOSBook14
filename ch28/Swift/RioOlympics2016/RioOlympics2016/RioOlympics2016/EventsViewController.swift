//
//  EventsViewController.swift
//  RioOlympics2016
//
//  Created by 关东升 on 16/2/2.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

import UIKit
import BusinessLogicLayer
import PersistenceLayer

class EventsViewController: UICollectionViewController {
   
    //一行中列数
    ///如果是iPhone设备，列数为2
    var COL_COUNT = 2
    
    var events : NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad {
            //如果是iPad设备，列数为5
            COL_COUNT = 5
        }

        if (self.events == nil || self.events.count == 0) {
            let bl = EventsBL()
            //获取全部数据
            let array = bl.readData()
            self.events = array
            self.collectionView?.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
        if segue.identifier == "showDetail" {
            
            let indexPaths = self.collectionView?.indexPathsForSelectedItems()
            let indexPath = indexPaths![0]
            
            let event = self.events[indexPath.section * COL_COUNT + indexPath.row] as! Events
            let detailVC = segue.destinationViewController as! EventsDetailViewController
            detailVC.event = event
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return self.events.count / COL_COUNT
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return COL_COUNT
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! EventsViewCell

        let index = indexPath.section * COL_COUNT + indexPath.row
        
        let event = self.events.objectAtIndex(index) as! Events
        cell.imageView.image = UIImage(named : event.EventIcon as! String)
        
        return cell
    }

}
