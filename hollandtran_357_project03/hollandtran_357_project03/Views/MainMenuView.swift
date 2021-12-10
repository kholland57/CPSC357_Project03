//
//  MainMenuView.swift
//  hollandtran_357_project03
//
//  Created by Kelsey Holland and James Tran on 3/16/21.
//

import SwiftUI



//The Main Menu View for the app has two navigation
//buttons, one to AddPasswordView and ShowPasswordView.

struct MainMenuView: View {
    
    @State var words = StorageHandler.getStorage()
    
    
    var body: some View {
        NavigationView{
            VStack(alignment: .center
            ){
                List{
                    NavigationLink(destination: AddPasswordView(words: self.$words)){
                        Image(systemName: "plus.circle")
                            .padding(.trailing)
                            .font(.system(size: 40))
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                            
                        Text("Add a Password")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .multilineTextAlignment(.leading)
                    }
                    .padding()
                    
                    NavigationLink(destination: ShowPasswordsView(nameArray: [], words: self.$words)){
                        Image(systemName: "folder.circle")
                            .padding(.trailing)
                            .font(.system(size: 40))
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        Text("Saved Passwords")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .multilineTextAlignment(.leading)
                    }
                    .padding()
                }
                .listStyle(InsetListStyle())
            }
            .navigationBarTitle(Text("Password Manager"), displayMode: .inline)
        }
        .padding(0.0)
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}





//https://stackoverflow.com/questions/56528361/swiftui-view-is-in-the-middle-instead-of-in-the-top
