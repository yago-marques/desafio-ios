import Foundation
import SwiftUI
import DesignSystem

public struct LoginView: View { 
    @StateObject var viewModel: LoginViewModel
    @State var registerButtonIsEnabled = true
    
    public var body: some View {
        VStack {
            Image(.bannerHero)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
            
            Group {
                Text("Conta Digital PJ")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 12)
                Text("Poderosamente simples")
                    .font(.title)
                    .fontWeight(.medium)
                Text("Sua empresa livre burocracias e de taxas para gerar boletos, fazer transferências e pagamentos.")
                    .font(.body)
                    .fontWeight(.regular)
                    .padding(.top, 8)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
            .foregroundStyle(.white)
            
            Spacer()
            
            CoraButton(
                title: "Quero fazer parte!",
                schema: .white,
                iconName: "arrow.forward",
                isActive: $registerButtonIsEnabled,
                action: {}
            )
            
            Button("Já sou cliente") {
                viewModel.openCpfPicker()
            }
            .bold()
            .tint(.white)
            .padding(.bottom, 60)
            
        }
        .navigationBarHidden(true)
        .ignoresSafeArea()
        .background(Color(.primaryPink))
        .overlay {
            VStack {
                HStack {
                    Image(.coraLogo)
                    Spacer()
                }
                Spacer()
            }
            .padding(.top, 60)
            .padding(.leading, 20)
        }
        .ignoresSafeArea()
    }
}
