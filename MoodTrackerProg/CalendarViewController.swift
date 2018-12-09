//
//  CalendarViewController.swift
//  MoodTrackerProg
//
//  Created by Kandice McGhee on 11/25/18.
//  Copyright © 2018 Kandice McGhee. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .cyan
        setupButton()
    }
    
    let doneButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Done", for: .normal)
        button.addTarget(self, action: #selector(pressDone), for: .touchUpInside)
        return button
    }()

    @objc func pressDone(){
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func setupButton(){
        view.addSubview(doneButton)
        
        NSLayoutConstraint.activate([
        doneButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        doneButton.heightAnchor.constraint(equalToConstant: 32),
        doneButton.widthAnchor.constraint(equalToConstant: 62)
            ])
    }
}

