import UIKit

protocol voteDelegate: class {
    func onVote()
}

class Slide: UIView {
    
    public var vote: Int = -1
    
    var delegate: voteDelegate?
    
    func onVote() {
        delegate?.onVote()
    }
    
    public var comment: String = ""

  //  @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelTitle: UITextView!
    //@IBOutlet weak var labelDesc: UITextView!
    
    @IBOutlet var scale: [UIButton]!
    
    @IBAction func scaleBtn(_ sender: UIButton) {
        for item in scale {
            item.alpha = 0.6
        }
        sender.alpha = 1
        vote = Int(sender.restorationIdentifier!)!
        onVote()
    }
    
    @IBOutlet weak var commentField: UITextField!{
        didSet{
            comment = commentField.text!
        }
    }

}
