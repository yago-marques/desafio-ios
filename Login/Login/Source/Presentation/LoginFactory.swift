import Foundation
import SwiftUI
import Coordinator
import Networking

public enum LoginFactory {
    public static func make(coordinator: Coordinating) -> some View {
        let useCases = LoginService(httpClient: Network())
        let loginCoordinator = LoginCoordinator(coordinator: coordinator)
        let viewModel = LoginViewModel(coordinator: loginCoordinator, useCases: useCases)
        return LoginView(viewModel: viewModel)
    }
}
