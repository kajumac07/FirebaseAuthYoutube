 

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var authViewModel : AuthViewModel
    
    var body: some View {
        VStack{
            Spacer()
            if let currentUser = authViewModel.currentUser{
                Text(currentUser.fullName)
            } else{
                ProgressView("Please Wait.. while we fetching your details")
            }
            Spacer()
            
            Button("Sign Out", action: {
                Task{
                    await authViewModel.UserLogout()
                }
                
            }
            
            )
        }
    }
}

#Preview {
    HomeView()
}
