//
//  DownToEatTabBarController.swift
//  DownToEat
//
//  Created by Adan Cortez on 3/24/16.
//  Copyright © 2016 GrabABite. All rights reserved.
//

import UIKit
import Firebase

class DownToEatTabBarController: UITabBarController {
	var config = Config.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
		UINavigationBar.appearance().backgroundColor = config.themeColor
		UIBarButtonItem.appearance().tintColor = config.themeColor
		UITabBar.appearance().backgroundColor = config.themeColor

		// Sets the default color of the icon of the selected UITabBarItem and Title
		UITabBar.appearance().tintColor = UIColor.whiteColor()
		
		// Sets the default color of the background of the UITabBar
		UITabBar.appearance().barTintColor = config.themeColor
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
