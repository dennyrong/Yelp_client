//
//  ViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 9/19/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    var client: YelpClient!
    
    
    @IBOutlet weak var FilterButton: UIBarButtonItem!
    @IBOutlet weak var NavigationBar: UINavigationItem!
    // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
    let yelpConsumerKey = "O_3QHHhULoj2Iw3EAVTKIw"
    let yelpConsumerSecret = "68DXFih7l75dBrNjPgm9bB1Z3-0"
    let yelpToken = "mHcugxmbVrEL5O-Fk5KrlBU7zd1tSzAk"
    let yelpTokenSecret = "mhVfGFjv-ym-02XIseJeTLQhalg"
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    var defaults = NSUserDefaults.standardUserDefaults()
    var businesses: [NSDictionary] = []
    
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NavigationBar.titleView = searchBar
        
        NavigationBar.backBarButtonItem = UIBarButtonItem(title: "Cancle", style: .Plain , target: nil, action: nil)
        NavigationBar.backBarButtonItem?.tintColor = UIColor.whiteColor()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        
        
        var stringValue = defaults.objectForKey("update") as? String
        if stringValue != "update" {
        // Do any additional setup after loading the view, typically from a nib.
        client = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        
        client.searchWithTerm("Chinese", success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            println(response)
            self.businesses = response["businesses"] as [NSDictionary]
            self.tableView.estimatedRowHeight = 130.0;
            self.tableView.reloadData()
        }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
            println(error)
        }
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businesses.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        println("row is : \(indexPath.row), session is \(indexPath.section)")
        
        var business = businesses[indexPath.row]
        var cell = tableView.dequeueReusableCellWithIdentifier("YelpCell") as YelpViewCell
        var name =  business["name"] as? String
        var indexString = "\(indexPath.row+1). "
        cell.restaurant_Name.text = indexString + name!
        
        var reviews = business["review_count"] as Int
        cell.reviews.text = "\(reviews) Reviews"
        
        var restaurantURL = business["image_url"] as String
        var reviewURL = business["rating_img_url_large"] as String
        cell.rating.setImageWithURL(NSURL(string: reviewURL))
        cell.restaurant_Image.setImageWithURL(NSURL(string: restaurantURL))
        
        // parse business type
        var categories = business["categories"] as NSArray
        var category: NSArray!
        var type = ""
        for category in categories {
            type += (category[0] as String) + " "
        }
        cell.restaurant_Type.text = type
        
        // parse address
        var location = business["location"] as NSDictionary
        var address = location["address"] as NSArray
        var city = location["city"] as String!
        cell.address.text = (address[0] as String) + ", " + city
        
        return cell
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        println("Search starts")
        // Do any additional setup after loading the view, typically from a nib.
        client = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        
        var searchParams = searchBar.text
        println(searchParams)
        client.searchWithTerm(searchParams, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            println(response)
            self.businesses = response["businesses"] as [NSDictionary]
            self.tableView.rowHeight = UITableViewAutomaticDimension
            self.tableView.reloadData()
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println(error)
        }
        searchBar.endEditing(true)
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
        
        var stringValue = defaults.objectForKey("update") as? String
        
        if (stringValue == "update") {
            client = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
            var searchParams = ["term": "Pizza", "location": "San Francisco", "deals_filter": "true"]
            
            client.searchWithParams(searchParams, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                println(response)
                self.businesses = response["businesses"] as [NSDictionary]
                self.tableView.rowHeight = UITableViewAutomaticDimension
                self.tableView.reloadData()
                }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                    println(error)
            }

        }
        
    }
    
    
}

