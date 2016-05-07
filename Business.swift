//
//  Bussiness.swift
//  DownToEat
//
//  Created by Thuy Nguyen on 4/23/16.
//  Copyright © 2016 GrabABite. All rights reserved.
//
// Credit to Timothy Lee for the basic Bussiness template setup

import UIKit

class Business: NSObject {
    var name: String! = ""
    var address: String! = ""
    let imageURL: NSURL?
    var categories: String! = ""
    let offset: NSNumber?
    var distance: String! = ""
    let ratingImageURL: NSURL?
    let reviewCount: NSNumber?
    //add snippet text for detail view
    var snippet: String! = ""
    //Phone Number
    var phone: String! = ""
	
	var config = Config.sharedInstance

    init(dictionary: NSDictionary) {
        name = dictionary["name"] as? String
        phone = dictionary["display_phone"] as? String
        snippet = dictionary["snippet_text"] as? String
        
        let imageURLString = dictionary["image_url"] as? String
        if imageURLString != nil {
            imageURL = NSURL(string: imageURLString!)!
        } else {
            imageURL = nil
        }        
        
        let location = dictionary["location"] as? NSDictionary
        var address = ""
        if location != nil {
            let addressArray = location!["address"] as? NSArray
            if addressArray != nil && addressArray!.count > 0 {
                address = addressArray![0] as! String
            }
            
            let neighborhoods = location!["neighborhoods"] as? NSArray
            if neighborhoods != nil && neighborhoods!.count > 0 {
                if !address.isEmpty {
                    address += ", "
                }
                address += neighborhoods![0] as! String
            }
        }
        self.address = address
        
        let categoriesArray = dictionary["categories"] as? [[String]]
        if categoriesArray != nil {
            var categoryNames = [String]()
            for category in categoriesArray! {
                let categoryName = category[0]
                categoryNames.append(categoryName)
            }
            categories = categoryNames.joinWithSeparator(", ")
        } else {
            categories = nil
        }
        
        let distanceMeters = dictionary["distance"] as? NSNumber
        if distanceMeters != nil {
            let milesPerMeter = 0.000621371
            distance = String(format: "%.2f mi", milesPerMeter * distanceMeters!.doubleValue)
        } else {
            distance = nil
        }
        
        let ratingImageURLString = dictionary["rating_img_url_large"] as? String
        if ratingImageURLString != nil {
            ratingImageURL = NSURL(string: ratingImageURLString!)
        } else {
            ratingImageURL = nil
        }
        
        reviewCount = dictionary["review_count"] as? NSNumber
        
        //Create a value for the offset
        self.offset = 20
    }
    
    class func businesses(array array: [NSDictionary]) -> [Business] {
        var businesses = [Business]()
        for dictionary in array {
            let business = Business(dictionary: dictionary)
            businesses.append(business)
        }
        return businesses
    }
    
    
    class func searchWithTerm(term: String, completion: ([Business]!, NSError!) -> Void) {
        YelpClient.sharedInstance.searchWithTerm(term, completion: completion)
    }
    //include offset to be called into businessesViewController
    class func searchWithTerm(term: String, sort: YelpSortMode?, categories: [String]?, deals: Bool?, offset: Int?, completion: ([Business]!, NSError!) -> Void) -> Void {
        //Add offset to call in business type
        YelpClient.sharedInstance.searchWithTerm(term, sort: sort, categories: categories, deals: deals, offset: offset, completion: completion)
    }
}

