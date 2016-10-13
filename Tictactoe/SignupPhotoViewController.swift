
import UIKit
import Firebase


class SignupPhotoViewController: UIViewController, UIActionSheetDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnUpload_Click(sender: UIButton){
        
        let actionSheet=UIActionSheet()
        actionSheet.addButton(withTitle: "Cancel")
        actionSheet.addButton(withTitle: "Camera")
        actionSheet.addButton(withTitle: "Photo Library")
        actionSheet.cancelButtonIndex=0
        actionSheet.delegate = self
        actionSheet.show(in: self.view);
        
    }
    
    func actionSheet(actionSheet: UIActionSheet, didDismissWithButtonIndex buttonIndex: Int) {
        print("点击了："+actionSheet.buttonTitle(at: buttonIndex)!)
    }

    
    @IBAction func btnContinue_Click(sender: UIButton){
        
        
        
    }
    
    
}

