//
//  StatementFilterView.swift
//  Statements
//
//  Created by Yago Marques on 01/09/24.
//

import Foundation
import UIKit

public protocol StatementFilterViewDelegate: AnyObject {
    func filter(by entry: BusinessStatementEntry)
    func filterByFuture()
    func showAll()
}

public final class StatementFilterView: UIView {
    
    weak var delegate: StatementFilterViewDelegate?
    
    private lazy var options = [allOption, inOption, outOption, futureOption]
    
    private lazy var allOption: FilterOptionView = {
        let option = FilterOptionView()
        option.setup(label: "Tudo", isChecked: true)
        option.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(allOptionTapped)))
        option.handler = {
            self.delegate?.showAll()
        }
        
        return option
    }()
    
    private lazy var inOption: FilterOptionView = {
        let option = FilterOptionView()
        option.setup(label: "Entrada")
        option.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(inOptionTapped)))
        option.handler = {
            self.delegate?.filter(by: .credit)
        }
        
        return option
    }()
    
    private lazy var outOption: FilterOptionView = {
        let option = FilterOptionView()
        option.setup(label: "Saída")
        option.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(outOptionTapped)))
        option.handler = {
            self.delegate?.filter(by: .debit)
        }
        
        return option
    }()
    
    private lazy var futureOption: FilterOptionView = {
        let option = FilterOptionView()
        option.setup(label: "Futuro")
        option.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(futureOptionTapped)))
        option.handler = {
            self.delegate?.filterByFuture()
        }
        
        return option
    }()
    

    
    private lazy var optionsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [allOption, inOption, outOption, futureOption])
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    private let filterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "slider.horizontal.3"), for: .normal)
        button.tintColor = .coraPink
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func allOptionTapped() {
        optionTapped(allOption)
    }
    
    @objc func inOptionTapped() {
        optionTapped(inOption)
    }
    
    @objc func outOptionTapped() {
        optionTapped(outOption)
    }
    
    @objc func futureOptionTapped() {
        optionTapped(futureOption)
    }
    
    func optionTapped(_ option: FilterOptionView) {
        if !option.isChecked {
            options.forEach { $0.uncheck() }
            option.check()
        }
    }
    
    private func setupView() {
        addSubview(optionsStack)
        addSubview(filterButton)
        
        NSLayoutConstraint.activate([
            optionsStack.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            optionsStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            optionsStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            optionsStack.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),
            
            filterButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            filterButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
