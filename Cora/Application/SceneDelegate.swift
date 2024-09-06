import UIKit
import Networking
import SwiftUI
import Login
import Coordinator
import Storage
import EnvironmentHelper
import Statements

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = .init(windowScene: windowScene)
        window?.makeKeyAndVisible()
        let coordinator = Coordinator()
        let rootView = rootView(with: coordinator)
        let navigationController = UINavigationController(rootViewController: rootView)
        coordinator.viewController = rootView
                
        setupNavigation()
        
        window?.rootViewController = navigationController
    }
    
    func rootView(with coordinator: Coordinating) -> UIViewController {
        if let logged = Defaults.shared.getItem(for: .logged) as? Bool, logged  {
            return StatementsFactory.make(with: coordinator)
        } else {
            return UIHostingController(rootView: LoginFactory.make(coordinator: coordinator))
        }
    }
    
    func setupNavigation() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "navigationBg")
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor(named: "navigationFontColor") ?? .black,
            .font: UIFont.systemFont(ofSize: 16, weight: .regular)
        ]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}

