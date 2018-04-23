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
    
    lazy var button = UIButton(title: "hello world", titleColor: UIColor.white, target: self, action: #selector(ViewController.clickButton))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 30)
        button.backgroundColor = UIColor.brown
        view.addSubview(button);
    }
    
    @objc func clickButton() {
        button.showRedDot()
        button.animationBeat()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        button.hiddenRedDot()
        button.animationShaker()
    }
}

