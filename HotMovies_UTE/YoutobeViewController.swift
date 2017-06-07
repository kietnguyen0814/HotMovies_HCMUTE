//
//  YoutobeViewController.swift
//  HotMovies_UTE
//
//  Created by Cntt03 on 6/7/17.
//  Copyright © 2017 Kiet Nguyen. All rights reserved.
//

import UIKit

class YoutobeViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    var videoUrl: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(videoUrl)
        // Do any additional setup after loading the view.
        webView.loadHTMLString("<iframe width =\"\(webView.frame.width)\" height =\"\(webView.frame.height)\" src = \"\(videoUrl)\" frameborder=\"0\" allowfullscreen></iframe>", baseURL: nil)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
	
