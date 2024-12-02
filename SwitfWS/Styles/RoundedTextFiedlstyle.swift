//
//  RoundedTextFiedlstyle.swift
//  SwitfWS
//
//  Created by gdaalumno on 02/12/24.
//

import SwiftUI

struct RoundedTextFiedlstyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        return configuration
            .padding(16)
            .background(
                Color(uiColor: .secondarySystemBackground),
                in: RoundedRectangle(cornerRadius: 10)
            )
    }
}
