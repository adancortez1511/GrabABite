//
//  FirebaseDataBase.swift
//  DownToEat
//
//  Created by Thuy Nguyen on 5/4/16.
//  Copyright © 2016 GrabABite. All rights reserved.
//

import Foundation
import Firebase

// This class is a service class that interacts with Firebase
class FirebaseDataBase {
    
    static let fireBaseDataBase = FirebaseDataBase()
    
    //To read and write data, we need to create a Firebase database reference with the Firebase URL
    private var _BASE_REF = Firebase(url: "https://grababite.firebaseio.com") //root grababite
    private var _USER_REF = Firebase(url: "https://grababite.firebaseio.com/userID") //list of all existing users
    private var _MESSAGE_REF = Firebase(url: "https://grababite.firebaseio.com/messages") //list of all messages
    private var _EVENT_REF = Firebase(url: "https://grababite.firebaseio.com/events") //list of events created
    private var _SCHEDULE_REF = Firebase(url: "https://grababite.firebaseio.com/schedule") //list of events users liked
        
    var BASE_REF: Firebase {
        return _BASE_REF
    }
    
    var USER_REF: Firebase {
        return _USER_REF
    }
    
    var MESSAGE_REF: Firebase {
        return _MESSAGE_REF
    }
    
    var EVENT_REF: Firebase {
        return _EVENT_REF
    }
    
    var SCHEDULE_REF: Firebase {
        return _SCHEDULE_REF
    }
    
    
    var CURRENT_USER_REF: Firebase {
        let userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
        
        let currentUser = Firebase(url: "\(BASE_REF)").childByAppendingPath("users").childByAppendingPath(userID)
        
        return currentUser!
    }
    
    
    
    /******* FUNCTIONS *******/
    
    //user log in
    func userLogin(uid: String, user: Dictionary<String, String>) {
        
        // actual saving of new users happens here!!
        // setValue saves data to Firebase
        USER_REF.childByAppendingPath(uid).setValue(user)
    }
   
    
    
    //CREATE NEW MESSAGE
    func createNewMessage(message: Dictionary<String, AnyObject>) {
        
        // Save the Message
        // MESSAGE_REF is the parent of the new messages: "messages".
        // childByAutoId() saves the message and gives it its own ID.
        let firebaseNewMessage = MESSAGE_REF.childByAutoId()
        
        // setValue saves to Firebase.
        firebaseNewMessage.setValue(message)
    }
    
    
    //CREATE NEW EVENT
    func createNewEvent(event: Dictionary<String, AnyObject>) {
        
        //TODO:
        //set all necessary info about event that need to be saved
        //make sure to set condition when user creates an event. it is also being appended to the list of events user liked
        
        // Save the event
        // EVENT_REF is the parent of the new events: "events".
        // childByAutoId() saves the event and gives it its own ID.
        let firebaseNewEvent = EVENT_REF.childByAutoId()
        
        // setValue saves to Firebase.
        firebaseNewEvent.setValue(event)
    }

    
    
    
}



/* EXAMPLE OF HOW FIREBASE IS STRUCTING */

/***************************************
// The root of the tree
// https://<your-firebase-app>.firebaseio.com/
{
    // https://<your-firebase-app>.firebaseio.com/grocery-items
    "grocery-items": {
        
        // https://<your-firebase-app>.firebaseio.com/grocery-items/milk
        "milk": {
            
            // https://<your-firebase-app>.firebaseio.com/grocery-items/milk/name
            "name": "Milk",
            
            // https://<your-firebase-app>.firebaseio.com/grocery-items/milk/addedByUser
            "addedByUser": "David"
        },
        
        "pizza": {
            "name": "Pizza",
            "addedByUser": "Alice"
        },
    }
}
 
 

// 1
let rootRef = Firebase(url: "https://<your-firebase-app>.firebaseio.com/")

// 2
let childRef = Firebase(url: "https://<your-firebase-app>.firebaseio.com/grocery-items")

// 3
let itemsRef = rootRef.childByAppendingPath("grocery-items")

// 4
let milkRef = itemsRef.childByAppendingPath("milk")

// 5
println(rootRef.key)   // prints: ""
println(childRef.key)  // prints: "grocery-items"
println(itemsRef.key)  // prints: "grocery-items"
println(milkRef.key)   // prints: "milk"

*************************************/



















/*************** OLD STUFF **************/



//import Foundation
//import Firebase
//
//// Example
//// var firebase = firebaseConnect()
//class FirebaseDataBase
//{
//	class func firebaseConnect() -> Firebase
//	{
//		let firebase = Firebase(url: "https://grab-a-bite.firebaseio.com/")
//    
//		firebase.authUser("grababiteinc@gmail.com", password: "iosmobile", withCompletionBlock:
//			{ error, authData in if error != nil
//				{ print("Connection failed!")
//					} else {
//						print("Sucessfully connected")
//					}
//		})
//		return firebase
//	}
//	
//	class func currentUser(userID: NSString) -> Firebase
//	{
//		let firebase = Firebase(url: "https://grab-a-bite.firebaseio.com/")
//		let currUser = firebase.childByAppendingPath("users").childByAppendingPath(userID as String)
//		
//		return currUser
//	}
//}