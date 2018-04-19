//
//  ViewController.swift
//  XSExtension
//
//  Created by git on 04/10/2018.
//  Copyright (c) 2018 git. All rights reserved.
//

import UIKit
import XSExtension

class ViewController: UIViewController {
    
    lazy var button = UIButton(title: "hello world", target: self, action: #selector(ViewController.clickButton))
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 30)
        view.addSubview(button);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func clickButton() {
        button.showRedDot()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        button.hiddenRedDot()
    }
}

