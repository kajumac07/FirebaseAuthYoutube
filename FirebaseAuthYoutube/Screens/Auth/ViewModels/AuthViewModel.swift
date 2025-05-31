import Foundation
import FirebaseAuth
import FirebaseFirestore


@MainActor
final class AuthViewModel: ObservableObject{
    
    @Published var userSession: FirebaseAuth.User? //FirebaseUser
    @Published var currentUser:User? //My User
    @Published var isError:Bool = false;
     
    private let auth = Auth.auth();
    private let firestore = Firestore.firestore()
    
    init() {
        //
    }
    
    func loginUser(email:String, password:String) async{
        do{
           let authResult = try await auth.signIn(withEmail: email, password: password)
            userSession = authResult.user
            await fetchUserDetails(by: authResult.user.uid)
            print("Current User \(currentUser!)")
        } catch{
            isError = true;
        }
    }
    
    //create function for User
    func createUserAc(email:String, fullName:String, password:String) async{
        do{
            //authentication user entry
            let authResult = try await auth.createUser(withEmail: email, password: password)
            // store extra userDetails in firestore database
            await storeUserInFirestore(uid: authResult.user.uid, email: email, fullName: fullName)
        }catch{
            isError = true
        }
    }
    
    
    //store user data to firestore database
    func storeUserInFirestore (uid:String, email:String,fullName:String) async{
        let user = User(uid: uid, email: email, fullName: fullName)
        do{
            try firestore.collection("persons").document(uid).setData(from: user)
        } catch{
            isError = true
        }
    }
    
    //fetch UserDetails
    func fetchUserDetails(by uid:String) async{
        do{
            let document = try await firestore.collection("persons").document(uid).getDocument()
            currentUser = try document.data(as: User.self)
        }catch{
            isError = true
        }
        
    }
    
}
