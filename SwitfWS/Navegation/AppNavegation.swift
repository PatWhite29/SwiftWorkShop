//
//  AppNavegation.swift
//  SwitfWS
//
//  Created by gdaalumno on 02/12/24.
//

import SwiftUI

struct AppNavegation: View {
    @State var authViewModel = AuthViewModel()
    @State var projectViewModel = ProjectsViewModel()
    var body: some View {
        VStack {
            if self.authViewModel.user == nil {
                NavigationStack {
                Login(authViewModel: self.authViewModel)
                    .navigationTitle("Authentication")
                }
            } else {
                NavigationStack {
                    ProjectList(viewModel:
                                    self.projectViewModel)
                }
            }
        }
    }
}

#Preview {
    AppNavegation()
}
