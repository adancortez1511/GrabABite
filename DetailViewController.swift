//
//  DetailViewController.swift
//  DownToEat
//
//  Created by Thuy Nguyen on 4/23/16.
//  Copyright © 2016 GrabABite. All rights reserved.
//


import UIKit

class DetailViewController: UIViewController {
    
    //labels for business info when user click on the search cell
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var ratingsImageView: UIImageView!
    @IBOutlet weak var ratingsCountLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var snippetLabel: UILabel!
    @IBOutlet weak var createEvent: UIButton!
    @IBOutlet weak var getDirections: UIButton!
    
    var business : Business?
	var config = Config.sharedInstance
 
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = business!.name
        restaurantImageView.setImageWithURL(business!.imageURL!)
        categoriesLabel.text = business!.categories
        ratingsImageView.setImageWithURL(business!.ratingImageURL!)
        addressLabel.text = business!.address
        ratingsCountLabel.text = "\(business!.reviewCount!) Reviews"
        phoneLabel.text = business!.phone
        distanceLabel.text = business!.distance
        snippetLabel.text = "\(business!.snippet)"
        
        restaurantImageView.layer.cornerRadius = 10
        createEvent.layer.cornerRadius = 10
        getDirections.layer.cornerRadius = 10
        
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
    
    @IBAction func getDirectionsToRestaurant(sender: AnyObject) {
    
    }
    

}
