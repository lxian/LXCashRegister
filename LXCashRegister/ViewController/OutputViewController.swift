//
//  OutputViewController.swift
//  LXCashRegister
//
//  Created by XianLi on 10/3/2016.
//  Copyright © 2016 LXIAN. All rights reserved.
//

import UIKit

class OutputViewController: UIViewController {
    
    var outputString: String? {
        didSet {
            if isViewLoaded() {
                outputTextView.text = self.outputString
            }
        }
    }
    @IBOutlet weak var outputTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        outputTextView.text = self.outputString
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
