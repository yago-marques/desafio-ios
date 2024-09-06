//
//  UIView+.swift
//  Extensions
//
//  Created by Yago Marques on 04/09/24.
//

import Foundation
import SwiftUI

public extension View {
    func toViewController() -> UIViewController {
        UIHostingController(rootView: self)
    }
}
