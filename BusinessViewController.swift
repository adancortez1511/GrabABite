//
//  BusinessViewController.swift
//  DownToEat
//
//  Created by Thuy Nguyen on 4/25/16.
//  Copyright © 2016 GrabABite. All rights reserved.
//


import UIKit

class BusinessesViewController: UIViewController, FilterViewControllerDelegate, UIScrollViewDelegate, UITableViewDataSource {

    var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!    
    
    var businesses: [Business]?
    var filteredData : [Business]! //for detail view
    var searchTerm: String?
    //var isMoreDataLoading = false
    //var loadingMoreView:InfiniteScrollActivityView? //for infinite scrolling
    var offset : Int? = 20 //extract info from offset parameter
    
    var config = Config.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
        
        //search bar programatically
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        let textFieldInsideSearchBar = searchBar.valueForKey("searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = UIColor.lightGrayColor()
        searchBar.placeholder = "Input text and press Enter"
        
        Business.searchWithTerm("", completion: { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.filteredData = businesses
            self.tableView.reloadData()
            for business in businesses {
                print(business.name!)
                print(business.address!)
            }
        })
        
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: config.themeFont, NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.backgroundColor = config.themeColor
        
        let leftButton =  UIBarButtonItem(title: "Filter", style:   UIBarButtonItemStyle.Plain, target: self, action: #selector(BusinessesViewController.btn_clicked(_:)))
        self.navigationItem.leftBarButtonItem = leftButton
        
        self.navigationItem.leftBarButtonItem?.setTitleTextAttributes( [ NSFontAttributeName: config.navigationBarItemFont, NSForegroundColorAttributeName: UIColor.whiteColor()], forState: UIControlState.Normal)
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes( [ NSFontAttributeName: config.navigationBarItemFont, NSForegroundColorAttributeName: UIColor.whiteColor()], forState: UIControlState.Normal)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func btn_clicked(sender: UIBarButtonItem) {
        // Do something
        let storyboard: UIStoryboard = UIStoryboard(name:"Main", bundle: NSBundle.mainBundle())
        let filterViewController: UIViewController = storyboard.instantiateViewControllerWithIdentifier("FilterViewController") as! FilterViewController
        
        self.showViewController(filterViewController, sender: filterViewController)
    }
    
    //filtering data for filter view
    func filterViewController(filterViewController: FilterViewController, didUpdateFilters filters: [String : AnyObject]) {
        
        let sort = filters["sort"] as? YelpSortMode?
        let categories = filters["categories"] as? [String]
        let distances = filters["distances"] as? Int
        let deal = filters["deals"] as? Bool
        
        Business.searchWithTerm("Restaurants", sort: sort!, categories: categories, deals: deal, offset: distances!) { (businesses: [Business]!, error: NSError!) -> Void in
            
            self.businesses = businesses
            self.tableView.reloadData()
            
            for business in businesses {
                print(business.name!)
                print(business.distance!)
            }
        }
    }
    
}

//business cell
extension BusinessesViewController:  UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return businesses?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell", forIndexPath: indexPath) as! BusinessCell
        let business = businesses![indexPath.row]
        if business.imageURL == nil {
            cell.restaurantImageView.image = nil
        }
        else
        {
            cell.restaurantImageView.setImageWithURL(business.imageURL!)
        }
        cell.nameLabel.text = business.name
        cell.addressLabel.text = business.address
        cell.categoriesLabel.text = business.categories
        cell.ratingsCountLabel.text = "\(business.reviewCount!) Reviews"
        cell.ratingsImageView.setImageWithURL(business.ratingImageURL!)
        cell.distanceLabel.text = business.distance
        
        return cell
    }
    
    // Segue from Business cell to detail view
    // Pass the selected object to the new view controller.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPathForCell(cell)
        let selectedBusiness = filteredData![indexPath!.row]
        let detailViewControllerDestination = segue.destinationViewController as! DetailViewController
        detailViewControllerDestination.business = selectedBusiness
        print("Seque to Detail View")
    }
}

//search bar
extension BusinessesViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true;
    }
    
    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        self.searchTerm = searchBar.text

        Business.searchWithTerm(searchTerm!, completion: { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.tableView.reloadData()
            for business in businesses {
                print(business.name!)
                print(business.address!)
            }
        })
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.searchTerm = searchBar.text
        Business.searchWithTerm(searchTerm!, completion: { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.tableView.reloadData()
            for business in businesses {
                print(business.name!)
                print(business.address!)
            }
        })
        searchBar.resignFirstResponder()
    }
}
