
    


//  ShowPasswordsView.swift
//  hollandtran_357_project03
//
//  Created by Kelsey Holland and James Tran on 3/17/21.


import SwiftUI


//This view shows all the passwords the user has saved in a list. The user can swipe left on a name to delete it.
//When the user clicks on an item in the list, a detail view of the password is shown.
//Anytime the user deletes something, the storage handler updates the storage dictionary.
//A name array keeps track of the keys and updates the ui list.
struct ShowPasswordsView: View {
    

    @State private var showingDetail = false
    @State var nameArray : [String]
    
    @Binding var words  : Dictionary<String , String>
    
        var body: some View {
            VStack{
                Text("Saved Passwords")
                    .font(.title)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.leading)

                    List{
                        ForEach(self.nameArray, id: \.self){
                            item in
                            if(item != "master"){ //Checks if the password has the key word master; if it does, then skip over it since the master password should never be shown
                                Button(
                                    action: {
                                        showingDetail.toggle()
                                        
                                    },
                                    label: {
                                        Text(item).frame(maxWidth: .infinity, alignment: .leading)
                                })
                                    .sheet(isPresented: $showingDetail){
                                        DetailView(words: self.$words , nameArray : self.$nameArray
                                                 , key :
                                                    item, showingDetail : self.$showingDetail)
                                    }
                            }
                        }
                        .onDelete(perform: delete)
                }
            }
            .padding(.top)
            .onAppear(){
                words = StorageHandler.getStorage()
                nameArray = StorageHandler.getKeyArray(input: words)
            }
        }
    
        
    //This function deletes the list item, as well as the item in the dictionary, based off the index of the row the user has swiped left on.
    //Reference for finding out how to recieve an int from the offsets: https://stackoverflow.com/questions/61562137/how-to-get-the-index-of-a-deleted-row-from-a-list-in-swiftui/61562459#61562459
        func delete(at offsets: IndexSet){
            let index : Int = offsets[offsets.startIndex]
            
            let keyToDelete: String = nameArray[index]
            
            words.removeValue( forKey: keyToDelete)
            nameArray.remove(atOffsets: offsets)
            StorageHandler.setStorage(input: words)
        }
}
