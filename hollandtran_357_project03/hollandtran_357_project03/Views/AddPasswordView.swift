//
//  PasswordsView.swift
//  hollandtran_357_project03
//
//  Created by Kelsey Holland and James Tran on 3/16/21.
//

import SwiftUI


//This View has a textfeild where the user enters a new key and password. If the strings are not empty, the storage
//handler adds the new password to the storage dictionary and encrypts it.
struct AddPasswordView: View {
    
    @Binding var words :  Dictionary<String , String>
    
    @State private var keyString: String = ""
    @State private var passwordString: String = ""
    @State private var showingDetail = false
    
    var body: some View {
        
            VStack{
                
            
                Text("Add A New Password")
                    .font(.title)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.leading)
                    .padding()
                
                TextField("Enter a Key", text: $keyString)
                    .padding()
                
                
                TextField("Enter a Password", text: $passwordString)
                    .padding()
            
                
                
                //Adds a password to the local dictionary and updates the Storage Handler
                Button(action: {
                    if (keyString != "" && passwordString != ""){
                        words.updateValue(passwordString, forKey : keyString)
                        StorageHandler.setStorage(input : words)

                        keyString = ""
                        passwordString = ""
                        }
                    },
                    label: {
                        Text("Add Password")
                            .padding(.horizontal, 12)
                            .padding(.vertical, 5)
                            .border(Color.black, width: 1)
                            .foregroundColor(.black)
                        
                })
        }
    
}
    
    
    
    

    
}
