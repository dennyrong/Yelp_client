//
//  FilterViewController.swift
//  Yelp
//
//  Created by Kun Rong on 9/21/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var FilterView: UITableView!
    
    var sort: NSArray = ["Best Matched", "Most Review", "Distance"]
    var distance: NSArray = ["Auto", "0.5 miles", "1 miles", "2 miles", "> 5 miles"]
    var category: NSArray = ["Select All", "Afghan", "African", "American", "Arabian", "Argentine", "Asian Fusion", "Austrian", "Beer Garden", "Breakfast & Brunch", "Buffets", "Bulgarian", "Burgers", "Canadian", "Chinese", "Dumplings","Korean"   ]
    var section_header: NSArray = ["Most Popular", "Sort By", "Distance", "Category"]
    
    var isExpand: [Int: Bool] = [Int: Bool] ()
    
    var selected:[Int: Int]  = [Int: Int] ()
    
    var defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        FilterView.delegate = self
        FilterView.dataSource = self
        super.viewDidLoad()
        
        defaults.setObject("update", forKey: "update")
        defaults.synchronize()
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (isExpand[section]==false || isExpand[section]==nil) {
            return 1;
        } else {
            return RowsInSection(SecNum: section);
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            var cell = FilterView.dequeueReusableCellWithIdentifier("FilterDealCell") as FilterDealCell
            return cell
        } else {
            var cell = FilterView.dequeueReusableCellWithIdentifier("FilterCell") as FilterCell
            println(indexPath.row)
            println(indexPath.section)
           
            cell.cellLabel.text = SectionRowText(RowNum: indexPath.row, SecNum: indexPath.section)
            return cell
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return section_header.count
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        var headerView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        headerView.backgroundColor = UIColor.lightGrayColor()
        var Label = UILabel(frame: CGRect(x: 10, y: 10, width: 300, height: 30))
        
        if (section < section_header.count) {
            //Label.text = "\(section)"
            Label.text = (section_header[section] as String)
            Label.textColor = UIColor.grayColor()
        } else {
            Label.text = ""
        }
        
        Label.font = UIFont.systemFontOfSize(22)
        headerView.addSubview(Label)
        return headerView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (indexPath.section == 0) {
            return 80
        }
        return 40
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (isExpand[indexPath.section] == nil){
            isExpand[indexPath.section] = true
        } else if (isExpand[indexPath.section] == true) {
            isExpand[indexPath.section] = false;
        }
        else {
            isExpand[indexPath.section] = true;
        }
        
        selected[indexPath.section] = indexPath.row
        
        tableView.reloadSections(NSIndexSet(index: indexPath.section), withRowAnimation: UITableViewRowAnimation.Fade)
    }
    
    
    func SectionRowText (RowNum row:Int, SecNum section:Int) -> String {
        
        if (section == 0) {
            return ""
        } else if (section == 1) {
            if (row < sort.count) {
                return sort[row] as String
            }
        } else if (section == 2) {
            if (row < distance.count){
                return distance[row] as String
            }
            
        } else if (section == 3) {
            if (row < category.count) {
                return category[row] as String
            }
        }
        return "not available"
    }
    
    func RowsInSection (SecNum section:Int) -> Int {
        if (section == 0) {
            return 1
        } else if (section == 1) {
            return sort.count
        } else if (section == 2) {
            return distance.count
        } else {
            return category.count
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
