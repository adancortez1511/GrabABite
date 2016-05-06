

//
//  FacebookLoginViewController.swift
//  DownToEat
//
//  Created by Adan Cortez on 3/22/16.
//  Copyright © 2016 GrabABite. All rights reserved.
//

import UIKit
import Firebase

//class FacebookLoginViewController: UIViewController, FBSDKLoginButtonDelegate {
class FacebookLoginViewController: UIViewController {
    
    /*****************************************************
     {IMPORTANT}:
     - Use FirebaseDataBase.swift for all database references 
     - All "saving of local data" to firebase happens should happen there
     ****************************************************/
    
    private var userID: NSString!
    private var userName: NSString!
    private var userEmail: NSString!
    
    var config = Config.sharedInstance
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        config.widthOfDevice = self.view.frame.size.width
        config.heightOfDevice = self.view.frame.size.width
        
        print ("currentAccessToken: \(FBSDKAccessToken.currentAccessToken())")
        // Do any additional setup after loading the view.
        if (FBSDKAccessToken.currentAccessToken() != nil)
        {
            // User is already logged in, do work such as go to next view controller.
            // Or Show Logout Button
            let loginView : FBSDKLoginButton = FBSDKLoginButton()
            self.view.addSubview(loginView)
            loginView.frame.size.height = 50.0
            loginView.frame.size.width = 250.0
            loginView.center.x = self.view.center.x
            loginView.center.y = (self.view.frame.size.height - 100)
            loginView.readPermissions = ["public_profile", "email", "user_friends", "user_about_me"]
            loginView.titleLabel!.font = UIFont(name: "", size: 20)
            print ("Case: 1")
        }
        else
        {
            let loginView : FBSDKLoginButton = FBSDKLoginButton()
            self.view.addSubview(loginView)
            loginView.frame.size.height = 50.0
            loginView.frame.size.width = 250.0
            loginView.center.x = self.view.center.x
            loginView.center.y = (self.view.frame.size.height - 100)
            loginView.readPermissions = ["public_profile", "email", "user_friends", "user_about_me"]
            loginView.titleLabel!.font = UIFont(name: "", size: 20)
            print ("Case: 2")
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool)
    {
        print("Gets to View did appear")
        if (FBSDKAccessToken.currentAccessToken() != nil)
        {
            //click log in button
            //enter app
            let storyboard: UIStoryboard = UIStoryboard(name:"Main", bundle: NSBundle.mainBundle())
            let tabBarController: UITabBarController = storyboard.instantiateViewControllerWithIdentifier("DownToEatTabBarController") as! DownToEatTabBarController
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.window!.rootViewController = tabBarController

        }
    }
    
    //login and all of its conditions
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
        if error != nil{
            print("Facebook login failed. Error \(error)")
        }else if result.isCancelled {
            print("Facebook login was cancelled")
        }else if result.grantedPermissions.contains("email"){
            
            let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
            
            FirebaseDataBase.fireBaseDataBase.USER_REF.authUser("facebook", password: accessToken, withCompletionBlock: { error, authData in
                
                if(error != nil){
                    print("Login failed. \(error)")
                }else{
                    print("Logged in! \(authData)")
                    print("User Saved Successfully! \(authData.uid)")
                    //log in
//                    self.processLogin(accessToken, authData: authData)
                    //enter app
                    let storyboard: UIStoryboard = UIStoryboard(name:"Main", bundle: NSBundle.mainBundle())
                    let tabBarController: UITabBarController = storyboard.instantiateViewControllerWithIdentifier("DownToEatTabBarController") as! DownToEatTabBarController
                    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                    appDelegate.window!.rootViewController = tabBarController
                    //let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("DownToEatTabBarController") as! UIViewController
                    //self.presentViewController(viewController, animated: true, completion: nil)
                }
                
            })
        }
        
    }
    

    //log out
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!)
    {
        let loginViewController = self.storyboard?.instantiateViewControllerWithIdentifier("FacebookLoginViewController") as? FacebookLoginViewController
        self.navigationController?.pushViewController(loginViewController!, animated: true)
    }

    
    //click log in button
    func didPressLoginButton()
    {
        print("button Pressed")
        let storyboard: UIStoryboard = UIStoryboard(name:"Main", bundle: NSBundle.mainBundle())
        let tabBarController: UITabBarController = storyboard.instantiateViewControllerWithIdentifier("DownToEatTabBarController") as! DownToEatTabBarController
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.window!.rootViewController = tabBarController
    }
}



//log in
//    func processLogin(accessToken: String, authData: FAuthData) {
//        FirebaseDataBase.fireBaseDataBase.USER_REF.childByAppendingPath(authData.uid).observeSingleEventOfType(.Value, withBlock: { snapshot in
//            if snapshot.value is NSNull {
//                print("fail")
//            } else {
//                print("no")
//            }
//        })
//    }


//    func createNewAccount(result: AnyObject) {
//        let email = "dude@thing.com"
//        let pw = "password"
//        
//        FirebaseDataBase.fireBaseDataBase.BASE_REF.authUser(email, password: pw) {
//            error, authData in
//            
//            if error != nil {
//                // eh, something went wrong, handle it
//                
//            } else {
//                
//                let myAppData = NSUserDefaults.standardUserDefaults()
//                myAppData.setValue(authData.uid, forKey: "uid")
//                myAppData.setValue(email, forKey: "email")
//                myAppData.setValue(pw, forKey: "password")
//            }
//        }
//    }
    
    
    
//    func retreiveImagesFromFacebook()
//    {
//        var profilePhotoURL: NSURL!
//        
//        config.profilePhotoImg = UIImageView(frame: CGRectMake(self.view.frame.size.width/2 - 100, 25, 200, 200))
//        let pictureRequest = FBSDKGraphRequest (graphPath: "me/picture?type=large&redirect=false", parameters: nil)
//        pictureRequest.startWithCompletionHandler({
//            (connection, result, error: NSError!) -> Void in
//            if error == nil {
//                print  ("This is the result \n\n \(result)")
//                let profilePictureURLData = result["data"] as? NSDictionary
//                for (dataField, dataResult) in profilePictureURLData!
//                {
//                    if dataField as! String == "url"
//                    {
//                        let dataResultString = dataResult as! String
//                        profilePhotoURL = NSURL(string: dataResultString)!
//                    }
//                }
//                
//                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0))
//                {
//                    //make sure your image in this url does exist, otherwise unwrap in a if let check
//                    let profileData = NSData(contentsOfURL: profilePhotoURL)
//                    
//                    dispatch_async(dispatch_get_main_queue(), {
//                        if let profileImageData = profileData as NSData? {
//                            self.config.profilePhotoImg.image = UIImage(data: profileImageData)
//                        }
//                    });
//                }
//            } else {
//                print("\(error)")
//            }
//        })
//    }
    

















/**********ORIGINAL************/


//
////
////  FacebookLoginViewController.swift
////  DownToEat
////
////  Created by Adan Cortez on 3/22/16.
////  Copyright © 2016 GrabABite. All rights reserved.
////
//
//import UIKit
//import Firebase
//
//class FacebookLoginViewController: UIViewController, FBSDKLoginButtonDelegate
//{
//	private var userID: NSString!
//	private var userName: NSString!
//	private var userEmail: NSString!
//	private var dataBaseConnection = Firebase(url: "https://grab-a-bite.firebaseio.com/")
//	private var firebase = Firebase(url: "https://grab-a-bite.firebaseio.com/")
//
//	var config = Config.sharedInstance
//
//	override func viewDidLoad()
//	{
//        super.viewDidLoad()
//		config.widthOfDevice = self.view.frame.size.width
//		config.heightOfDevice = self.view.frame.size.width
//		
//		print ("currentAccessToken: \(FBSDKAccessToken.currentAccessToken())")
//		// Do any additional setup after loading the view.
//		if (FBSDKAccessToken.currentAccessToken() != nil)
//		{
//			// User is already logged in, do work such as go to next view controller.
//			// Or Show Logout Button
//			let loginView : FBSDKLoginButton = FBSDKLoginButton()
//			self.view.addSubview(loginView)
//			loginView.frame.size.height = 50.0
//			loginView.frame.size.width = 250.0
//			loginView.center.x = self.view.center.x
//			loginView.center.y = (self.view.frame.size.height - 100)
//			loginView.readPermissions = ["public_profile", "email", "user_friends", "user_about_me"]
//			loginView.delegate = self
//			loginView.titleLabel!.font = UIFont(name: "Avenir-Black", size: 18)
//			print ("Case: 1")
//			self.retreiveImagesFromFacebook()
//			
//			self.returnUserData()
//		}
//		else
//		{
//			let loginView : FBSDKLoginButton = FBSDKLoginButton()
//			self.view.addSubview(loginView)
//			loginView.frame.size.height = 50.0
//			loginView.frame.size.width = 250.0
//			loginView.center.x = self.view.center.x
//			loginView.center.y = (self.view.frame.size.height - 100)
//			loginView.readPermissions = ["public_profile", "email", "user_friends", "user_about_me"]
//			loginView.delegate = self
//			loginView.titleLabel!.font = UIFont(name: "Avenir-Black", size: 18)
//			print ("Case: 2")
//		}
//		self.retreiveImagesFromFacebook()
//	}
//	
//	override func didReceiveMemoryWarning()
//	{
//		super.didReceiveMemoryWarning()
//		// Dispose of any resources that can be recreated.
//	}
//	
//	override func viewDidAppear(animated: Bool)
//	{
//		print("View did appear")
//		if (FBSDKAccessToken.currentAccessToken() != nil)
//		{
//			self.didPressLoginButton()
//		}
//	}
//	
//	// Facebook Delegate Methods
//	func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!)
//	{
//		print ("in here")
//		if ((error) != nil)
//		{
//			// Process error
//			print("Inside the Error1")
//		}
//		else if result.isCancelled
//		{
//			// Handle cancellations
//			print("Inside the Error2")
//		}
//		else
//		{
//			print("Inside the login")
//			// If you ask for multiple permissions at once, you
//			// should check if specific permissions missing
//			if result.grantedPermissions.contains("email")
//			{
//				// Do work
//				print ("email received")
//			}
//			if result.grantedPermissions.contains("user_friends")
//			{
//				// Do work
//				print ("user_friends received")
//			}
//			if result.grantedPermissions.contains("public_profile")
//			{
//				// Do work
//				print ("public_profile received")
//			}
//			if result.grantedPermissions.contains("user_about_me")
//			{
//				// Do work
//				print ("user_about_me received")
//			}
//			self.returnUserData()
//			print("Inside the login")
//		}
//		
//	}
//	
//	func loginButtonDidLogOut(loginButton: FBSDKLoginButton!)
//	{
//		let loginViewController = self.storyboard?.instantiateViewControllerWithIdentifier("FacebookLoginViewController") as? FacebookLoginViewController
//		self.navigationController?.pushViewController(loginViewController!, animated: true)
//	}
//
//	func returnUserData()
//	{
//		print("getting data")
//		let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, email, gender, cover, picture, birthday"])
//		graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
//			
//			if ((error) != nil)
//			{
//				// Process error
//				print("Error: \(error)")
//			}
//			else
//			{
//				print("fetched user: \(result)")
//				if let facebookID : NSString = result.valueForKey("id") as? NSString
//				{
//					self.userID = facebookID
//					print("User ID is: \(self.userID)")
//				}
//				if let facebookName : NSString = result.valueForKey("name") as? NSString
//				{
//					self.config.userName = facebookName as String
//					print("User Name is: \(self.config.userName)")
//				}
//				if let facebookEmail : NSString = result.valueForKey("email") as? NSString
//				{
//					self.userEmail = facebookEmail
//					print("User Email is: \(self.userEmail)")
//				}
////
////				if (self.firebase.observeEventType(<#T##eventType: FEventType##FEventType#>, withBlock: ^(FDataSnapshot *snapshot) {
////					for (FDataSnapshot* childSnap in snapshot.children) {
////						NSString* otherDeviceName = childSnap.name;
////						NSLog(@"otherDeviceName -> %@", childSnap.name);
////						NSLog(@"otherDeviceField1 -> %@", childSnap.value[@"field1"]);
////						NSLog(@"otherDeviceField2 -> %@", childSnap.value[@"field2"]);
////					}
////    }]
////				
//////				}
//////				else
//////				{
//////				}
//////
////				self.createNewAccount()
//				self.firebase.unauth()
////				self.createNewAccount(result)
//				self.firebase = self.firebaseConnect()
//				self.firebase.setValue(result)
//			}
//		})
//	}
//
//	func didPressLoginButton()
//	{
//		print("button Pressed")
//		let storyboard: UIStoryboard = UIStoryboard(name:"Main", bundle: NSBundle.mainBundle())
//		let tabBarController: UITabBarController = storyboard.instantiateViewControllerWithIdentifier("DownToEatTabBarController") as! DownToEatTabBarController
//		
//		let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//		appDelegate.window!.rootViewController = tabBarController	
//	}
//
//	func firebaseConnect() -> Firebase
//	{
//		firebase.authUser("grababiteinc@gmail.com", password: "iosmobile", withCompletionBlock:
//			{ error, authData in if error != nil
//			{ print("Connection failed!")
//				} else {
//					print("Sucessfully connected")
//				}
//		})
//		return firebase
//	}
//	
//	func createNewAccount(result: AnyObject)
//	{
//		print("IN here")
//		firebase.createUser(self.userEmail as String!, password: self.userID as String!, withValueCompletionBlock: { (error, authData) -> Void in
//			if error == nil
//			{
//				self.firebase.authUser(self.userEmail as String!, password: self.userID as String!, withCompletionBlock: { error, authData in
//					
//					if error == nil
//					{
//						self.firebase.setValue(result)
//						print("Account Created :)")
//					}
//					else
//					{
//						print(error)
//					}
//				})
//			}
//			else
//			{
//				print(error)
//			}
//			
//		})
//	}
//	
//	func retreiveImagesFromFacebook()
//	{
//		var profilePhotoURL: NSURL!
//		
//		config.profilePhotoImg = UIImageView(frame: CGRectMake(self.view.frame.size.width/2 - 100, 25, 200, 200))
//		let pictureRequest = FBSDKGraphRequest (graphPath: "me/picture?type=large&redirect=false", parameters: nil)
//		pictureRequest.startWithCompletionHandler({
//			(connection, result, error: NSError!) -> Void in
//			if error == nil {
//				print  ("This is the result \n\n \(result)")
//				let profilePictureURLData = result["data"] as? NSDictionary
//				for (dataField, dataResult) in profilePictureURLData!
//				{
//					if dataField as! String == "url"
//					{
//						let dataResultString = dataResult as! String
//						profilePhotoURL = NSURL(string: dataResultString)!
//					}
//				}
//				
//				dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0))
//				{
//					//make sure your image in this url does exist, otherwise unwrap in a if let check
//					let profileData = NSData(contentsOfURL: profilePhotoURL)
//					
//					dispatch_async(dispatch_get_main_queue(), {
//						if let profileImageData = profileData as NSData? {
//							self.config.profilePhotoImg.image = UIImage(data: profileImageData)
//						}
//					});
//				}
//			} else {
//				print("\(error)")
//			}
//		})
//	}
//	
//}
