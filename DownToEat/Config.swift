//
//  Config.swift
//  DownToEat
//
//  Created by Adan Cortez on 4/20/16.
//  Copyright © 2016 GrabABite. All rights reserved.
//

import UIKit
import Firebase
import Foundation
import CoreLocation
import MapKit

// This is a Singleton
class Config
{
	static let sharedInstance = Config()

	//private var _fireBase = Firebase(url: "https://grab-a-bite.firebaseio.com/")
	private var _themeColor: UIColor = UIColor(red: 236.0/255, green: 80.0/255, blue: 53.0/255, alpha: 1.0)
	private var _themeFont: UIFont = UIFont(name: "Avenir-Black", size: 28.0)!
	private var _buttonFont: UIFont = UIFont(name: "Avenir-Black", size: 24.0)!
	private var _navigationBarItemFont: UIFont = UIFont(name: "Avenir-Black", size: 18.0)!
	private var _largeTextFont: UIFont = UIFont(name: "Avenir-Black", size: 16.0)!
	private var _mediumTextFont: UIFont = UIFont(name: "Avenir-Black", size: 14.0)!
	private var _smallTextFont: UIFont = UIFont(name: "Avenir-Black", size: 12.0)!
	private var _tinyTextFont: UIFont = UIFont(name: "Avenir-Black", size: 10.0)!
	private var _fontName: String = "Avenir-Black"
	private var _width: CGFloat = 0.0
	private var _widthOfDevice: CGFloat = 0.0
	private var _height: CGFloat = 0.0
	private var _heightOfDevice: CGFloat = 0.0
//	private var _profilePhotoImg: UIImageView!
//	private var _userName: String = ""
	private var _eventsAttending: Int = 0
	private var _navigationBarCreate: UINavigationBar!
	private var _eventDictionary: Dictionary<Int, UIImageView>! = Dictionary()
    private var _userLocation: CLLocation! 
    private var _userLocationLat: CLLocationDegrees!
    private var _userLocationLong: CLLocationDegrees!
//	private var _eventDictionary: [Int: UIImageView] = [:]
	private var _testImg: UIImageView!
	
	var width: CGFloat
	{
		get {return _width}
		set (newValue) {_width = newValue}
	}
	
	var height: CGFloat
	{
		get {return _height}
		set (newValue) {_height = newValue}
	}
	
	var widthOfDevice: CGFloat
	{
		get {return _widthOfDevice}
		set (newValue) {_widthOfDevice = newValue}
	}
	
	var heightOfDevice: CGFloat
	{
		get {return _heightOfDevice}
		set (newValue) {_heightOfDevice = newValue}
	}
	
	var eventsAttending: Int
	{
		get {return _eventsAttending}
		set (newValue) {_eventsAttending = newValue}
	}
	
	var themeColor: UIColor
	{
		get {return _themeColor}
		set (newValue) {_themeColor = newValue}
	}

	var themeFont: UIFont
	{
		get {return _themeFont}
		set (newValue) {_themeFont = newValue}
	}
	
	var tinyTextFont: UIFont
	{
		get {return _tinyTextFont}
		set (newValue) {_tinyTextFont = newValue}
	}

	var smallTextFont: UIFont
		{
		get {return _smallTextFont}
		set (newValue) {_smallTextFont = newValue}
	}
	
	var mediumTextFont: UIFont
		{
		get {return _mediumTextFont}
		set (newValue) {_mediumTextFont = newValue}
	}
	
	var largeTextFont: UIFont
	{
		get {return _largeTextFont}
		set (newValue) {_largeTextFont = newValue}
	}
	
	var buttonFont: UIFont
	{
		get {return _buttonFont}
		set (newValue) {_buttonFont = newValue}
	}
	
	var navigationBarItemFont: UIFont
	{
		get {return _navigationBarItemFont}
		set (newValue) {_navigationBarItemFont = newValue}
	}

	var fontName: String
	{
		get {return _fontName}
		set (newValue) {_fontName = newValue}
	}
	
//	var profilePhotoImg: UIImageView
//	{
//		get {return _profilePhotoImg}
//		set (newValue) {_profilePhotoImg = newValue}
//	}
	
//	var userName: String
//	{
//		get {return _userName}
//		set (newValue) {_userName = newValue}
//	}
	
//	var fireBase: Firebase
//	{
//		get {return _fireBase}
//		set (newValue) {_fireBase = newValue}
//	}

	var navigationBarCreate: UINavigationBar
	{
		get {return _navigationBarCreate}
		set (newValue) {_navigationBarCreate = newValue}
	}

	subscript (i: Int) -> UIImageView?
	{
		get {
			return _eventDictionary[i]
		}
		set {
			_eventDictionary[i] = newValue
		}
	}
	
	var eventDictonary: Dictionary<Int, UIImageView>
	{
		get {return _eventDictionary}
		set (newValue) {_eventDictionary = newValue}
	}
	
	var testImg: UIImageView
	{
		get {return _testImg}
		set (newValue) {_testImg = newValue}
	}
    
    var userLocation: CLLocation
    {
        get {return _userLocation}
        set (newValue) {_userLocation = newValue}
    }

    var userLocationLat: CLLocationDegrees
    {
        get {return _userLocationLat}
        set (newValue) {_userLocationLat = newValue}
    }
    
    var userLocationLong: CLLocationDegrees
    {
        get {return _userLocationLong}
        set (newValue) {_userLocationLong = newValue}
    }
	
	func settingsButton (title: String, xPosition: Double, yPosition: Double, border: Bool) -> UIButton
	{
		let newButton = UIButton()
		
		newButton.setTitle((title as String), forState: .Normal)
		newButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
		newButton.titleLabel!.font = _buttonFont
		newButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
		newButton.contentHorizontalAlignment = .Left
		newButton.titleLabel!.numberOfLines = 1
		newButton.frame = CGRectMake(CGFloat(xPosition), CGFloat(yPosition), CGFloat(_width), CGFloat(_height))

		if (border)
		{
			newButton.layer.borderWidth = 2.0
			newButton.layer.borderColor = UIColor.blackColor().CGColor
		}
		return newButton
	}
	
	func createNavigationBar (titleMenu: String, createLeftBtn: Bool, leftBarBtn: UIBarButtonItem, createRightBtn: Bool, rightBarBtn: UIBarButtonItem) -> UINavigationBar
	{
		let navigationBar = UINavigationBar(frame: CGRectMake(0, 0, _widthOfDevice, 65)) // Offset by 20 pixels vertically to take the status bar into account
		
		navigationBar.titleTextAttributes = [ NSFontAttributeName: themeFont, NSForegroundColorAttributeName: UIColor.whiteColor()]
		navigationBar.backgroundColor = _themeColor
		navigationBar.translucent = true
		navigationBar.opaque = true
		
		// Create a navigation item with a title
		let navigationItem = UINavigationItem()
		navigationItem.title = titleMenu
		
		// Create left and right button for navigation item
		if (createLeftBtn)
		{
			// Create two buttons for the navigation item
			navigationItem.leftBarButtonItem = leftBarBtn
			navigationItem.leftBarButtonItem?.setTitleTextAttributes( [ NSFontAttributeName: _navigationBarItemFont, NSForegroundColorAttributeName: UIColor.whiteColor()], forState: UIControlState.Normal)
		}
		
		if (createRightBtn)
		{
			// Create two buttons for the navigation item
			navigationItem.rightBarButtonItem = rightBarBtn
			navigationItem.rightBarButtonItem?.setTitleTextAttributes( [ NSFontAttributeName: _navigationBarItemFont, NSForegroundColorAttributeName: UIColor.whiteColor()], forState: UIControlState.Normal)
		}
		
		// Assign the navigation item to the navigation bar
		navigationBar.items = [navigationItem]
		return navigationBar
	}
	
	init(width: CGFloat, height: CGFloat, widthOfDevice: CGFloat, heightOfDevice: CGFloat) {
		self.width = width
		self.height = height
		self.widthOfDevice = widthOfDevice
		self.heightOfDevice = heightOfDevice
	}
	
	convenience init() {
		self.init(width: 250,
		          height: 50,
		          widthOfDevice: 0,
		          heightOfDevice: 0
			
		)
	}

}