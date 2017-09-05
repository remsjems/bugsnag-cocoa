import UIKit

class ViewController: UIViewController {

    @IBAction func doCrash(_ sender: AnyObject) {
        AnotherClass().crash()
    }
}
