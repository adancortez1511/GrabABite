////
////  ChatTableViewController.swift
////  DownToEat
////
////  Created by Thuy Nguyen on 4/8/16.
////  Copyright © 2016 GrabABite. All rights reserved.
////
//
//import UIKit
//import Firebase
//
//class ChatTableViewController: UITableViewController {
//	
//	var config = Config.sharedInstance
//	
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // Tab Bar
//        self.title = "Messenger"
//        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: config.themeFont, NSForegroundColorAttributeName: UIColor.whiteColor()]
//        self.navigationController?.navigationBar.backgroundColor = config.themeColor
//        
//        self.navigationItem.leftBarButtonItem?.setTitleTextAttributes( [ NSFontAttributeName: config.navigationBarItemFont, NSForegroundColorAttributeName: UIColor.whiteColor()], forState: UIControlState.Normal)
//        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes( [ NSFontAttributeName: config.navigationBarItemFont, NSForegroundColorAttributeName: UIColor.whiteColor()], forState: UIControlState.Normal)
//        
//    }
//    
//    override func viewDidAppear(animated: Bool) {
//        super.viewDidAppear(animated)
//    }
//    
//    override func viewDidDisappear(animated: Bool) {
//        super.viewDidDisappear(animated)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        
//        // Initialize Tab Bar Item
//        tabBarItem = UITabBarItem(title: "Messenger", image: UIImage(named: "chat_orange"), tag: 1)
//        tabBarItem.setTitleTextAttributes([ NSFontAttributeName: config.smallTextFont, NSForegroundColorAttributeName: UIColor.whiteColor()], forState: .Normal)
//    }
//	
//	func edit_btn_clicked(sender: UIBarButtonItem)
//	{
//		tableView.editing = !tableView.editing
//		if tableView.editing{
//			tableView.setEditing(true, animated: true)
//		} else{
//			tableView.setEditing(false, animated: true)
//		}
//	}
//}