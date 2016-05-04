//
//  DownToEatTabBarViewController.swift
//  DownToEat
//
//  Created by Adan Cortez on 3/22/16.
//  Copyright © 2016 GrabABite. All rights reserved.
//

import UIKit

class DownToEatTabBarViewController: UITabBarController {

	var config = Config.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
		
        // Do any additional setup after loading the view.
		tabBar.tintColor = UIColor.lightGrayColor()
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
