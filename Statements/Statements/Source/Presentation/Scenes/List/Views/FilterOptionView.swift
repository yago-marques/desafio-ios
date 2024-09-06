//
//  FilterOptionView.swift
//  Statements
//
//  Created by Yago Marques on 01/09/24.
//

import Foundation
import UIKit

public final class FilterOptionView: UIView {
    public var isChecked = false
    public var handler: (() -> Void)?
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .textSecondary
        return label
    }()
    
    private let line: UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .clear
        
        return line
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        buildLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    func setup(label: String, isChecked: Bool = false) {
        self.label.text = label
        self.isChecked = isChecked
        if isChecked {
            check()
        }
    }
    
    func buildLayout() {
        setupHierarchy()
        setupConstraints()
    }
    
    func setupHierarchy() {
        addSubview(label)
        addSubview(line)
    }
    
    public func check() {
        isChecked = true
        label.textColor = .coraPink
        line.backgroundColor = .coraPink
        handler?()
    }
    
    public func uncheck() {
        isChecked = false
        label.textColor = .textSecondary
        line.backgroundColor = .clear
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            line.topAnchor.constraint(equalTo: label.bottomAnchor, constant: -4),
            line.leadingAnchor.constraint(equalTo: leadingAnchor),
            line.trailingAnchor.constraint(equalTo: trailingAnchor),
            line.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3)
            
        ])
    }
}
