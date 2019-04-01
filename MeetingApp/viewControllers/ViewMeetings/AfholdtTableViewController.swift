//
//  AfholdtTableViewController.swift
//  MeetingApp
//
//  Created by Troels on 01/04/2019.
//  Copyright © 2019 TJ. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import XLPagerTabStrip

class AfholdtTableViewController: UITableViewController, IndicatorInfoProvider{
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "\(SlidebtnName)")
    }
    
    var done: Bool?
    var userid: Int?
    
    var jsonData: [JSON]?
    var jsonString: String?
    
    var SlidebtnName: String = ""
    
    var list: [MeetingDTO] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.rowHeight = 75
        
        refreshControl = UIRefreshControl()
        refreshControl!.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl!.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl!)
    }
    
    @objc func refresh(_ sender: Any) {
        //  your code to refresh tableView
        getdata()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MeetingCell", for: indexPath) as! MeetingCell
        let meetingDTO = list[indexPath.row]
        cell.MeetingName.text = meetingDTO.name
        cell.MeetingTopic.text = meetingDTO.topic
        
        let isoDate = "\(meetingDTO.year!)-\(meetingDTO.month!)-\(meetingDTO.day!)T00:00:00+0000"
        let dateFormatter = ISO8601DateFormatter()
        let date = dateFormatter.date(from:isoDate)!
        
        cell.MeetingDate.text = DateFormatter.localizedString(from: date, dateStyle: .short, timeStyle: .none)
        return cell
    }
    
    func getdata(){
        Alamofire.request("http://localhost:8080/rest/Meeting/AllByUser/\(String(describing: userid!))?done=\(String(describing: done!))").responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
            
            if let data = response.data, let jsonArray = JSON(data).array  {
                // print("Data: \(utf8Text)") // original server data as UTF8 string
                //TabelDataList.removeAll()
                
                self.list.removeAll()
                
                for index in jsonArray {
                    let item = MeetingDTO()
                    item.name = index["name"].string
                    item.createdById = index["createdById"].int
                    item.day = index["day"].int
                    item.endTime = index["endtime"].string
                    item.expectedDuration = index["expectedDuration"].string
                    item.meetingID = index["meetingID"].string
                    item.month = index["month"].int
                    item.place = index["place"].string
                    item.realendTime = index["realendTime"].string
                    item.realStartTime = index["realStartTime"].string
                    item.startTime = index["startTime"].string
                    item.state = index["state"].int
                    item.topic = index["topic"].string
                    item.userMeetingID = index["userMeetingID"].string
                    item.year = index["year"].int
                    
                    self.list.append(item)
                }
                
                print(self.list)
                self.tableView.reloadData()
                self.refreshControl!.endRefreshing()
                
            }
        }
    }
    
}
