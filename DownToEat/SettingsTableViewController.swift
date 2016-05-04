//
//  SettingsTableViewController.swift
//  DownToEat
//
//  Created by Adan Cortez on 3/26/16.
//  Copyright © 2016 GrabABite. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
	var TableArray = [String]()
	var config = Config.sharedInstance
	
	override func viewDidLoad() {
		TableArray = ["BackgroundAnimationViewController","Second","World"]
		
		tableView.backgroundColor = config.themeColor
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return TableArray.count
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier(TableArray[indexPath.row], forIndexPath: indexPath) as UITableViewCell
		
		cell.textLabel?.text = TableArray[indexPath.row]
		cell.backgroundColor = config.themeColor

		cell.textLabel?.textColor = UIColor.whiteColor()
		return cell
	}
}
