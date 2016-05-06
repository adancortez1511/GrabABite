//
//  FacebookLogoutViewController.swift
//  DownToEat
//
//  Created by Adan Cortez on 3/25/16.
//  Copyright © 2016 GrabABite. All rights reserved.
//

import UIKit

class FacebookLogoutViewController: UIViewController, FBSDKLoginButtonDelegate
{
	@IBOutlet weak var colorChange: UITextField!
	var config = Config.sharedInstance
	
	override func viewDidLoad()
	{
        super.viewDidLoad()
		
		self.colorChange.addTarget(self, action: #selector(FacebookLogoutViewController.colorDidChange(_:)), forControlEvents: UIControlEvents.EditingDidEnd)
		
//		self.view.backgroundColor = config.themeColor
//		
//		// Create left and right button for navigation item
//		let leftButton =  UIBarButtonItem(title: "Back", style:   UIBarButtonItemStyle.Plain, target: self, action: #selector(FacebookLogoutViewController.btn_clicked(_:)))
//		
//		let rightButton =  UIBarButtonItem(title: "", style:   UIBarButtonItemStyle.Plain, target: self, action: nil)
//		
//		// Make the navigation bar a subview of the current view controller
//		self.view.addSubview(config.createNavigationBar("App Settings", createLeftBtn: true, leftBarBtn: leftButton, createRightBtn: false, rightBarBtn: rightButton))
//		
//		// Do any additional setup after loading the view.
//		if (FBSDKAccessToken.currentAccessToken() != nil)
//		{
//			let loginView : FBSDKLoginButton = FBSDKLoginButton()
//			self.view.addSubview(loginView)
//			loginView.frame.size.height = 50.0
//			loginView.frame.size.width = 250.0
//			loginView.center.x = self.view.center.x
//			loginView.center.y = (self.view.frame.size.height - 100)
//			loginView.delegate = self
//			loginView.titleLabel!.font = config.navigationBarItemFont
//			print("user logged in")
//		}
//		else
//		{
//			self.loginButtonDidLogOut(nil)
//		}
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	override func viewWillAppear(animated: Bool) {
		self.view.backgroundColor = config.themeColor
		
		self.tabBarController?.tabBar.hidden = true
		
		self.title = "Profile"
		self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: config.themeFont, NSForegroundColorAttributeName: UIColor.whiteColor()]
		self.navigationController?.navigationBar.backgroundColor = config.themeColor
		
		// Create left and right button for navigation item
		let leftButton =  UIBarButtonItem(title: "Back", style:   UIBarButtonItemStyle.Plain, target: self, action: #selector(FacebookLogoutViewController.btn_clicked(_:)))
		let rightButton =  UIBarButtonItem(title: "", style:   UIBarButtonItemStyle.Plain, target: self, action: nil)
		
		// Create two buttons for the navigation item
		navigationItem.leftBarButtonItem = leftButton
        
		
		self.navigationItem.leftBarButtonItem?.setTitleTextAttributes( [ NSFontAttributeName: config.navigationBarItemFont, NSForegroundColorAttributeName: UIColor.whiteColor()], forState: UIControlState.Normal)
		self.navigationItem.rightBarButtonItem?.setTitleTextAttributes( [ NSFontAttributeName: config.navigationBarItemFont, NSForegroundColorAttributeName: UIColor.whiteColor()], forState: UIControlState.Normal)
		
		// Make the navigation bar a subview of the current view controller
		self.view.addSubview(config.createNavigationBar("App Settings", createLeftBtn: true, leftBarBtn: leftButton, createRightBtn: false, rightBarBtn: rightButton))
		
		// Do any additional setup after loading the view.
		if (FBSDKAccessToken.currentAccessToken() != nil)
		{
			let loginView : FBSDKLoginButton = FBSDKLoginButton()
			self.view.addSubview(loginView)
			loginView.frame.size.height = 50.0
			loginView.frame.size.width = 250.0
			loginView.center.x = self.view.center.x
			loginView.center.y = (self.view.frame.size.height - 100)
			loginView.delegate = self
			loginView.titleLabel!.font = config.navigationBarItemFont
			print("user logged in")
		}
		else
		{
			self.loginButtonDidLogOut(nil)
		}
		
		for (dataField, dataResult) in config.eventDictonary
		{
			print ("This is the dataField \(dataField) and this is the results \(dataResult)\n\n\n")
		}

	}
	
	func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!)
	{
		print("in loginButton")
		if ((error) != nil)
		{
			// Process error
		}
		else if result.isCancelled
		{
			// Handle cancellations
		}
		else
		{
			// If you ask for multiple permissions at once, you
			// should check if specific permissions missing
			if result.grantedPermissions.contains("email")
			{
				// Do work
				print ("email received")
				print("User Email is: \(result.valueForKey("email"))")
			}
			if result.grantedPermissions.contains("user_friends")
			{
				// Do work
				print ("user_friends received")
			}
			if result.grantedPermissions.contains("public_profile")
			{
				// Do work
				print ("public_profile received")
			}
			if result.grantedPermissions.contains("user_about_me")
			{
				// Do work
				print ("user_about_me received")
			}
			print("Inside the login")
		}
	}
	
	func colorDidChange(sender: AnyObject) {
		config.themeColor = UIColor.blueColor()
		config.themeFont = UIFont(name: "Times", size: 28.0)!
		config.buttonFont = UIFont(name: "Times", size: 24.0)!
		config.navigationBarItemFont = UIFont(name: "Times", size: 18.0)!
		config.largeTextFont = UIFont(name: "Times", size: 16.0)!
		config.mediumTextFont = UIFont(name: "Times", size: 14.0)!
		config.smallTextFont = UIFont(name: "Times", size: 12.0)!
		config.tinyTextFont = UIFont(name: "Times", size: 10.0)!
		config.fontName = "Times"
		
		self.view.setNeedsDisplay()
		self.view.updateFocusIfNeeded()
	}
	
	func loginButtonDidLogOut(loginButton: FBSDKLoginButton!)
	{
		print ("somthing in here")
		let storyboard: UIStoryboard = UIStoryboard(name:"Main", bundle: NSBundle.mainBundle())
		let loginViewController: UIViewController = storyboard.instantiateViewControllerWithIdentifier("FacebookLoginViewController") as! FacebookLoginViewController
		
		let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
		appDelegate.window!.rootViewController = loginViewController
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
