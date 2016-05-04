//
//  CalendarViewController.swift
//  DownToEat
//
//  Created by Adan Cortez on 3/31/16.
//  Copyright © 2016 Adan Cortez. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		// Initialize Tab Bar Item
		tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home_orange"), tag: 1)
	}
}
