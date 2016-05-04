////
////  ChatLogController.swift
////  DownToEat
////
////  Created by Thuy Nguyen on 4/21/16.
////  Copyright © 2016 GrabABite. All rights reserved.
////
//
//import UIKit
//
//
////this function enables users to view the messages within the log
//class ChatLogController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
//    
//    private let cellId = "cellId"
//	var config = Config.sharedInstance
//	
//    //contain properties for Friends
//    var friend: Friend? {
//        didSet {
//            
//            navigationItem.title = friend?.name
//            messages = friend?.messages?.allObjects as? [Message]
//            
//            //sort messages within log in time order
//            messages = messages?.sort({$0.date!.compare($1.date!) == .OrderedAscending})
//            
//        }
//    }
//    //create a message array to call when we do didSet
//    var messages: [Message]?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        //set background of message to white when click to expand
//        collectionView?.backgroundColor = UIColor.whiteColor()
//        
//        //register message class
//        collectionView?.registerClass(ChatLogMessageCell.self, forCellWithReuseIdentifier: cellId)
//    }
//    
//    //return number of items per sections
//    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if let count = messages?.count {
//            return count
//        }
//        return 0
//    }
//    
//    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! ChatLogMessageCell
//        
//        //set message
//        cell.messageTextView.text = messages?[indexPath.item].text
//        
//        //calculate size of messages
//        if let messageText = messages?[indexPath.item].text, profileImageName = messages?[indexPath.item].friend?.profileImageName {
//            
//            cell.profileImageView.image = UIImage(named: profileImageName)
//            
//            let size = CGSizeMake(250, 1000)
//            let options = NSStringDrawingOptions.UsesFontLeading.union(.UsesLineFragmentOrigin)
//            let estimatedFrame = NSString(string: messageText).boundingRectWithSize(size, options: options, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(18)], context: nil)
//            
//            cell.messageTextView.frame = CGRectMake(48 + 8, 0, estimatedFrame.width + 16, estimatedFrame.height + 20)
//            cell.textBubbleView.frame = CGRectMake(48, 0, estimatedFrame.width + 16 + 8, estimatedFrame.height + 20)
//        }
//        
//        return cell
//    }
//    //return cell per message
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        
//        if let messageText = messages?[indexPath.item].text {
//            let size = CGSizeMake(250, 1000)
//            let options = NSStringDrawingOptions.UsesFontLeading.union(.UsesLineFragmentOrigin)
//            let estimatedFrame = NSString(string: messageText).boundingRectWithSize(size, options: options, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(18)], context: nil)
//            
//            return CGSizeMake(view.frame.width, estimatedFrame.height + 20)
//        }
//        
//        return CGSizeMake(view.frame.width, 100)
//    }
//    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
//        return UIEdgeInsetsMake(8, 0, 0, 0)
//    }
//    
//}
//
////register class with Basecell as subclass (simple message cell)
//class ChatLogMessageCell: BaseCell {
//    
//    let messageTextView: UITextView = {
//        let textView = UITextView()
//        textView.font = UIFont.systemFontOfSize(16)
//        textView.text = "Sample message"
//        textView.backgroundColor = UIColor.clearColor() //set bg clear to see orange bubble
//        return textView
//    }()
//    
//    let textBubbleView: UIView = {
//        let view = UIView()
//        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
//        //view.backgroundColor = UIColor(red:0.93, green:0.4, blue:0.33, alpha:1.0)
//        view.layer.cornerRadius = 15
//        view.layer.masksToBounds = true
//        return view
//    }()
//    
//    //create image view for profile pic
//    let profileImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.contentMode = .ScaleAspectFill
//        imageView.layer.cornerRadius = 15
//        imageView.layer.masksToBounds = true
//        return imageView
//    }()
//    
//    override func setupViews() {
//        super.setupViews()
//        
//        //background color of each message
//        //backgroundColor = UIColor(red:0.93, green:0.4, blue:0.33, alpha:1.0) //coral color
//
//        addSubview(textBubbleView)
//        addSubview(messageTextView)
//        addSubview(profileImageView)
//        
//        //constraints
//        //addConstraintsWithFormat("H:|[v0]|", views: messageTextView)
//        //addConstraintsWithFormat("V:|[v0]|", views: messageTextView)
//        
//        addConstraintsWithFormat("H:|-8-[v0(30)]|", views: profileImageView)
//        addConstraintsWithFormat("V:|[v0(30)]|", views: profileImageView)
//        profileImageView.backgroundColor = UIColor.blueColor()
//        
//    }
//    
//}
