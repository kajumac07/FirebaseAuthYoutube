//
//  ContentView.swift
//  FirebaseAuthYoutube
//
//  Created by Atul Tiwari on 24/05/25.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    
    var body: some View {
        
        Group{
            if authViewModel.userSession == nil {
                LoginView()
            } else{
                HomeView()
            }
        }.environmentObject(authViewModel)
    }
}

#Preview {
    ContentView() 
}
