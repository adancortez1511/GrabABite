//
//  ProfileViewController.swift
//  DownToEat
//
//  Created by Adan Cortez on 3/25/16.
//  Copyright © 2016 GrabABite. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

	var config = Config.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.tabBarController?.tabBar.hidden = true
		
		self.title = "Profile"
		self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: config.themeFont, NSForegroundColorAttributeName: UIColor.whiteColor()]
		self.navigationController?.navigationBar.backgroundColor = config.themeColor
		
		// Create left and right button for navigation item
		let leftButton =  UIBarButtonItem(title: "Back", style:   UIBarButtonItemStyle.Plain, target: self, action: #selector(ProfileViewController.btn_clicked(_:)))
		let rightButton =  UIBarButtonItem(title: "", style:   UIBarButtonItemStyle.Plain, target: self, action: nil)
		
		// Create two buttons for the navigation item
		navigationItem.leftBarButtonItem = leftButton
		
		self.navigationItem.leftBarButtonItem?.setTitleTextAttributes( [ NSFontAttributeName: config.navigationBarItemFont, NSForegroundColorAttributeName: UIColor.whiteColor()], forState: UIControlState.Normal)
		self.navigationItem.rightBarButtonItem?.setTitleTextAttributes( [ NSFontAttributeName: config.navigationBarItemFont, NSForegroundColorAttributeName: UIColor.whiteColor()], forState: UIControlState.Normal)
		
		// Make the navigation bar a subview of the current view controller
		self.view.addSubview(config.createNavigationBar("Profile", createLeftBtn: true, leftBarBtn: leftButton, createRightBtn: false, rightBarBtn: rightButton))
	
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func btn_clicked(sender: UIBarButtonItem) {
		// Do something
		let storyboard: UIStoryboard = UIStoryboard(name:"Main", bundle: NSBundle.mainBundle())
		let settingsViewController: UIViewController = storyboard.instantiateViewControllerWithIdentifier("SettingsViewController") as! SettingsViewController

		self.navigationController!.pushViewController(settingsViewController, animated: true)
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
