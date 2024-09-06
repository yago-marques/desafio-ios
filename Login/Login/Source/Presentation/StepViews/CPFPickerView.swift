import SwiftUI
import DesignSystem

struct CPFPickerView: View {
    
    @ObservedObject var viewModel: LoginViewModel
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        VStack {
            Group {
                Text("Bem-vindo de volta!")
                    .font(.body)
                    .padding(.top, 30)
                Text("Qual seu CPF?")
                    .font(.title)
                    .padding(.top, 8)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
            
            TextField(text: $viewModel.cpf) {
                Text("")
                    .padding()
            }
            .padding(.top, 20)
            .keyboardType(.decimalPad)
            .font(.title)
            .foregroundStyle(.textFieldValue)
            .padding(.horizontal, 20)
            .focused($isTextFieldFocused)
            .onChange(of: viewModel.cpf) { newValue in
                viewModel.cpf = viewModel.formatCPF(newValue)
                viewModel.cpfFieldValidator()
            }
            
            Spacer()
            
            CoraButton(
                title: "Próximo",
                schema: .pink,
                iconName: "arrow.forward",
                isActive: $viewModel.buttonCPFPickerIsEnabled
            ) {
                viewModel.openPasswordPicker()
            }
        }
        .navigationBarHidden(false)
        .navigationTitle("Login Cora")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            viewModel.pop()
        }) {
            Image(systemName: "chevron.backward")
        })
        .onAppear {
            isTextFieldFocused = true
        }
    }
}
