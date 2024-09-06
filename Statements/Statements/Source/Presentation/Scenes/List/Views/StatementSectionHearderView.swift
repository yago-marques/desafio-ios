//
//  StatementSectionHearderView.swift
//  Statements
//
//  Created by Yago Marques on 01/09/24.
//

import Foundation
import UIKit

public class StatementSectionHearderView: UIView {
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .textSecondary
        label.font = .systemFont(ofSize: 14, weight: .light)
        
        return label
    }()
    
    func setup(with dateString: String) {
        dateLabel.text = dateString
        self.backgroundColor = .headerBg
        
        self.addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
}
