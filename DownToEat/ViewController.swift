//
//  ViewController.swift
//  DownToEat
//
//  Created by Adan Cortez on 2/16/16.
//  Copyright © 2016 GrabABite. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
//	@IBOutlet weak var loginView:FBSDKLoginButton? = FBSDKLoginButton()
	@IBOutlet weak var kolodaView: KolodaView!
	var config = Config.sharedInstance

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: config.themeFont, NSForegroundColorAttributeName: UIColor.whiteColor()]
		self.navigationController?.navigationBar.backgroundColor = config.themeColor
		
		self.navigationItem.leftBarButtonItem?.setTitleTextAttributes( [ NSFontAttributeName: config.navigationBarItemFont, NSForegroundColorAttributeName: UIColor.whiteColor()], forState: UIControlState.Normal)
		self.navigationItem.rightBarButtonItem?.setTitleTextAttributes( [ NSFontAttributeName: config.navigationBarItemFont, NSForegroundColorAttributeName: UIColor.whiteColor()], forState: UIControlState.Normal)
		
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
		

	//MARK: IBActions
	@IBAction func leftButtonTouched()
	{
		kolodaView?.swipe(SwipeResultDirection.Left)
	}
	
	@IBAction func rightButtonTouched() {
		kolodaView?.swipe(SwipeResultDirection.Right)
	}
	
	@IBAction func undoButtonTouched() {
		kolodaView?.revertAction()
	}
}