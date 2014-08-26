//
//  FeatureListViewController.swift
//  FaceGestureSample
//
//  Created by Saurav Nagpal on 25/08/14.
//  Copyright (c) 2014 Saurav Nagpal. All rights reserved.
//

import UIKit

class FeatureListViewController: UIViewController {

    var appFeatures:NSArray!
    /*******************************
    *   View Controller Life Cycle
    ********************************/
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.appFeatures = Utility.listFromPlistFileLocal(fileName: FaceDetectionConstant.appFeatureFile)
    }
    
    override func viewDidLoad(){
       super.viewDidLoad()
    }
    
    /*******************************
    *   UITable View Datasource
    ********************************/
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int{
        return 1;
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int{
        return self.appFeatures.count;
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!{
        
        var cell : UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(FaceDetectionConstant.featureCell) as UITableViewCell!
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: FaceDetectionConstant.featureCell)
        }
        
        cell!.textLabel.text = self.appFeatures.objectAtIndex(indexPath.row) as String
        return cell;
    }
    /*******************************
    *   UITable View Delegate
    ********************************/
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!){
        var storyboard = UIStoryboard(name: FaceDetectionConstant.storyBoardName, bundle: nil)
        if(indexPath.row == 0){
            var featureViewController = storyboard.instantiateViewControllerWithIdentifier(FaceDetectionConstant.galleryViewIdentifier) as UIViewController
            self.navigationController.pushViewController(featureViewController , animated: true)
        }
    }
}
