//
//  CoraButton.swift
//  DesignSystem
//
//  Created by Yago Marques on 02/09/24.
//

import SwiftUI

public enum CoraButtonSchema {
    case white
    case pink
}

public struct CoraButton: View {
    var title: String
    var schema: CoraButtonSchema
    var iconName: String?
    @Binding var isActive: Bool
    var action: () -> Void
    
    public init(title: String, schema: CoraButtonSchema, iconName: String? = nil, isActive: Binding<Bool>, action: @escaping () -> Void) {
        self.title = title
        self.schema = schema
        self.iconName = iconName
        self._isActive = isActive
        self.action = action
    }
    
    public var body: some View {
        Button(action: {
            action()
        }) {
            HStack {
                Text(title)
                    .bold()
                    .foregroundStyle(schema == .white ? .primaryPink: .white)
                Spacer()
                Image(systemName: iconName ?? "")
                    .foregroundStyle(schema == .white ? .primaryPink : .white)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 25)
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(isActive ? schema == .pink ? .primaryPink: .white : .disabled)
            }
        }
        .disabled(!isActive)
        .padding(.horizontal, 20)
        .padding(.bottom, 25)
    }
}
