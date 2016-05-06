//
//  MessengerViewController.swift
//  DownToEat
//
//  Created by Thuy Nguyen on 5/4/16.
//  Copyright © 2016 GrabABite. All rights reserved.
//

import UIKit

class MessengerViewController: UIViewController {
    
    var config = Config.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        // Create left and right button for navigation item
//        let leftButton =  UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(MessengerViewController.edit_btn_clicked(_:)))
//        
//        navigationItem.leftBarButtonItem = leftButton
//        navigationItem.leftBarButtonItem?.setTitleTextAttributes( [ NSFontAttributeName: config.navigationBarItemFont, NSForegroundColorAttributeName: UIColor.whiteColor()], forState: UIControlState.Normal)
//        
//        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: config.themeFont, NSForegroundColorAttributeName: UIColor.whiteColor()]
//        self.navigationController?.navigationBar.backgroundColor = config.themeColor
        
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    // Initialize Tab Bar Item
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tabBarItem = UITabBarItem(title: "Messenger", image: UIImage(named: "chat_orange"), tag: 1)
        tabBarItem.setTitleTextAttributes([ NSFontAttributeName: config.smallTextFont, NSForegroundColorAttributeName: UIColor.whiteColor()], forState: .Normal)
        
    }
    
//    //edit button
//    func edit_btn_clicked(sender: UIBarButtonItem) {
//        // Do something
//        let storyboard: UIStoryboard = UIStoryboard(name:"Main", bundle: NSBundle.mainBundle())
//        let messengerViewController: UIViewController = storyboard.instantiateViewControllerWithIdentifier("MessengerViewController") as! MessengerViewController
//        
//        self.showViewController(messengerViewController, sender: messengerViewController)
//    }

}