import SwiftUI
import Firebase
import GoogleSignIn

struct SignUpView : View {
    
    @State var email: String = ""
    @State var password: String = ""
    @State var loading = false
    @State var error = false
    
    @EnvironmentObject var session: SessionStore

    @State private var complete: Bool = false

    func signUp () {
        print("sign me up")
        loading = true
        error = false
        session.signUp(email: email, password: password) { (result, error) in
            self.loading = false
            if error != nil {
                self.error = true
                self.complete = false
            } else {
                self.email = ""
                self.password = ""
            }
        }
    }
    func signInWithGoogle(){
        session.signInWithGoogle()
    }
    func getUser () {
        session.listen()
    }
    var body : some View {
        NavigationView{
            ZStack{
                Color("Primary")
                    .edgesIgnoringSafeArea(.all)
                
                
                VStack {
                    Text("Caffy")
                        .multilineTextAlignment(.center)
                        .font(Font.custom("GT Eesti Pro Text", size: 96))
                        .foregroundColor(.white)
                        .padding(.bottom, 100.0)
                    
                    TextField("Email", text: $email)
                        .padding(.horizontal, CGFloat(90))
                        .foregroundColor(Color("Charcoal"))
                        .multilineTextAlignment(.center)
                        .font(Font.custom("GT Eesti Pro Text", size: 20))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    SecureField("Password", text: $password)
                        .padding(.horizontal, CGFloat(90))
                        .foregroundColor(Color("Charcoal"))
                        .multilineTextAlignment(.center)
                        .font(Font.custom("GT Eesti Pro Text", size: 20))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.bottom, CGFloat(10))
                    
                    if (error) {
                        Text("Error signing up")
                            .font(Font.custom("GT Eesti Pro Text", size: 20))
                            .foregroundColor(.white)
                            .padding(.bottom, CGFloat(10))
                        
                    }
                    if complete == true {
                        Text("Success")
                            .font(Font.custom("GT Eesti Pro Text", size: 20))
                            .foregroundColor(.white)
                            .padding(.bottom, CGFloat(10))
                        
                        
                    }
                    Button(action: {
                        self.signUp()
                        self.complete = true

                    }){
                        
                        Text("SIGN UP")
                            .padding(.horizontal, CGFloat(70))
                            .padding(.vertical, CGFloat(5))
                            .background(Color("Charcoal"))
                            .cornerRadius(40)
                            .foregroundColor(.white)
                            .font(Font.custom("GT Eesti Pro Text", size: 30))
                            .padding(.bottom, CGFloat(30))
                        
                    }
                  


                    
                }
            }.onAppear(perform: getUser)
        }
    }
    
    
}
