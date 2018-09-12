//
//  SecondViewController.swift
//  TableView2
//
//  Created by Macbook on 10/09/18.
//  Copyright © 2018 iosLab. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    @IBOutlet weak var etiqueta: UILabel!
    var fromFirstView : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(fromFirstView)
        etiqueta.text = fromFirstView

        // Do any additional setup after loading the view.
    }

    
}
