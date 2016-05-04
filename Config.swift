//
//  Config.swift
//  DownToEat
//
//  Created by Adan Cortez on 4/20/16.
//  Copyright © 2016 Adan Cortez. All rights reserved.
//

import UIKit
import Firebase
import Foundation

// This is a Singleton
class Config
{
	static let sharedInstance = Config()

	private var _fireBase = Firebase(url: "https://grab-a-bite.firebaseio.com/")
	private var _themeColor: UIColor = UIColor(red: 236.0/255, green: 80.0/255, blue: 53.0/255, alpha: 1.0)
	private var _width: Double = 0.0
	private var _height: Double = 0.0
	private var _coverPhotoImg: UIImageView!
	private var _profilePhotoImg: UIImageView!

	var width: Double
	{
		get {return _width}
		set (newValue) {_width = newValue}
	}
	
	var height: Double
	{
		get {return _height}
		set (newValue) {_height = newValue}
	}
	
	var themeColor: UIColor
	{
		get {return _themeColor}
		set (newValue) {_themeColor = newValue}
	}
	
	var fireBase: Firebase
	{
		get {return _fireBase}
		set (newValue) {_fireBase = newValue}
	}
	
	func settingsButton (title: NSString, xPosition: Double, yPosition: Double, border: Bool) -> UIButton
	{
		let newButton = UIButton()
		
		newButton.setTitle((title as String), forState: .Normal)
		newButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
		newButton.titleLabel!.font = UIFont(name: "Avenir-Black", size: 24)
		newButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
		newButton.contentHorizontalAlignment = .Left
		newButton.titleLabel!.numberOfLines = 1
		newButton.frame = CGRectMake(CGFloat(xPosition), CGFloat(yPosition), CGFloat(_width), CGFloat(_height))

		if (border)
		{
			newButton.layer.borderWidth = 2.0
			newButton.layer.borderColor = UIColor.blackColor().CGColor
		}
		return newButton
	}
		
	func profile(sender: AnyObject)
	{
		let storyboard: UIStoryboard = UIStoryboard(name:"Main", bundle: NSBundle.mainBundle())
		let profileViewController: UIViewController = storyboard.instantiateViewControllerWithIdentifier("ProfileViewController") as! ProfileViewController
		
		let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
		appDelegate.window!.rootViewController = profileViewController
	}
	
	func applicationSettings(sender: AnyObject)
	{
		let storyboard: UIStoryboard = UIStoryboard(name:"Main", bundle: NSBundle.mainBundle())
		let loginViewController: UIViewController = storyboard.instantiateViewControllerWithIdentifier("FacebookLogoutViewController") as! FacebookLogoutViewController
		
		let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
		appDelegate.window!.rootViewController = loginViewController
	}
	
	func support(sender: AnyObject)
	{
		print ("support")
		UIApplication.sharedApplication().openURL(NSURL(string:"http://www.google.com/")!)
	}
	
	func feedback(sender: AnyObject)
	{
		print ("feedback")
		
		
		//		let alert = UIAlertController(title: "Feedback", message: "Please, provide feedback below.", preferredStyle: UIAlertControllerStyle.Alert)
		//		alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
		//		alert.addAction(UIAlertAction(title: "Submit", style: UIAlertActionStyle.Default, handler: nil))
		//		alert.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
		//			textField.placeholder = "Enter text:"
		//			textField.secureTextEntry = false
		//		})
		//		self.presentViewController(alert, animated: true, completion: nil)
	}
	
	init(width: Double, height: Double) {
		self.width = width
		self.height = height
	}
	
	convenience init() {
		self.init(width: 225.0,
		          height: 50.0
			
		)
	}

}