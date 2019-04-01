import FoldingCell
import UIKit
import XLPagerTabStrip
import Alamofire
import SwiftyJSON
/*
class MainTableViewController: UITableViewController, IndicatorInfoProvider {
    
    var done: Bool?
    var userid: Int?
    
    var jsonData: [JSON]?
    var jsonString: String?
    
    var list = [MeetingDTO]()
    
    var SlidebtnName: String = ""

    var tabelDataList: [MeetingDTO] = []
    
    enum Const {
        static let closeCellHeight: CGFloat = 179
        static let openCellHeight: CGFloat = 488
        static let rowsCount = 10
    }
    
    var cellHeights: [CGFloat] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
      //  return IndicatorInfo(title: "\(SlidebtnName)", image: #imageLiteral(resourceName: "profilIcon"))
         return IndicatorInfo(title: "\(SlidebtnName)")
    }

    private func setup() {
      //  getdata()
        cellHeights = Array(repeating: Const.closeCellHeight, count: Const.rowsCount)
        tableView.estimatedRowHeight = Const.closeCellHeight
        tableView.rowHeight = UITableView.automaticDimension
        //tableView.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "Image"))
        tableView.backgroundColor = #colorLiteral(red: 0.9370916486, green: 0.9369438291, blue: 0.9575446248, alpha: 1)
        if #available(iOS 10.0, *) {
            tableView.refreshControl = UIRefreshControl()
            tableView.refreshControl?.addTarget(self, action: #selector(refreshHandler), for: .valueChanged)
        }
    }
    
    @objc func refreshHandler() {
        let deadlineTime = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: { [weak self] in
            self!.getdata()
            if #available(iOS 10.0, *) {
                self?.tableView.refreshControl?.endRefreshing()
            } 
            self?.tableView.reloadData()
        })
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
 
            }
        }
    }
    
    
    
    
}

// MARK: - TableView

extension MainTableViewController {
    
    
    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return list.count
    }

    override func tableView(_: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    //    guard case let cell as DemoCell = cell else {
  //          return
  //      }

        cell.backgroundColor = .clear

        if cellHeights[indexPath.row] == Const.closeCellHeight {
            cell.unfold(false, animated: false, completion: nil)
        } else {
            cell.unfold(true, animated: false, completion: nil)
        }

        print(indexPath.row)
        cell.number = list[indexPath.row].day ?? 0
        cell.data = list[indexPath.row].name ?? ""
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoldingCell", for: indexPath) as! FoldingCell
        let durations: [TimeInterval] = [0.26, 0.2, 0.2]
        cell.durationsForExpandedState = durations
        cell.durationsForCollapsedState = durations
        return cell
    }

    override func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let cell = tableView.cellForRow(at: indexPath) as! FoldingCell

        if cell.isAnimating() {
            return
        }

        var duration = 0.0
        let cellIsCollapsed = cellHeights[indexPath.row] == Const.closeCellHeight
        if cellIsCollapsed {
            cellHeights[indexPath.row] = Const.openCellHeight
            cell.unfold(true, animated: true, completion: nil)
            duration = 0.5
        } else {
            cellHeights[indexPath.row] = Const.closeCellHeight
            cell.unfold(false, animated: true, completion: nil)
            duration = 0.8
        }

        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
        }, completion: nil)
    }
}
*/