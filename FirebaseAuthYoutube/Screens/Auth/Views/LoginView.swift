//
//  LoginView.swift
//  FirebaseAuthYoutube


import SwiftUI

struct LoginView: View {
   
    @State private var email:String="";
    @State private var password:String="";
    
    
    var body: some View {
        ScrollView{
            VStack{
                //logo
                Image("Login").resizable().scaledToFit()
                //title
                Text("Let's connect with US !").font(.title2).fontWeight(.semibold)
                //textFields
                TextField("Email or Phone Number", text: $email)
                SecureField("Password", text: $password)
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
