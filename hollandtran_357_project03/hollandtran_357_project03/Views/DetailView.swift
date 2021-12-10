

//  DetailView.swift
//  hollandtran_357_project03
//
//  Created by Kelsey Holland and James Tran on 3/15/21.


//This sheet shows the password's key and value from the storage dictionary. The delete button calls the delete function,
//which updates the nameArray and words dictionary to remove the password. The user is then sent back to the
//ShowPasswords view.

import SwiftUI

struct DetailView: View {
    
    @Binding var words  : Dictionary<String , String>
    @Binding var nameArray : [String]
 
    @State var key : String = ""
    var password : String = ""
    @Binding var showingDetail : Bool
    
    var body: some View {
        VStack(alignment : .leading){
            Text(key)
                .font(.title)
                .fontWeight(.medium)
                .multilineTextAlignment(.leading)
                .padding()
            //Prints the value if the chosen key
            Text(StorageHandler.getValue(dictionary: words, key: key))
                .padding()
            //Delete Button
            Button(
                action: {
                    delete()
                },
                label: {
                    Text("Delete This Password")
                        .padding(.horizontal, 12)
                        .padding(.vertical, 5)
                        .border(Color.red, width: 1)
                        .foregroundColor(.red)
                }
            )
        }
    }
    //Removes value at a key from local dictionary and updates the Storage Handler with the new local dictionary
    func delete(){
        words.removeValue( forKey: key)
        let numToDelete : Int = self.nameArray.firstIndex(of : key)!
        nameArray.remove(at : numToDelete)
        StorageHandler.setStorage(input: words)
        showingDetail = false
    }

}




