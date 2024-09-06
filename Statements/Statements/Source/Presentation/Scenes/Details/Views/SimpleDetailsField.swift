//
//  SimpleDetailsField.swift
//  Statements
//
//  Created by Yago Marques on 02/09/24.
//

import Foundation
import UIKit

public final class SimpleDetailsField: UIView {
    private let title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .textPrimary
        label.numberOfLines = 1
        label.textAlignment = .left
        
        return label
    }()
    
    private let value: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .textPrimary
        label.numberOfLines = 1
        label.textAlignment = .left
        
        return label
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        buildLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    func setupHierarchy() {
        addSubview(title)
        addSubview(value)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor),
            title.leadingAnchor.constraint(equalTo: leadingAnchor),
            title.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            value.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5),
            value.leadingAnchor.constraint(equalTo: leadingAnchor),
            value.trailingAnchor.constraint(equalTo: trailingAnchor),
            value.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func buildLayout() {
        setupHierarchy()
        setupConstraints()
    }
    
    func configure(title: String, value: String, isValueSecondary: Bool = false, isValueMultiline: Bool = false) {
        self.title.text = title
        self.value.text = value
        
        if isValueSecondary {
            self.value.font = .systemFont(ofSize: 14, weight: .regular)
            self.value.textColor = .textSecondary
        }
        
        if isValueMultiline {
            self.value.numberOfLines = 0
            self.value.lineBreakMode = .byWordWrapping
        }
    }
}
