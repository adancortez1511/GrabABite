//
//  BussinessCell.swift
//  DownToEat
//
//  Created by Thuy Nguyen on 4/23/16.
//  Copyright © 2016 GrabABite. All rights reserved.
//

import UIKit

class BusinessCell: UITableViewCell {
    
    //labels for business cell within search table view
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingsImageView: UIImageView!
    @IBOutlet weak var ratingsCountLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!

	var config = Config.sharedInstance
	
    var business: Business! {
        didSet {
            nameLabel.text = business.name
            restaurantImageView.setImageWithURL(business.imageURL!)
            categoriesLabel.text = business.categories
            addressLabel.text = business.address
            ratingsCountLabel.text = "\(business.reviewCount!) Reviews"
            ratingsImageView.setImageWithURL(business.ratingImageURL!)
            distanceLabel.text = business.distance
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //Create rounded corners for thumbImage
        restaurantImageView.layer.cornerRadius = 5
        restaurantImageView.clipsToBounds = true
        //Wraps based on the preferred layout width, need to sync with the actual size of label
        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
    }
    //During rotation, run function again to maintain consistency throughout
    override func layoutSubviews() {
        //Repeat parent function inside super.
        super.layoutSubviews()
        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}