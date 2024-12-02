//
//  AppNavegation.swift
//  SwitfWS
//
//  Created by gdaalumno on 02/12/24.
//

import SwiftUI

struct AppNavegation: View {
    var body: some View {
        NavigationStack {
            Login()
                .navigationTitle("Authentication")
        }
    }
}

#Preview {
    AppNavegation()
}
