//
//  YelpClient.swift
//  DownToEat
//
//  Created by Thuy Nguyen on 4/23/16.
//  Copyright © 2016 GrabABite. All rights reserved.
//
// Credit to Timothy Lee for the basic YelpClient template setup

import UIKit
import AFNetworking
import BDBOAuth1Manager

// You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
// Account: GrabABiteInc
let yelpConsumerKey = "R1EvyljH2dbJQVVw8px8Aw"
let yelpConsumerSecret = "9qzfGPEoHpjgqU7OxcrF1XAoE50"
let yelpToken = "i4XF3ROs6bKvyZ4kWVFJY4HmyB2dVuzy"
let yelpTokenSecret = "6SGbE9bfF7PUaVvUg_1-INgMvYE"

enum YelpSortMode: Int {
    case BestMatched = 0, Distance, HighestRated
}

class YelpClient: BDBOAuth1RequestOperationManager {
    var accessToken: String!
    var accessSecret: String!
	var config = Config.sharedInstance
	
    class var sharedInstance : YelpClient {
        struct Static {
            static var token : dispatch_once_t = 0
            static var instance : YelpClient? = nil
        }
        
        dispatch_once(&Static.token) {
            Static.instance = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        }
        return Static.instance!
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(consumerKey key: String!, consumerSecret secret: String!, accessToken: String!, accessSecret: String!) {
        self.accessToken = accessToken
        self.accessSecret = accessSecret
        let baseUrl = NSURL(string: "https://api.yelp.com/v2/")
        super.init(baseURL: baseUrl, consumerKey: key, consumerSecret: secret);
        
        let token = BDBOAuth1Credential(token: accessToken, secret: accessSecret, expiration: nil)
        self.requestSerializer.saveAccessToken(token)
    }
    
    func searchWithTerm(term: String, completion: ([Business]!, NSError!) -> Void) -> AFHTTPRequestOperation {
        return searchWithTerm(term, sort: nil, categories: nil, deals: nil, offset: nil, completion: completion)
    }
    
    func searchWithTerm(term: String, sort: YelpSortMode?, categories: [String]?, deals: Bool?, offset: Int?,completion: ([Business]!, NSError!) -> Void) -> AFHTTPRequestOperation {
        // For additional parameters, see http://www.yelp.com/developers/documentation/v2/search_api
        
        // Default the location to San Francisco
        //var parameters: [String : AnyObject] = ["term": term, "ll": "37.785771,-122.406165"]
        
        //Location set to Thuy's address. zipcode 78751
        
        let latitude = config.userLocation.coordinate.latitude
        let longitude = config.userLocation.coordinate.longitude
        let locationOfUser = String(latitude) + "," + String(longitude)

        var parameters: [String : AnyObject] = ["term": term, "ll": locationOfUser]
        
        if sort != nil {
            parameters["sort"] = sort!.rawValue
        }
        
        if categories != nil && categories!.count > 0 {
            parameters["category_filter"] = (categories!).joinWithSeparator(",")
        }
        
        if deals != nil {
            parameters["deals_filter"] = deals!
        }
        //Add offset parameters for infinite scroll
        if offset != nil && offset > 0 {
            parameters["offset"] = offset!
        }
		
        return self.GET("search", parameters: parameters, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            let dictionaries = response["businesses"] as? [NSDictionary]
            if dictionaries != nil {
                completion(Business.businesses(array: dictionaries!), nil)
            }
            }, failure: { (operation: AFHTTPRequestOperation?, error: NSError!) -> Void in
                completion(nil, error)
        })!
    }
}

