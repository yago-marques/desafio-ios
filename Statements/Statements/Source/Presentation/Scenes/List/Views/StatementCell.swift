//
//  StatementCell.swift
//  Statements
//
//  Created by Yago Marques on 01/09/24.
//

import Foundation
import UIKit

public final class StatementCell: UITableViewCell {
    static let identifier = "StatementCell"
    
    private lazy var content = [icon, textStack, hourLabel]
        
    private let icon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .textPrimary
        
        return imageView
    }()
    
    private let textStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .textPrimary
        
        return label
    }()
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .textPrimary
        
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .textSecondary
        
        return label
    }()
    
    private let hourLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .textSecondary
        
        return label
    }()
    
    func setupHierarchy() {
        addSubview(icon)
        addSubview(textStack)
        textStack.addArrangedSubview(amountLabel)
        textStack.addArrangedSubview(typeLabel)
        textStack.addArrangedSubview(nameLabel)
        addSubview(hourLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            icon.topAnchor.constraint(equalTo: topAnchor, constant: 25),
            icon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            icon.widthAnchor.constraint(equalToConstant: 24),
            icon.heightAnchor.constraint(equalToConstant: 24),
            
            textStack.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 20),
            textStack.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.68),
            textStack.topAnchor.constraint(equalTo: icon.topAnchor),
            textStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            
            hourLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            hourLabel.leadingAnchor.constraint(equalTo: textStack.trailingAnchor, constant: 5)
        ])
    }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    func setup(with model: BusinessStatement) {
        setupHierarchy()
        setupConstraints()
        self.selectionStyle = .none
                
        amountLabel.textColor = .textPrimary
        typeLabel.textColor = .textPrimary
        
        amountLabel.text = model.amount
        typeLabel.text = model.description
        nameLabel.text = model.name
        hourLabel.text = model.dateEvent
        
        switch model.type {
        case .debit:
            icon.image = .debit
        case .credit:
            icon.image = .credit
            amountLabel.textColor = .coraBlue
            typeLabel.textColor = .coraBlue
        case .none:
            icon.image = .init(systemName: "square")
        }
    }
}
