//
//  StatementDetailsFactory.swift
//  Statements
//
//  Created by Yago Marques on 06/09/24.
//

import Foundation
import Networking
import UIKit

public enum StatementDetailsFactory {
    public static func make(id: String) -> UIViewController {
        let useCases = StatementService(httpClient: Network())
        let viewModel = StatementDetailsViewModel(useCases: useCases, statementID: id)
        let viewController = StatementDetailsViewController(viewModel: viewModel)
        viewModel.viewController = viewController
        
        return viewController
    }
}
