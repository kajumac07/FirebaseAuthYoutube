//
//  LoginView.swift
//  FirebaseAuthYoutube


import SwiftUI

struct LoginView: View {
   
    @State private var email:String="";
    @State private var password:String="";
    
    
    var body: some View {
        ScrollView{
            VStack(spacing:16){
                //logo
                //title
                Text("Let's connect with US !").font(.title2).fontWeight(.semibold)
                Spacer().frame(height: 16 )
                //textFields
                InputView(placeholder: "Email or Phone Number", text: $email)
                InputView(placeholder: "Password", isSecuredField: true, text: $password)
                HStack{
                    Spacer()
                    Button{
                        
                    } label:
                    {
                        Text("Forgot Password?").foregroundStyle(.gray).font(.subheadline).fontWeight(.medium)
                    }
                }
               
                //forgot button
                //login button
                //bottom view
                //apple login
                //google login
                //footer
                
            }
        }.ignoresSafeArea().padding(.horizontal).padding(.vertical,8 )
    }
}

#Preview {
    LoginView()
}
