import UIKit

class FeedbackViewController: UIViewController, UIScrollViewDelegate, voteDelegate {
    
    func onVote() {
        if(slides[pageControl.currentPage].vote == -1){
            scrollView.isScrollEnabled = false
            nextBtnlabel.isEnabled = false
        }else{
            scrollView.isScrollEnabled = true
            nextBtnlabel.isEnabled = true
        }
    }
    
    var currentPage: Int = 0{
        didSet(oldVal){
            if(currentPage > oldVal || slides[currentPage].vote == -1){
                scrollView.isScrollEnabled = false;
                nextBtnlabel.isEnabled = false;
            }else{
                scrollView.isScrollEnabled = true;
                nextBtnlabel.isEnabled = true;
            }
        }
        
    }
    
    @IBOutlet weak var nextBtnlabel: UIButton!
    @IBOutlet weak var backBtnlabel: UIButton!
    @IBAction func backBtn(_ sender: UIButton) {
            scrollToPage(page: pageControl.currentPage-1, animated: true)
    }
    @IBAction func nextBtn(_ sender: UIButton) {
        if(pageControl.currentPage+1 != slides.count){
            scrollToPage(page: pageControl.currentPage+1, animated: true)
        }else{
            print("pack feedback")
            packFeedback()
            let vc: FeedbackDoneViewController = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "feedbackDone") as! FeedbackDoneViewController
            self.present(vc, animated: true, completion: nil)
        }
    }
    @IBOutlet weak var numberlabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!{
        didSet{
            scrollView.delegate = self
        }
    }
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    var slides:[Slide] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slides = createSlides()
        setupSlideScrollView(slides: slides)
        
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        
        view.bringSubviewToFront(pageControl)
        
        backBtnlabel.isHidden = true
        nextBtnlabel.isEnabled = false
        numberlabel.text = "\(1) af \(slides.count)"
        
        for slide in slides {
            slide.delegate = self
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func scrollToPage(page: Int, animated: Bool) {
        var frame: CGRect = self.scrollView.frame
        frame.origin.x = frame.size.width * CGFloat(page)
        frame.origin.y = 0
        self.scrollView.scrollRectToVisible(frame, animated: animated)
    }
    
    func packFeedback(){
        var answers: [FeedbackDTO] = []
        for slide in slides {
            let feedback = FeedbackDTO()
            feedback.comment = slide.comment
            feedback.feedback = slide.vote
            answers.append(feedback)
        }
        
        print(answers)
    }

    
    func createSlides() -> [Slide] {

        let slide1:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
//        slide1.imageView.image = UIImage(named: "ic_onboarding_1")
        slide1.labelTitle.text = "Spørgsmål 1"
        //slide1.labelDesc.text = "Did you know that Winnie the chubby little cubby was based on a real, young bear in London"
        
        let slide2:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
    //    slide2.imageView.image = UIImage(named: "ic_onboarding_2")
        slide2.labelTitle.text = "Spørgsmål 2"
       // slide2.labelDesc.text = "Did you know that Winnie the chubby little cubby was based on a real, young bear in London"
        
        let slide3:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
   //     slide3.imageView.image = UIImage(named: "ic_onboarding_3")
        slide3.labelTitle.text = "Spørgsmål 3"
       // slide3.labelDesc.text = "Did you know that Winnie the chubby little cubby was based on a real, young bear in London"
        
        let slide4:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
   //     slide4.imageView.image = UIImage(named: "ic_onboarding_4")
        slide4.labelTitle.text = "Spørgsmål 4"
      //  slide4.labelDesc.text = "Did you know that Winnie the chubby little cubby was based on a real, young bear in London"
        
        
        let slide5:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
    //    slide5.imageView.image = UIImage(named: "ic_onboarding_5")
        slide5.labelTitle.text = "Spørgsmål 5"
      //  slide5.labelDesc.text = "Did you know that Winnie the chubby little cubby was based on a real, young bear in London"
        
        return [slide1, slide2, slide3, slide4, slide5]
    }
    
    
    func setupSlideScrollView(slides : [Slide]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        scrollView.isPagingEnabled = true
        scrollView.isScrollEnabled = false;
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(slides[i])
        }
    }
    
    
    /*
     * default function called when view is scolled. In order to enable callback
     * when scrollview is scrolled, the below code needs to be called:
     * slideScrollView.delegate = self or
     */
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
        
        currentPage = pageControl.currentPage
       // currentPage = pageControl.currentPage
        
        let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
        let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x
        
        // vertical
        let maximumVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
        let currentVerticalOffset: CGFloat = scrollView.contentOffset.y
        
        let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
        let percentageVerticalOffset: CGFloat = currentVerticalOffset / maximumVerticalOffset
        
        if scrollView.contentOffset.y != 0 {
            scrollView.contentOffset.y = 0
        }
        
        numberlabel.text = "\(Int(pageIndex)+1) af \(slides.count)"
        if(Int(pageIndex)+1 == slides.count){
            nextBtnlabel.setTitle("Afslut feedback", for: .normal)
        }else {
             nextBtnlabel.setTitle("Næste", for: .normal)
        }
        
        if(Int(pageIndex) == 0){
            backBtnlabel.isHidden = true;
        }else {
             backBtnlabel.isHidden = false;
        }
        
        
        
        /*
         * below code changes the background color of view on paging the scrollview
         */
//        self.scrollView(scrollView, didScrollToPercentageOffset: percentageHorizontalOffset)
        
    
        /*
         * below code scales the imageview on paging the scrollview
         */
        let percentOffset: CGPoint = CGPoint(x: percentageHorizontalOffset, y: percentageVerticalOffset)
        
        if(percentOffset.x > 0 && percentOffset.x <= 0.25) {
            /*
            slides[0].imageView.transform = CGAffineTransform(scaleX: (0.25-percentOffset.x)/0.25, y: (0.25-percentOffset.x)/0.25)
            slides[1].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.25, y: percentOffset.x/0.25)
            
        } else if(percentOffset.x > 0.25 && percentOffset.x <= 0.50) {
            slides[1].imageView.transform = CGAffineTransform(scaleX: (0.50-percentOffset.x)/0.25, y: (0.50-percentOffset.x)/0.25)
            slides[2].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.50, y: percentOffset.x/0.50)
            
        } else if(percentOffset.x > 0.50 && percentOffset.x <= 0.75) {
            slides[2].imageView.transform = CGAffineTransform(scaleX: (0.75-percentOffset.x)/0.25, y: (0.75-percentOffset.x)/0.25)
            slides[3].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.75, y: percentOffset.x/0.75)
            
        } else if(percentOffset.x > 0.75 && percentOffset.x <= 1) {
            slides[3].imageView.transform = CGAffineTransform(scaleX: (1-percentOffset.x)/0.25, y: (1-percentOffset.x)/0.25)
            slides[4].imageView.transform = CGAffineTransform(scaleX: percentOffset.x, y: percentOffset.x)*/
        }
 
    }
    
    
    
    
    func scrollView(_ scrollView: UIScrollView, didScrollToPercentageOffset percentageHorizontalOffset: CGFloat) {
        if(pageControl.currentPage == 0) {
            //Change background color to toRed: 103/255, fromGreen: 58/255, fromBlue: 183/255, fromAlpha: 1
            //Change pageControl selected color to toRed: 103/255, toGreen: 58/255, toBlue: 183/255, fromAlpha: 0.2
            //Change pageControl unselected color to toRed: 255/255, toGreen: 255/255, toBlue: 255/255, fromAlpha: 1
            
            
            
            let pageUnselectedColor: UIColor = fade(fromRed: 255/255, fromGreen: 255/255, fromBlue: 255/255, fromAlpha: 1, toRed: 103/255, toGreen: 58/255, toBlue: 183/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
            pageControl.pageIndicatorTintColor = pageUnselectedColor
        
            
            let bgColor: UIColor = fade(fromRed: 103/255, fromGreen: 58/255, fromBlue: 183/255, fromAlpha: 1, toRed: 255/255, toGreen: 255/255, toBlue: 255/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
            slides[pageControl.currentPage].backgroundColor = bgColor
            
            let pageSelectedColor: UIColor = fade(fromRed: 81/255, fromGreen: 36/255, fromBlue: 152/255, fromAlpha: 1, toRed: 103/255, toGreen: 58/255, toBlue: 183/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
            pageControl.currentPageIndicatorTintColor = pageSelectedColor
        }
    }
    
    
    func fade(fromRed: CGFloat,
              fromGreen: CGFloat,
              fromBlue: CGFloat,
              fromAlpha: CGFloat,
              toRed: CGFloat,
              toGreen: CGFloat,
              toBlue: CGFloat,
              toAlpha: CGFloat,
              withPercentage percentage: CGFloat) -> UIColor {
        
        let red: CGFloat = (toRed - fromRed) * percentage + fromRed
        let green: CGFloat = (toGreen - fromGreen) * percentage + fromGreen
        let blue: CGFloat = (toBlue - fromBlue) * percentage + fromBlue
        let alpha: CGFloat = (toAlpha - fromAlpha) * percentage + fromAlpha
        
        // return the fade colour
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
