//
//  StatementsSkeleton.swift
//  Statements
//
//  Created by Yago Marques on 02/09/24.
//

import Foundation
import UIKit

public final class StatementsSkeleton: UIView {
    private let skeletonView: SkeletonView = {
        let skeleton = SkeletonView()
        skeleton.translatesAutoresizingMaskIntoConstraints = false
        skeleton.configure(
            components: SkeletonView.sectionWithTitleAndSubtitle(repeat: 4) + SkeletonView.sectionWithTitleAndSubtitle(repeat: 1)
        )
        
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
