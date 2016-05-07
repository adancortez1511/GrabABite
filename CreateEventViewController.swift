//
//  CreateEventViewController.swift
//  DownToEat
//
//  Created by Thuy Nguyen on 5/4/16.
//  Copyright © 2016 GrabABite. All rights reserved.
//

import UIKit

private let frameAnimationSpringBounciness:CGFloat = 9
private let frameAnimationSpringSpeed:CGFloat = 16
private let kolodaCountOfVisibleCards = 2
private let kolodaAlphaValueSemiTransparent:CGFloat = 0.1

class CreateEventViewController: UIViewController
{

	@IBOutlet weak var restaurantImageView: UIImageView!
	@IBOutlet weak var categoriesLabel: UILabel!
	@IBOutlet weak var phoneLabel: UILabel!
	@IBOutlet weak var addressLabel: UILabel!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var createEvent: UIButton!
	
	var business : Business?
	var config = Config.sharedInstance
	var backgroundAnimationViewController : BackgroundAnimationViewController?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		nameLabel.text = business!.name
		restaurantImageView.setImageWithURL(business!.imageURL!)
		categoriesLabel.text = business!.categories
		addressLabel.text = business!.address
		phoneLabel.text = business!.phone
		
		restaurantImageView.layer.cornerRadius = 10
		createEvent.layer.cornerRadius = 10
		self.navigationController?.navigationItem.leftBarButtonItem?.title = "Back"
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	//back button
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		navigationItem.title = "Back"
	}

	@IBAction func createNewEvent(sender: AnyObject) {
		config.eventDictonary.updateValue(self.restaurantImageView, forKey: config.eventsAttending)
		config.eventsAttending += 1
		for (airportCode, airportName) in config.eventDictonary {
			print("asdf \(airportCode): \(airportName)")
		}
		NSNotificationCenter.defaultCenter().postNotificationName("update", object: nil)
		NSNotificationCenter.defaultCenter().postNotificationName("new", object: nil)
	}
	
	func getBusiness() -> Business
	{
		return business!
	}
}