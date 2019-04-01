import UIKit
import XLPagerTabStrip

class AllMeetingView: ButtonBarPagerTabStripViewController {

    override func viewDidLoad() {
        configureButtonBar()
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Configuration
    func configureButtonBar() {
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white

        settings.style.buttonBarItemFont = UIFont(name: "Helvetica", size: 16.0)!       
        settings.style.buttonBarItemTitleColor = .gray
        
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0

        settings.style.selectedBarHeight = 3.0
        settings.style.selectedBarBackgroundColor = #colorLiteral(red: 0.09411764706, green: 0.6352941176, blue: 0.5098039216, alpha: 1)
        
        // Changing item text color on swipe
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .gray
            newCell?.label.textColor = #colorLiteral(red: 0.09411764706, green: 0.6352941176, blue: 0.5098039216, alpha: 1)
        }
    }
    
    // MARK: - PagerTabStripDataSource
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let child1 = UIStoryboard.init(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "Meetings") as! AfholdtTableViewController
        child1.SlidebtnName = "🚫 Ikke Afholdt"
        child1.done = false
        child1.userid = 0
        child1.getdata()
        
        let child2 = UIStoryboard.init(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "Meetings") as! AfholdtTableViewController
        child2.SlidebtnName = "✔ Afholdt"
        
        child2.done = true
        child2.userid = 0
        child2.getdata()
        
        return [child1, child2]
    }

}


