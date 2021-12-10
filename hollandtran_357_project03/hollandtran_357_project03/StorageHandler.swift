//
//  StorageHandler.swift
//  hollandtran_357_project03
//
//  Created by Kelsey Holland and James Tran on 3/15/21.
//

//Storage Handler manages the storage dictonary, as well as the encryption and decryption of the key and password strings.

import Foundation

struct StorageHandler{
    static var defaultStorage: UserDefaults = UserDefaults.standard
    static var defaultKey = "PasswordStorage"


    //Updates the Deafult Storage with a passed in Dictionary
    static func setStorage(input: Dictionary<String , String>){
        var tempDictionary = input
        for (k,pw) in tempDictionary {
            tempDictionary.updateValue(encrypt(passwordString: pw, passphrase: k), forKey: k)
        }
        defaultStorage.set(tempDictionary, forKey: self.defaultKey)
    }
    
    //Accesses the stored dictionary
    static func getStorage() ->   Dictionary<String , String> {
        if var storedWords = defaultStorage.dictionary(forKey: self.defaultKey) as? [String : String] {
            for (k,pw) in storedWords {
                storedWords.updateValue(decrypt(encryptedPassword: pw, passphrase: k), forKey: k)
            }
            return storedWords
        }else{
            return [:]
        }
    }

    //Accesses the Key Names for the passwords stored in Default Storage
    static func getKeyArray(input: Dictionary<String , String>) -> [String]
    {
        var newArray : [String] = []
        for key in input.keys{
            newArray.append(key)
        }
        return newArray
    }
    
    //Accesses value with a specific key in dictionary
    static func getValue(dictionary: Dictionary<String, String>, key: String) -> String{
        guard let value: String = dictionary[key] else {return ""}
        
        return value
    }
    
    //Translates the ASCII values for alpha characters to an encrypted state
    static func translate(l: Character, trans: Int) -> Character{
        if let ascii = l.asciiValue{
            var outputInt = ascii
            if ascii >= 97 && ascii <= 122{
                outputInt = UInt8((Int(ascii-97)+trans)%26)+97
            }
            else if (ascii >= 65 && ascii <= 98){
                outputInt = UInt8((Int(ascii-65)+trans)%26)+65
            }
            // 65 -> 65 the Character value -> "A"
            return Character(UnicodeScalar(outputInt))
        }
        return Character("")
    }

    //Encrypts a password
    static func encrypt(passwordString: String, passphrase: String) -> String{
        let input = (passwordString + passphrase).reversed() //append the passphrase to the password and reverse the full string
        var strShift = ""
        let shift = input.count

        for letter in input{ //translate each letter according to the shift value
            strShift += String(translate(l: letter, trans: shift))
        }
        return strShift
    }

    //Decrypts a password; takes encrypted password and given passphrase as parameters
    static func decrypt(encryptedPassword: String, passphrase: String) -> String{
        var strShift = ""
        let passphraseCount: Int = passphrase.count
        var shift: Int
        //if statement finds the absolute difference of the encryptedPassword count and 26 to reverse the encryption
        if encryptedPassword.count > 26{ //checks if the size of the full string is larger than 26; this avoids dealing with negative numbers
            shift = encryptedPassword.count - 26
        }else{
            shift = 26 - encryptedPassword.count
        }
        
        for letter in encryptedPassword{//translates each letter according to the shift value
            strShift += String(translate(l: letter, trans: shift))
        }
        //Passphrase checking
        var passphraseCheck = "" //potential passphrase
        var strCount = 1
        for index in strShift{ //iterates through the full decrypted string to separate the passphrase from the password
            if strCount == passphraseCount+1{ //goes until we reach the passphrase count + 1; string is still reversed so the passphrase is before the password in the full string
                break
            }
            strCount+=1
            passphraseCheck += String(index)
        }
        //Checks if the reversed passphrase matches the key its assigned to
        if String(passphraseCheck.reversed()) == passphrase{ //if they match, then return the password
            strCount = 0
            var password = ""
            for index in strShift.reversed(){ //iterate through unreversed string to separate password
                if strCount == (strShift.count-passphrase.count){
                    break
                }
                strCount+=1
                password += String(index)
            }
            return password
        }else{//if they do not match, return error
            print("Passphrase does not match key")
            return "Invalid Key"
        }
    }

}



