//
//  WebViewController.swift
//  Project3
//
//  Created by Tommy Phan on 5/27/21.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var website: WKWebView!
    
    var webPage = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.website.load(URLRequest(url: URL(string: webPage)! as URL))
    }
    
    @IBAction func backButton(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
