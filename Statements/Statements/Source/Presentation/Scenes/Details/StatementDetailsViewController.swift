//
//  StatementDetailsViewController.swift
//  Statements
//
//  Created by Yago Marques on 02/09/24.
//

import Foundation
import UIKit
import Networking
import DesignSystem
import SwiftUI
import Extensions

public protocol StatementDetailsViewControllerDisplay: AnyObject {
    func showSkeleton()
    func hideSkeleton()
    func configure(with: BusinessStatementDetails)
    func showErrorAlert()
}

public final class StatementDetailsViewController: UIViewController {
    private let viewModel: StatementDetailsViewModeling
    
    private let contentStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 30
        stack.alignment = .fill
        stack.distribution = .fill
        
        return stack
    }()
    
    private let contentScrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.alwaysBounceVertical = true
        scroll.translatesAutoresizingMaskIntoConstraints = false
        
        return scroll
    }()
    
    private let amountField: SimpleDetailsField = {
        let field = SimpleDetailsField()
        
        return field
    }()
    
    private let dateField: SimpleDetailsField = {
        let field = SimpleDetailsField()
        
        return field
    }()
    
    private let fromPaymentField: PaymentDetailsField = {
        let field = PaymentDetailsField()
        
        return field
    }()
    
    
    private let toPaymentField: PaymentDetailsField = {
        let field = PaymentDetailsField()
        
        return field
    }()
    
    private let descriptionField: SimpleDetailsField = {
        let field = SimpleDetailsField()
        
        return field
    }()
    
    private let skeletonView: StatementDetailsSkeleton = {
        let skeleton = StatementDetailsSkeleton()
        skeleton.translatesAutoresizingMaskIntoConstraints = false
        skeleton.isHidden = true
        
        return skeleton
    }()
    
    private let shareButton: UIView = {
        let button = SUICoraButton(
            title: "Compartilhar comprovante",
            schema: .pink,
            iconName: "square.and.arrow.up",
            isActive: true,
            action: {}
        )
        let hosting = UIHostingController(rootView: button)
        guard let view = hosting.view else { return UIView() }
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    public init(viewModel: StatementDetailsViewModeling) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
        
        viewModel.fetchDetails()
    }
    
    func setupView() {
        view.backgroundColor = .white
        self.title = "Detalhes da transferência"
        let barButton = UIBarButtonItem()
        barButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = barButton
    }
    
    func setupHierarchy() {
        view.addSubview(contentScrollView)
        
        contentScrollView.addSubview(contentStack)
        
        contentStack.addArrangedSubview(amountField)
        contentStack.addArrangedSubview(dateField)
        contentStack.addArrangedSubview(fromPaymentField)
        contentStack.addArrangedSubview(toPaymentField)
        contentStack.addArrangedSubview(descriptionField)
        contentStack.addArrangedSubview(UIView())
        
        view.addSubview(shareButton)
        view.addSubview(skeletonView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            shareButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            shareButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            shareButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentScrollView.bottomAnchor.constraint(equalTo: shareButton.topAnchor),
            
            contentStack.topAnchor.constraint(equalTo: contentScrollView.topAnchor, constant: 35),
            contentStack.leadingAnchor.constraint(equalTo: contentScrollView.leadingAnchor, constant: 25),
            contentStack.trailingAnchor.constraint(equalTo: contentScrollView.trailingAnchor, constant: -25),
            contentStack.bottomAnchor.constraint(equalTo: contentScrollView.bottomAnchor),
            contentStack.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor, constant: -50),
            
            skeletonView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            skeletonView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            skeletonView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            skeletonView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func buildLayout() {
        setupView()
        setupHierarchy()
        setupConstraints()
    }
}

extension StatementDetailsViewController: StatementDetailsViewControllerDisplay {
    public func showErrorAlert() {
        DispatchQueue.main.async { [weak self] in
            self?.showAlert(title: "Aconreceu um erro", description: "tente novamente mais tarde")
        }
    }
    
    public func showSkeleton() {
        DispatchQueue.main.async { [weak self] in
            self?.contentScrollView.isHidden = true
            self?.shareButton.isHidden = true
            self?.skeletonView.isHidden = false
        }
    }
    
    public func hideSkeleton() {
        DispatchQueue.main.async { [weak self] in
            self?.contentScrollView.isHidden = false
            self?.shareButton.isHidden = false
            self?.skeletonView.isHidden = true
        }
    }
    
    public func configure(with model: BusinessStatementDetails) {
        DispatchQueue.main.async {
            self.amountField.configure(title: "Valor", value: model.amount)
            self.dateField.configure(title: "Data", value: model.dateEvent)
            self.fromPaymentField.configure(type: .sender, with: model.sender)
            self.toPaymentField.configure(type: .recipient, with: model.recipient)
            self.descriptionField.configure(
                title: "Descrição",
                value: model.description,
                isValueSecondary: true,
                isValueMultiline: true
            )
        }
    }
}
