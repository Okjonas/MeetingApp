import UIKit
import XLPagerTabStrip

class ChildViewController: UIViewController, IndicatorInfoProvider {

    @IBOutlet weak var label: UILabel!
    var childNumber: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = childNumber
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "\(childNumber)")
    }

}
