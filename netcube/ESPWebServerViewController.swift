//
//  ESPWebServerViewController.swift
//  netcube
//
//  Created by fran on 4/3/17.
//  Copyright © 2017 Francisco Navarro Aguilar. All rights reserved.
//

import UIKit

class ESPWebServerViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    let urlString: String!
    
    init(url: String) {
        self.urlString = "http://" + url
        super.init(nibName: nil, bundle: nil)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Conexión"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let request = URLRequest(url: URL(string: urlString)!)
        self.webView.loadRequest(request)
        
    }


}
