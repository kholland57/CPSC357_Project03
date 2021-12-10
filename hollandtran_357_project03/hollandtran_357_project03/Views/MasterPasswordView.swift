//
//  MasterPasswordView.swift
//  hollandtran_357_project03
//
//  Created by Kelsey Holland on 3/20/21.
//

import SwiftUI

//This asks the user to create a new master password if there isn't one
//If there is one, it asks the user to input it. If guessed correctly, ContentView will access the main menu view.
struct MasterPasswordView: View {
    @State var words = StorageHandler.getStorage()
    @State private var masterPWSInput: String = ""
    @State private var wrongPassword = false
    @State private var setNewPassword = false
    @Binding var signIn : Bool
    
    
     
    var body: some View {
        let masterPassword = StorageHandler.getValue(dictionary: words, key: "master")
             VStack(alignment: .center){
                Text("Welcome")
                    .font(.title)
                    .fontWeight(.medium)
                    
                Image(systemName: "book.circle")
                    .padding()
                    .font(.system(size: 40))
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                  
                //If the user has not entered a master password yet, then allow the user to create a new one
                if masterPassword == "" || masterPassword == nil{
                    TextField("Enter New Master Password", text: $masterPWSInput)
                        .multilineTextAlignment(.center)
                        
                    Button(action: {
                        words.updateValue(masterPWSInput, forKey : "master")
                        StorageHandler.setStorage(input : words)
                        self.signIn = true
                        },
                        label: {
                            Text("Enter")
                                .padding(.horizontal, 5)
                                .padding(.vertical, 5)
                                .border(Color.black, width: 1)
                                .foregroundColor(.black)
                    })
                    
                }
                //if the master password exists, then ask the user for the master password
                else{
                    let masterPassword = StorageHandler.getValue(dictionary: words, key: "master")
                    TextField("Enter the Master Password", text: $masterPWSInput)
                        .multilineTextAlignment(.center)
                        .padding()
                    Button(action: {
                        if ((masterPWSInput == masterPassword)){
                            self.signIn = true //invokes main menu
                            }
                        else{
                            wrongPassword.toggle() //invokes wrongpassword alert
                        }
                        },
                        label: {
                            Text("Enter")
                                .padding(.horizontal, 5)
                                .padding(.vertical, 5)
                                .border(Color.black, width: 1)
                                .foregroundColor(.black)
                    })
                    //Alerts the user that the password is wrong
                    .alert(isPresented: $wrongPassword){
                        Alert(
                            title: Text("Wrong Password"),
                            message: Text(""),
                            primaryButton: .default(Text("Try Again")),
                            secondaryButton: .cancel()
                        )
                    }
                }
             }
    }
    
}
     
 












