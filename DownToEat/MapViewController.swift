//
//  MapViewController.swift
//  Map
//
//  Created by Thuy Nguyen on 03/31/16.
//  Copyright © 2016 GrabABite. All rights reserved.
//


import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    //CLLocation
    //create a location manager to access location related stuff later
    var manager: CLLocationManager!
	var config = Config.sharedInstance
	
    //the map
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var userAddressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigation bar
		self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: config.themeFont, NSForegroundColorAttributeName: UIColor.whiteColor()]
		self.navigationController?.navigationBar.backgroundColor = config.themeColor
		
        //navigation bar
		self.navigationItem.leftBarButtonItem?.setTitleTextAttributes( [ NSFontAttributeName: config.navigationBarItemFont, NSForegroundColorAttributeName: UIColor.whiteColor()], forState: UIControlState.Normal)
		self.navigationItem.rightBarButtonItem?.setTitleTextAttributes( [ NSFontAttributeName: config.navigationBarItemFont, NSForegroundColorAttributeName: UIColor.whiteColor()], forState: UIControlState.Normal)
		
		//get user's current location
        manager = CLLocationManager()
        manager.delegate = self
        //to use GPS location
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        //start monitoring location
        manager.startUpdatingLocation()
    
    }
    
    //call this function every time a new location is identified by the phone (update)
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //print(locations)
        
        //extract latitude and longitude from location manager
        let userLocation: CLLocation = locations[0]
        let latitude = userLocation.coordinate.latitude
        let longitude = userLocation.coordinate.longitude

        config.userLocation = locations[0]
        config.userLocationLat = userLocation.coordinate.latitude
        config.userLocationLong = userLocation.coordinate.longitude

        //zoom in map
        let latDelta:CLLocationDegrees = 0.05
        let lonDelta:CLLocationDegrees = 0.05
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        //update map based on user's location
        self.map.setRegion(region, animated: false)
        
        //reverse geo to get address from longitude and latitude coordinates
        CLGeocoder().reverseGeocodeLocation(userLocation, completionHandler: { (placemarks, error) -> Void in
            
            if (error != nil) {
                print(error)
            } else {
                //test to convert 1st element in placemark
                //use p to extract our info
                if let pt = placemarks?.first {
                    //print (pt)
                    
                    //get the user's address
                    let subThoroughfare = pt.subThoroughfare ?? ""
                    let thoroughfare = pt.thoroughfare ?? ""
                    let administrativeArea = pt.administrativeArea ?? ""
                    let locality = pt.locality ?? ""
                    let postalCode = pt.postalCode ?? ""
                    let country = pt.country ?? ""
                    
                    //print user's current address
                    self.userAddressLabel.text = "\(subThoroughfare) \(thoroughfare) \(locality) \(administrativeArea) \(postalCode) \(country)"
					
                    //indicate user's current location (blue dot)
                    self.map.showsUserLocation = true
                }
            }
            
        })
    }
    
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		// Initialize Tab Bar Item
		tabBarItem = UITabBarItem(title: "Restaurants", image: UIImage(named: "restaurant_orange"), tag: 1)
		tabBarItem.setTitleTextAttributes([ NSFontAttributeName: config.smallTextFont, NSForegroundColorAttributeName: UIColor.whiteColor()], forState: .Normal)
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
	}
}