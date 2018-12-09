//
//  CustomTableViewCell.swift
//  MoodTrackerProg
//
//  Created by Kandice McGhee on 11/25/18.
//  Copyright © 2018 Kandice McGhee. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        accessoryType = .disclosureIndicator
        setupLayout()
    }
    let imageViewMoodColor = UIImageView()
    
    
    func setupLayout(){
        
        imageViewMoodColor.translatesAutoresizingMaskIntoConstraints = false
        
        detailTextLabel?.textColor = .lightGray
        
        addSubview(imageViewMoodColor)
        
        NSLayoutConstraint.activate([
            imageViewMoodColor.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageViewMoodColor.topAnchor.constraint(equalTo: topAnchor),
            imageViewMoodColor.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageViewMoodColor.trailingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            imageViewMoodColor.widthAnchor.constraint(equalToConstant: 12)
            ])
    }
    
    func configure(_ entry: MoodEntry){
        imageViewMoodColor.backgroundColor = entry.mood.colorValue
        textLabel?.text = entry.mood.stringValue
        detailTextLabel?.text = entry.date.stringValue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
