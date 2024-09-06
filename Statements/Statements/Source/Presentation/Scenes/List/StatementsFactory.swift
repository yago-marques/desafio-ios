//
//  StatementsFactory.swift
//  Statements
//
//  Created by Yago Marques on 06/09/24.
//

import Foundation
import Coordinator
import UIKit
import Networking

public enum StatementsFactory {
    public static func make(with coordinator: Coordinating) -> UIViewController {
        let coordinator = StatementsCoordinator(coordinator: coordinator)
        let useCases = StatementService(httpClient: Network())
        let viewModel = StatementsViewModel(useCases: useCases, coordinator: coordinator)
        let viewController = StatementsViewController(viewModel: viewModel)
        viewModel.viewController = viewController
        
        return viewController
    }
}
