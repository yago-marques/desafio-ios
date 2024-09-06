import Foundation
import UIKit
import SwiftUI

public final class Coordinator: Coordinating {
    public var viewController: UIViewController?
    
    public init(viewController: UIViewController? = nil) {
        self.viewController = viewController
    }
    
    public func pop() {
        guard let navigationController = self.viewController?.navigationController else {
            return
        }
        
        navigationController.popViewController(animated: true)
    }
    
    public func send(_ actions: CoordinatorActions) {
        guard let navigationController = self.viewController?.navigationController else {
            return
        }
        
        switch actions {
        case .push(let uIViewController):
            navigationController.pushViewController(uIViewController, animated: true)
        case .pop:
            navigationController.popViewController(animated: true)
        }
    }
}
