////
////  ChatViewController.swift
////  DownToEat
////
////  Created by Thuy Nguyen on 4/8/16.
////  Copyright © 2016 GrabABite. All rights reserved.
////
//
//import UIKit
////import Firebase
////import CoreData
//
//
//class ChatViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
//    
//    private let cellId = "cellId"
//
//    /* Core Data */
//    //set up data source for Chat Controller to represent each row (cell)
//    var messages: [Message]? //message array
//	var config = Config.sharedInstance
//	
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        navigationItem.title = "Recent"
//        collectionView?.backgroundColor = UIColor.whiteColor()
//        collectionView?.alwaysBounceVertical = true //allow pulling messages up/down
//        
//        //register collectionView cell class represents rows inside friend list
//        collectionView?.registerClass(MessageCell.self, forCellWithReuseIdentifier: cellId)
//
//		// Create left and right button for navigation item
//		let leftButton =  UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(ChatViewController.edit_btn_clicked(_:)))
//
//		navigationItem.leftBarButtonItem = leftButton
//		navigationItem.leftBarButtonItem?.setTitleTextAttributes( [ NSFontAttributeName: config.navigationBarItemFont, NSForegroundColorAttributeName: UIColor.whiteColor()], forState: UIControlState.Normal)
//		
//		self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: config.themeFont, NSForegroundColorAttributeName: UIColor.whiteColor()]
//		self.navigationController?.navigationBar.backgroundColor = config.themeColor
//
//        setupData()
//    }
//	
//	override func viewDidAppear(animated: Bool) {
//		super.viewDidAppear(animated)
//	}
//
//	override func viewDidDisappear(animated: Bool) {
//		super.viewDidDisappear(animated)
//	}
//
//	required init?(coder aDecoder: NSCoder) {
//		super.init(coder: aDecoder)
//	
//		// Initialize Tab Bar Item
//		tabBarItem = UITabBarItem(title: "Messenger", image: UIImage(named: "chat_orange"), tag: 1)
//		tabBarItem.setTitleTextAttributes([ NSFontAttributeName: config.smallTextFont, NSForegroundColorAttributeName: UIColor.whiteColor()], forState: .Normal)
//	}
//
//	//return number rows for recent messages
//    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        //unwrape option to return number of messages
//        if let count = messages?.count {
//            return count
//        }
//        return 0
//    }
//    
//    //return view for cells
//    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! MessageCell
//        
//        //need to unwrap message variable
//        if let message = messages?[indexPath.item] {
//            cell.message = message
//        }
//        return cell
//    }
//    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        return CGSizeMake(view.frame.width, 100) //size of container
//    }
//    
//    //use the ChatLogController to open up messages
//    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        let layout = UICollectionViewFlowLayout()
//        let controller = ChatLogController(collectionViewLayout: layout)
//        controller.friend = messages?[indexPath.item].friend
//        navigationController?.pushViewController(controller, animated: true)
//    }
//	
//	func edit_btn_clicked(sender: UIBarButtonItem)
//	{
//
//	}
//}
//
//var config = Config.sharedInstance
//
////everything relates to friend message cell
//class MessageCell: BaseCell {
//	
//    //set message property
//    var message: Message? {
//        didSet {
//            nameLabel.text = message?.friend?.name
//            
//            if let profileImageName = message?.friend?.profileImageName {
//                profileImageView.image = UIImage(named: profileImageName);
//                hasReadImageView.image = UIImage(named: profileImageName);
//            }
//            
//            messageLabel.text = message?.text
//            
//            if let date = message?.date {
//                
//                let dateFormatter = NSDateFormatter()
//                dateFormatter.dateFormat = "h:mm a" // a = am
//                
//                timeLabel.text = dateFormatter.stringFromDate(date)
//            }
//        }
//    }
//    
//    //image view of user profile pic inside cell
//    let profileImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.contentMode = .ScaleAspectFill
//        imageView.layer.cornerRadius = 34 //round edges
//        imageView.layer.masksToBounds = true
//        return imageView
//    }()
//    
//    //dividers between cells
//    let dividerLineView: UIView = {
//        let view = UIView()
//        view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
//        return view
//    }()
//    
//    //label for user name inside containerView
//    let nameLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Thuy Nguyen" //TODO: make call to firebase to pull name from fb
//        label.font = config.navigationBarItemFont // 18 pt
//        return label
//    }()
//    
//    //label for message inside containerView
//    let messageLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Messages go here..."
//        label.textColor = UIColor.darkGrayColor()
//        label.font = config.mediumTextFont // 14 pt
//        return label
//    }()
//    
//    //label for time inside containerView
//    let timeLabel: UILabel = {
//        let label = UILabel()
//        label.text = "12:05 pm" //TODO: implement time via core data
//        label.font = config.largeTextFont // 16 pt
//        label.textAlignment = .Right
//        return label
//    }()
//    
//    //image view of user profile pic indicating read message
//    let hasReadImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.contentMode = .ScaleAspectFill
//        imageView.layer.cornerRadius = 10
//        imageView.layer.masksToBounds = true
//        return imageView
//    }()
//    
//    
//    override func setupViews() {
//        
//        addSubview(profileImageView)
//        addSubview(dividerLineView)
//        
//        setupContainerView()
//        
//        //render image for user profile pic in cell
//        //TODO: make call to firebase to pull in pic from fb
//        profileImageView.image = UIImage(named: "thuy")
//        hasReadImageView.image = UIImage(named: "thuy")
//        
//        //add constraints and set size for user profile pic in cell
//        addConstraintsWithFormat("H:|-12-[v0(68)]", views: profileImageView)
//        addConstraintsWithFormat("V:[v0(68)]", views: profileImageView)
//        
//        //center user image containerView inside cell
//        addConstraint(NSLayoutConstraint(item: profileImageView, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0))
//        
//        addConstraintsWithFormat("H:|-82-[v0]|", views: dividerLineView)
//        addConstraintsWithFormat("V:[v0(1)]|", views: dividerLineView)
//    }
//    
//    //set up content view contains attributes to cell (ie. name, messages, etc)
//    private func setupContainerView() {
//        let containerView = UIView()
//        addSubview(containerView)
//        
//        addConstraintsWithFormat("H:|-90-[v0]|", views: containerView) //padding for container view from left border
//        addConstraintsWithFormat("V:[v0(50)]", views: containerView) //height of container view
//        addConstraint(NSLayoutConstraint(item: containerView, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0))
//        
//        containerView.addSubview(nameLabel)
//        containerView.addSubview(messageLabel)
//        containerView.addSubview(timeLabel)
//        containerView.addSubview(hasReadImageView)
//        
//        //constraints for labels inside container view
//        containerView.addConstraintsWithFormat("H:|[v0][v1(80)]-12-|", views: nameLabel, timeLabel)
//        
//        containerView.addConstraintsWithFormat("V:|[v0][v1(24)]|", views: nameLabel, messageLabel)
//        
//        containerView.addConstraintsWithFormat("H:|[v0]-8-[v1(20)]-12-|", views: messageLabel, hasReadImageView)
//        
//        containerView.addConstraintsWithFormat("V:|[v0(24)]", views: timeLabel)
//        
//        containerView.addConstraintsWithFormat("V:[v0(20)]|", views: hasReadImageView)
//    }
//    
//}
//
////extension to condense all addConstraint calls above
//extension UIView {
//    
//    func addConstraintsWithFormat(format: String, views: UIView...) {
//        
//        //dictionary of string to UIView, pass in as parameter below
//        var viewsDictionary = [String: UIView]()
//        //iterate through view array
//        for (index, view) in views.enumerate() {
//            let key = "v\(index)"
//            viewsDictionary[key] = view
//            view.translatesAutoresizingMaskIntoConstraints = false
//        }
//        
//        //pass in viewsDictionary parameter
//        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
//    }
//    
//}
//
////keep unecessary stuff for setup cell
//class BaseCell: UICollectionViewCell {
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupViews()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func setupViews() {
//    }
//}
