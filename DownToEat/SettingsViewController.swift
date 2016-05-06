//
//  SettingsViewController.swift
//  DownToEat
//
//  Created by Adan Cortez on 3/25/16.
//  Copyright © 2016 GrabABite. All rights reserved.
//

import UIKit
import Foundation
import Firebase

class SettingsViewController: UIViewController
{
	var config = Config.sharedInstance

	override func viewDidLoad() {
		super.viewDidLoad()
		self.tabBarController?.tabBar.hidden = true
		
		self.title = "Settings"
		self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: config.themeFont, NSForegroundColorAttributeName: UIColor.whiteColor()]
		self.navigationController?.navigationBar.backgroundColor = config.themeColor
		
		// Create left and right button for navigation item
		let leftButton =  UIBarButtonItem(title: "Back", style:   UIBarButtonItemStyle.Plain, target: self, action: #selector(SettingsViewController.btn_clicked(_:)))
		let rightButton =  UIBarButtonItem(title: "", style:   UIBarButtonItemStyle.Plain, target: self, action: nil)

		// Create two buttons for the navigation item
		navigationItem.leftBarButtonItem = leftButton
		
		self.navigationItem.leftBarButtonItem?.setTitleTextAttributes( [ NSFontAttributeName: config.navigationBarItemFont, NSForegroundColorAttributeName: UIColor.whiteColor()], forState: UIControlState.Normal)
		self.navigationItem.rightBarButtonItem?.setTitleTextAttributes( [ NSFontAttributeName: config.navigationBarItemFont, NSForegroundColorAttributeName: UIColor.whiteColor()], forState: UIControlState.Normal)
		
		// Make the navigation bar a subview of the current view controller
		self.view.addSubview(config.createNavigationBar("Settings", createLeftBtn: true, leftBarBtn: leftButton, createRightBtn: false, rightBarBtn: rightButton))
		
		self.createLabels()
//		self.retreiveImagesFromFacebook()
		self.view.backgroundColor = config.themeColor
		// Do any additional setup after loading the view, typically from a nib.
	}
	
	override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func createLabels()
	{
		let profileSettings = config.settingsButton("Profile", xPosition: 25, yPosition: 380, border: false)
		let appSettings = config.settingsButton("App Settings", xPosition: 25, yPosition: 440, border: false)
		let supportSettings = config.settingsButton("Support", xPosition: 25, yPosition: 500, border: false)
		let feedBack = config.settingsButton("Feedback", xPosition: 25, yPosition: 560, border: false)

		profileSettings.addTarget(self, action: #selector(SettingsViewController.profile(_:)), forControlEvents: .TouchUpInside)
		appSettings.addTarget(self, action: #selector(SettingsViewController.applicationSettings(_:)), forControlEvents: .TouchUpInside)
		supportSettings.addTarget(self, action: #selector(SettingsViewController.support(_:)), forControlEvents: .TouchUpInside)
		feedBack.addTarget(self, action: #selector(SettingsViewController.feedback(_:)), forControlEvents: .TouchUpInside)

		self.view.addSubview(profileSettings)
		self.view.addSubview(appSettings)
		self.view.addSubview(supportSettings)
		self.view.addSubview(feedBack)
	}
	
//	func retreiveImagesFromFacebook()
//	{
//		let profilePicture = config.profilePhotoImg
//		profilePicture.backgroundColor = UIColor.whiteColor()
//		profilePicture.layer.borderColor = UIColor.whiteColor().CGColor
//		profilePicture.layer.cornerRadius = 100
//		profilePicture.layer.borderWidth = 3
//		profilePicture.clipsToBounds = true
//
//		let userNameLabel = UILabel(frame: CGRectMake(self.view.frame.size.width/2 - 100, 250, 200, 50))
//		userNameLabel.textAlignment = NSTextAlignment.Center
//		userNameLabel.text = config.userName
//		userNameLabel.font = config.largeTextFont
//		userNameLabel.textColor = config.themeColor
//		
//		let verticalBar = UIView(frame: CGRectMake(0, 65, self.view.frame.size.width, 300))
//		verticalBar.backgroundColor = UIColor.whiteColor()
//
//		verticalBar.addSubview(profilePicture)
//		verticalBar.addSubview(userNameLabel)
//		self.view.addSubview(verticalBar)
//	}
	
	func btn_clicked(sender: UIBarButtonItem) {
	// Do something
		let storyboard: UIStoryboard = UIStoryboard(name:"Main", bundle: NSBundle.mainBundle())
		let tabBarController: UITabBarController = storyboard.instantiateViewControllerWithIdentifier("DownToEatTabBarController") as! DownToEatTabBarController

		let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
		appDelegate.window!.rootViewController = tabBarController

//		let storyboard: UIStoryboard = UIStoryboard(name:"Main", bundle: NSBundle.mainBundle())
//		let backgroundViewController: UIViewController = storyboard.instantiateViewControllerWithIdentifier("BackgroundAnimationViewController") as! BackgroundAnimationViewController
//		
//		self.navigationController!.pushViewController(tabBarController, animated: true)
	}

	func profile(sender: AnyObject)
	{
		let storyboard: UIStoryboard = UIStoryboard(name:"Main", bundle: NSBundle.mainBundle())
		let profileViewController: UIViewController = storyboard.instantiateViewControllerWithIdentifier("ProfileViewController") as! ProfileViewController
		
		self.navigationController!.pushViewController(profileViewController, animated: true)
	}
	
	func applicationSettings(sender: AnyObject)
	{
		let storyboard: UIStoryboard = UIStoryboard(name:"Main", bundle: NSBundle.mainBundle())
		let facebookLogoutViewController: UIViewController = storyboard.instantiateViewControllerWithIdentifier("FacebookLogoutViewController") as! FacebookLogoutViewController
		
		self.navigationController!.pushViewController(facebookLogoutViewController, animated: true)
	}
	
	func support(sender: AnyObject)
	{
		print ("support")
		UIApplication.sharedApplication().openURL(NSURL(string:"http://www.google.com/")!)
	}
	
	func feedback(sender: AnyObject)
	{
		print ("feedback")

		
		let alert = UIAlertController(title: "Feedback", message: "Please, provide feedback below.", preferredStyle: UIAlertControllerStyle.Alert)
		alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
		alert.addAction(UIAlertAction(title: "Submit", style: UIAlertActionStyle.Default, handler: nil))
		alert.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
			textField.placeholder = "Enter feedback:"
			textField.secureTextEntry = false
		})
		self.presentViewController(alert, animated: true, completion: nil)
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
