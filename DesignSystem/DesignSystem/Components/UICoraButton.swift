//
//  UICoraButton.swift
//  DesignSystem
//
//  Created by Yago Marques on 02/09/24.
//

import Foundation
import SwiftUI

public struct SUICoraButton: View  {
    public var action: () -> Void
    public var title: String
    public var schema: CoraButtonSchema
    public var iconName: String
    @State private var isActive = true
    
    public init(title: String, schema: CoraButtonSchema, iconName: String, isActive: Bool, action: @escaping () -> Void) {
        self.action = action
        self.title = title
        self.schema = schema
        self.iconName = iconName
        self.isActive = isActive
    }
    
    public var body: some View {
        CoraButton(
            title: title,
            schema: schema,
            iconName: iconName,
            isActive: $isActive
        ) {
            action()
        }
    }
}
