//
//  StatementDetailsSkeleton.swift
//  Statements
//
//  Created by Yago Marques on 02/09/24.
//

import Foundation
import UIKit

public final class StatementDetailsSkeleton: UIView {
    private let skeletonView: SkeletonView = {
        let skeleton = SkeletonView()
        skeleton.translatesAutoresizingMaskIntoConstraints = false
        let customSectionItem: [SkeletonViewComponent] = [
            .spacer(value: 30),
            .item(
                percentWidthOfDevide: 0.8,
                height: 30,
                paddingLeft: 20,
                radius: 5,
                alpha: 0.5
            ),
            .spacer(value: 10)
        ]
        
        skeleton.configure(components: customSectionItem + SkeletonView.titleAndSubtitle(repeat: 5))
        
        return skeleton
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSkeleton()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    func addSkeleton() {
        addSubview(skeletonView)
        
        NSLayoutConstraint.activate([
            skeletonView.topAnchor.constraint(equalTo: topAnchor),
            skeletonView.leadingAnchor.constraint(equalTo: leadingAnchor),
            skeletonView.trailingAnchor.constraint(equalTo: trailingAnchor),
            skeletonView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
