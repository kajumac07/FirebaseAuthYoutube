//
//  InputView.swift
 

import SwiftUI

struct InputView: View {
    let placeholder:String
    var isSecuredField:Bool=false
    @Binding var text:String
    var body: some View {
        VStack(spacing:12){
            if isSecuredField{
                SecureField(placeholder, text: $text)
            } else{
                TextField(placeholder, text: $text)
            }
            Divider()
        }
    }
}

#Preview {
    InputView(placeholder: "Email or Phone Number", text: .constant(""))
}
