////
////  ChatViewHelper.swift
////  DownToEat
////
////  Created by Thuy Nguyen on 4/21/16.
////  Copyright © 2016 GrabABite. All rights reserved.
////
//
//import UIKit
//import CoreData
//
//extension ChatViewController {
//	
//    //always clear coredata objects
//    func clearData() {
//        let delegate = UIApplication.sharedApplication().delegate as? AppDelegate
//        
//        if let context = delegate?.managedObjectContext {
//            
//            do {
//                
//                let entityNames = ["Friend", "Message"]
//                
//                //iterate to delete all objects
//                for entityName in entityNames {
//                    let fetchRequest = NSFetchRequest(entityName: entityName)
//                    
//                    let objects = try(context.executeFetchRequest(fetchRequest)) as? [NSManagedObject]
//                    //iterate though all objects
//                    for object in objects! {
//                        context.deleteObject(object)
//                    }
//                }
//                //need to save context objects
//                try(context.save())
//                
//                
//            } catch let err {
//                print(err)
//            }
//            
//        }
//    }
//    
//    func setupData() {
//        
//        clearData()
//        
//        let delegate = UIApplication.sharedApplication().delegate as? AppDelegate
//        
//        //since we are using coredata, Friend and Message are no long NSObjects
//        //context is a variable from appdelegate
//        if let context = delegate?.managedObjectContext {
//            
//            //initalize user object
//            let thuy = NSEntityDescription.insertNewObjectForEntityForName("Friend", inManagedObjectContext: context) as! Friend
//            thuy.name = "Thuy Nguyen"
//            thuy.profileImageName = "thuy"
//            //call function to generate thread messaging
//            createMessageWithText("yo yo yo", friend: thuy, minutesAgo: 6, context: context)
//            createMessageWithText("What's up dawg", friend: thuy, minutesAgo: 3, context: context)
//            createMessageWithText("My name is Thuy like tweety bird.", friend: thuy, minutesAgo:1, context: context)
//            
//            //maverick
//            let maverick = NSEntityDescription.insertNewObjectForEntityForName("Friend", inManagedObjectContext: context) as! Friend
//            maverick.name = "Maverick Dides-Nguyen"
//            maverick.profileImageName = "maverick"
//            createMessageWithText("roof roof", friend: maverick, minutesAgo: 4, context: context)
//            createMessageWithText("i love mommy", friend: maverick, minutesAgo: 3, context: context)
//            createMessageWithText("i love daddy too", friend: maverick, minutesAgo: 2, context: context)
//            
//            //emil
//            let emil = NSEntityDescription.insertNewObjectForEntityForName("Friend", inManagedObjectContext: context) as! Friend
//            emil.name = "Emil Dides"
//            emil.profileImageName = "emil"
//            createMessageWithText("i love my dog", friend: emil, minutesAgo: 5, context: context)
//            createMessageWithText("i designed boxhopp", friend: emil, minutesAgo: 0, context: context)
//
//            
//            //save context for data to persist
//            do {
//                try(context.save())
//            } catch let err {
//                print(err)
//            }
//        }
//        
//        //load data (data objects)
//        loadData()
//    }
//    
//    //function to repeat messages (thread messaging)
//    //adding time parameter to indicate how much time has passed since message sent
//    func createMessageWithText(text: String, friend: Friend, minutesAgo: Double, context: NSManagedObjectContext) {
//        let message = NSEntityDescription.insertNewObjectForEntityForName("Message", inManagedObjectContext: context) as! Message
//        //pass in generic parameters for friends and messages
//        message.friend = friend
//        message.text = text
//        message.date = NSDate().dateByAddingTimeInterval(-minutesAgo * 60) //minutes passed
//    }
//    
//    func loadData() {
//        let delegate = UIApplication.sharedApplication().delegate as? AppDelegate
//        
//        if let context = delegate?.managedObjectContext {
//            //fetch for all users
//            if let friends = fetchFriends() {
//                //instantiate message and  appened below
//                messages = [Message]()
//                
//            //print all of friend names to console
//            for friend in friends {
//                print(friend.name)
//                //fetch messages objects
//                let fetchRequest = NSFetchRequest(entityName: "Message")
//                //sort messages based on time in descending order
//                fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
//                //use predicate to grab only the last message
//                fetchRequest.predicate = NSPredicate(format: "friend.name = %@", friend.name!)
//                //add filter to set fetch limit 1 so we only see 1 last message
//                fetchRequest.fetchLimit = 1
//                
//                do {
//                    //append fetch contain of array
//                    //load into an array and set messages to data model
//                    let fetchedMessages = try(context.executeFetchRequest(fetchRequest)) as? [Message]
//                    messages?.appendContentsOf(fetchedMessages!)
//                    
//                } catch let err {
//                    print(err)
//                }
//
//            }
//            //sort friend order of messages
//            messages = messages?.sort({$0.date!.compare($1.date!) == .OrderedDescending})
//        }
//            
//    }
//}
//    
//    
//    private func fetchFriends() -> [Friend]? {
//        let delegate = UIApplication.sharedApplication().delegate as? AppDelegate
//        if let context = delegate?.managedObjectContext {
//            let request = NSFetchRequest(entityName: "Friend")
//            do {
//                return try context.executeFetchRequest(request) as? [Friend]
//            }catch let err {
//                print(err)
//            }
//        }
//        
//        return nil
//    }
//    
//}
