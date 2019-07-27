//
//  ViewController.swift
//  Clock
//
//  Created by 강수빈 on 27/07/2019.
//  Copyright © 2019 SubinKang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let clock = Clock()

    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let form = DateFormatter()
        form.timeStyle = .short
        let stringDate = form.string(from: clock.date)
        
        timeLabel.text = stringDate
        
    }


}

