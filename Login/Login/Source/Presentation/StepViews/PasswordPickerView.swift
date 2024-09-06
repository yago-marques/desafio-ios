//
//  PasswordPickerView.swift
//  Login
//
//  Created by Yago Marques on 30/08/24.
//

import SwiftUI
import DesignSystem

struct PasswordPickerView: View {
    @ObservedObject var viewModel: LoginViewModel
    @FocusState private var isTextFieldFocused: Bool
    @State private var isHiddenPassword = true
    
    var body: some View {
        VStack {
            Text("Digite sua senha de acesso")
                .font(.title)
                .padding(.top, 30)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
            
            if isHiddenPassword {
                safeTextField
            } else {
                visibleTextField
            }
            
            Button("Esqueci minha senha") { }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(20)
            
            Spacer()
            
            CoraButton(
                title: "Próximo",
                schema: .pink,
                iconName: "arrow.forward",
                isActive: $viewModel.buttonPasswordPickerIsEnabled
            ) {
                Task {
                    await viewModel.login()
                }
            }
        }
        .alert("Erro no login", isPresented: $viewModel.showLoginErrorMessage, actions: {}, message: {
            Text("tente novamente mais tarde")
        })
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
    
    private var visibleTextField: some View {
        HStack {
            TextField(text: $viewModel.password) {
                Text("")
                    .padding()
            }
            .padding(.top, 20)
            .font(.title)
            .foregroundStyle(.textFieldValue)
            .focused($isTextFieldFocused)
            .onChange(of: viewModel.password) { newValue in
                viewModel.password = viewModel.formatPassword(newValue)
                viewModel.passwordFieldValidator()
            }
            
            Button(action: {isHiddenPassword.toggle()}, label: {
                Image(systemName: "eye.slash")
                    .foregroundStyle(.primaryPink)
                    .padding()
            })
            .padding(.top)
        }
        .padding(.horizontal, 20)
    }
    
    private var safeTextField: some View {
        HStack {
            SecureField(text: $viewModel.password) {
                Text("")
                    .padding()
            }
            .padding(.top, 20)
            .font(.title)
            .foregroundStyle(.textFieldValue)
            .focused($isTextFieldFocused)
            .onChange(of: viewModel.password) { newValue in
                viewModel.password = viewModel.formatPassword(newValue)
                viewModel.passwordFieldValidator()
            }
            
            Button(action: {isHiddenPassword.toggle()}, label: {
                Image(systemName: "eye")
                    .foregroundStyle(.primaryPink)
                    .padding()
            })
            .padding(.top)
        }
        .padding(.horizontal, 20)
    }
}
