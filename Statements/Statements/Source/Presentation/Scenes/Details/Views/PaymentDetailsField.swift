//
//  PaymentDetailsField.swift
//  Statements
//
//  Created by Yago Marques on 02/09/24.
//

import Foundation
import UIKit

enum PaymentDetailsFieldType {
    case sender
    case recipient
}

public final class PaymentDetailsField: UIView {
    
    private let contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .textPrimary
        label.numberOfLines = 1
        label.textAlignment = .left
        
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .textPrimary
        label.numberOfLines = 1
        label.textAlignment = .left
        
        return label
    }()
    
    private let documentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .textSecondary
        label.numberOfLines = 1
        label.textAlignment = .left
        
        return label
    }()
    
    private let bankLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .textSecondary
        label.numberOfLines = 1
        label.textAlignment = .left
        
        return label
    }()
    
    private let bankInfoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .textSecondary
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
        addSubview(contentStack)
        
        contentStack.addArrangedSubview(typeLabel)
        contentStack.addArrangedSubview(nameLabel)
        contentStack.addArrangedSubview(documentLabel)
        contentStack.addArrangedSubview(bankLabel)
        contentStack.addArrangedSubview(bankInfoLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: topAnchor),
            contentStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func buildLayout() {
        setupHierarchy()
        setupConstraints()
    }
    
    func configure(type: PaymentDetailsFieldType, with model: BusinessPaymentDetail) {
        typeLabel.text = type == .recipient ? "Para" : "De"
        nameLabel.text = model.name
        documentLabel.text = "\(model.documentType.rawValue) \(model.documentNumber)"
        bankLabel.text = model.bankName
        bankInfoLabel.text = "Agência \(model.agencyNumber) - Conta \(model.accountNumber)"
    }
}
