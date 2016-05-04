//
//  ScheduleViewController.swift
//  DownToEat
//
//  Created by Adan Cortez on 4/1/16.
//  Copyright © 2016 GrabABite. All rights reserved.
//

import UIKit

class ScheduleTableViewController: UITableViewController
{	
	var config = Config.sharedInstance

	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.tableView.dataSource = self
		self.tableView.delegate = self

		self.title = "Schedule"
		self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: config.themeFont, NSForegroundColorAttributeName: UIColor.whiteColor()]
		self.navigationController?.navigationBar.backgroundColor = config.themeColor

		let leftButton =  UIBarButtonItem(title: "Edit", style:   UIBarButtonItemStyle.Plain, target: self, action: #selector(ScheduleTableViewController.edit_btn_clicked(_:)))
		
		// Create two buttons for the navigation item
		navigationItem.leftBarButtonItem = leftButton
		
		self.navigationItem.leftBarButtonItem?.setTitleTextAttributes( [ NSFontAttributeName: config.navigationBarItemFont, NSForegroundColorAttributeName: UIColor.whiteColor()], forState: UIControlState.Normal)
		self.navigationItem.rightBarButtonItem?.setTitleTextAttributes( [ NSFontAttributeName: config.navigationBarItemFont, NSForegroundColorAttributeName: UIColor.whiteColor()], forState: UIControlState.Normal)
		NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ScheduleTableViewController.loadList(_:)),name:"load", object: nil)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	override func viewWillDisappear(animated: Bool) {
		tableView.setEditing(false, animated: true)
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		// Initialize Tab Bar Item
		tabBarItem = UITabBarItem(title: "Schedule", image: UIImage(named: "schedule_orange"), tag: 1)
		tabBarItem.setTitleTextAttributes([ NSFontAttributeName: config.smallTextFont, NSForegroundColorAttributeName: UIColor.whiteColor()], forState: .Normal)
	}
	
	func loadList(notification: NSNotification){
		//load data here
		tableView.reloadData()
	}
	
	func edit_btn_clicked(sender: UIBarButtonItem)
	{
		tableView.editing = !tableView.editing
		if tableView.editing{
			tableView.setEditing(true, animated: true)
		} else{
			tableView.setEditing(false, animated: true)
		}
	}
		
	override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: (NSIndexPath!)) -> CGFloat {
		return 100
	}
	
	// MARK: - Table view data source
	
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return config.eventsAttending
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		
		print ("coming in here")
		let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("scheduleCell", forIndexPath: indexPath)
		
		let profilePicture = config.testImg
		profilePicture.backgroundColor = UIColor.whiteColor()
		profilePicture.layer.borderColor = UIColor.whiteColor().CGColor
		profilePicture.layer.cornerRadius = 34
		profilePicture.contentMode = .ScaleAspectFill
		profilePicture.layer.masksToBounds = true
		
		cell.addSubview(profilePicture)
		return cell
	}
	
	override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool
	{
		return true
	}

	override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
		
		if (editingStyle == UITableViewCellEditingStyle.Delete)
		{
			config.eventsAttending = config.eventsAttending - 1
			tableView.reloadData()
		}
	}
	
}