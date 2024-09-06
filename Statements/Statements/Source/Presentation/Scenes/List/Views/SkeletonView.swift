//
//  StatementsSkeletonView.swift
//  Statements
//
//  Created by Yago Marques on 01/09/24.
//

import Foundation
import UIKit

class SkeletonComponent: UIView {
    public let gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        gradient.colors = [
            UIColor(white: 0.85, alpha: 1.0).cgColor,
            UIColor(white: 0.75, alpha: 1.0).cgColor,
            UIColor(white: 0.85, alpha: 1.0).cgColor
        ]
        gradient.locations = [0, 0.5, 1]
        return gradient
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        layer.addSublayer(gradientLayer)
        startAnimating()
    }

    private func startAnimating() {
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [0, 0.1, 0.2]
        animation.toValue = [0.8, 0.9, 1]
        animation.duration = 1.5
        animation.repeatCount = .infinity
        gradientLayer.add(animation, forKey: "skeletonAnimation")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}

public enum SkeletonViewComponent {
    case section(height: CGFloat, alpha: CGFloat)
    case item(percentWidthOfDevide: CGFloat, height: CGFloat, paddingLeft: CGFloat, radius: CGFloat, alpha: CGFloat)
    case spacer(value: CGFloat)
}

class SkeletonView: UIView {
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 10
        
        return stack
    }()

    func addSection(height: CGFloat, alpha: CGFloat) {
        let section = SkeletonComponent()
        section.alpha = alpha
        
        stack.addArrangedSubview(section)
        
        NSLayoutConstraint.activate([
            section.heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    func addSpacer(_ value: CGFloat) {
        let spacer = UIView()
        spacer.backgroundColor = .clear
        
        stack.addArrangedSubview(spacer)
        
        NSLayoutConstraint.activate([
            spacer.heightAnchor.constraint(equalToConstant: value)
        ])
    }
    
    func addItem(percentWidthOfDevide: CGFloat, height: CGFloat, paddingLeft: CGFloat, radius: CGFloat, alpha: CGFloat) {
        let spacerLeft = UIView()
        spacerLeft.backgroundColor = .clear
        
        let spacerRight = UIView()
        spacerRight.backgroundColor = .clear
        
        let title = SkeletonComponent()
        title.gradientLayer.cornerCurve = .circular
        title.gradientLayer.cornerRadius = radius
        title.alpha = alpha
        
        let titleStack = UIStackView(arrangedSubviews: [spacerLeft, title, spacerRight])
        titleStack.axis = .horizontal
        
        stack.addArrangedSubview(titleStack)
        
        NSLayoutConstraint.activate([
            spacerLeft.widthAnchor.constraint(equalToConstant: paddingLeft),
            title.heightAnchor.constraint(equalToConstant: height),
            title.widthAnchor.constraint(equalTo: widthAnchor, multiplier: percentWidthOfDevide)
        ])
    }
    
    func addEmptyView() {
        let view = UIView()
        view.backgroundColor = .clear
        stack.addArrangedSubview(view)
    }
    
    private let firstSection: SkeletonComponent = {
        let skeleton = SkeletonComponent()
        skeleton.translatesAutoresizingMaskIntoConstraints = false
        
        return skeleton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    public func configure(components: [SkeletonViewComponent]) {
        components.forEach { component in
            switch component {
            case .section(let height, let alpha):
                addSection(height: height, alpha: alpha)
            case .item(let percentWidthOfDevide, let height, let paddingLeft, let radius, let alpha):
                addItem(
                    percentWidthOfDevide: percentWidthOfDevide,
                    height: height,
                    paddingLeft: paddingLeft,
                    radius: radius,
                    alpha: alpha
                )
            case .spacer(let value):
                addSpacer(value)
            }
        }
        
        addEmptyView()
    }

    private func setupView() {
        addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}


extension SkeletonView {
    static func titleAndSubtitle() -> [SkeletonViewComponent] {
        [
            .item(
                percentWidthOfDevide: 0.7,
                height: 50,
                paddingLeft: 20,
                radius: 5,
                alpha: 0.5
            ),
            .item(
                percentWidthOfDevide: 0.5,
                height: 20,
                paddingLeft: 20,
                radius: 3,
                alpha: 0.5
            ),
            .spacer(value: 7),
        ]
    }
    
    static func titleAndSubtitle(repeat times: Int) -> [SkeletonViewComponent] {
        var skeleton: [SkeletonViewComponent] = []
        
        for _ in 1...times {
            skeleton += Self.titleAndSubtitle()
        }
        
        return skeleton
    }
    
    static func sectionWithTitleAndSubtitle(repeat times: Int) -> [SkeletonViewComponent] {
        var skeleton: [SkeletonViewComponent] = [
            .section(height: 40, alpha: 0.3),
            .spacer(value: 10),
        ]
        
        for _ in 1...times {
            skeleton += Self.titleAndSubtitle()
        }
        
        return skeleton
    }
}
