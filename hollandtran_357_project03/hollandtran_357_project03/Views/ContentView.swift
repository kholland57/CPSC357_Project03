//
//  ContentView.swift
//  hollandtran_357_project03
//
//  Created by Kelsey Holland and James Tran on 3/15/21.


    
   
import SwiftUI
        

//Entry point View, if MasterPasswordView Returns true,
//main menu view is accessed.

//Structure for Content View and MasterPassword View
//referenced after this source :
//https://stackoverflow.com/questions/56797333/swiftui-change-view-with-button




struct ContentView: View{
    @State var signIn = false
    
    var body: some View {
        return Group {
         
            if signIn {
                MainMenuView()
            }
            else {
                MasterPasswordView(signIn : $signIn)
            }
        }
           
        
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}














