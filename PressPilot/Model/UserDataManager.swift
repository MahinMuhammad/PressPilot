//
//  DataService.swift
//  PressPilot
//
//  Created by Md. Mahinur Rahman on 5/30/23.
//

/*
 Copyright 2023 Md. Mahinur Rahman

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
*/

import Foundation
import FirebaseAuth
import FirebaseFirestore

class UserDataManager: ObservableObject{
    static let shared = UserDataManager()
    let db = Firestore.firestore()
    
    @Published var userData:UserModel?
    @Published var newsCollection = [NewsModel]()
    
    func storeUserData(firstName:String, lastName:String, email:String){
        db.collection(K.FStore.userCollectionName).addDocument(data: [
            K.FStore.firstNameField : firstName,
            K.FStore.lastNameField : lastName,
            K.FStore.emailField : email
        ]){ error in
            if let e = error{
                print("Error adding user details: \(e)")
            }else{
                print("User details successfully added")
            }
        }
    }
    
    func readUserData(){
        self.userData = nil
        let firestoreCollection = db.collection(K.FStore.userCollectionName)
        
        if let currentUserEmail = Auth.auth().currentUser?.email{
            let userDataCollection = firestoreCollection.whereField(K.FStore.emailField, isEqualTo: currentUserEmail)
            userDataCollection.getDocuments { querySnapshot, error in
                if let e = error{
                    print("Failed to retrive user data: \(e)")
                }else{
                    if let snapshotDocuments = querySnapshot?.documents{
                        if snapshotDocuments.count != 0{
                            let data = snapshotDocuments[0].data()
                            if let firstName = data[K.FStore.firstNameField] as? String, let lastName = data[K.FStore.lastNameField] as? String, let email = data[K.FStore.emailField] as? String{
                                self.userData = UserModel(firstName: firstName, lastname: lastName, email: email)
                            }
                        }else{
                            print("Empty user data from firestore")
                        }
                    }
                }
            }
        }
    }
    
    func saveNews(email:String? ,title:String, url:String, urlToImage:String?){
        self.newsCollection.append(NewsModel(title: title, url: url, urlToImage: urlToImage))
        db.collection(K.FStore.savedNewsCollectionName).addDocument(data: [
            K.FStore.emailField : email as Any,
            K.FStore.titleField : title,
            K.FStore.urlField : url,
            K.FStore.urlToImageField : urlToImage as Any
        ]){error in
            if let e = error{
                print("Failed to save news with error: \(e)")
            }else{
                print("News saved successful")
            }
        }
    }
    
    func deleteSaveNews(url:String){
        newsCollection = newsCollection.filter{$0.url != url}
        let firestoreCollection = db.collection(K.FStore.savedNewsCollectionName)
        
        if let currentUserEmail = Auth.auth().currentUser?.email{
            let newsCollectionByEmail = firestoreCollection.whereField(K.FStore.emailField, isEqualTo: currentUserEmail)
            
            let query = newsCollectionByEmail.whereField(K.FStore.urlField, isEqualTo: url)
            query.getDocuments { (querySnapshot, error) in
                if let e = error {
                    print("Error getting news: \(e)")
                }else{
                    if let documents = querySnapshot?.documents{
                        for document in documents {
                            document.reference.delete()
                        }
                        print("unsaved news")
                    }else{
                        print("No news found")
                        return
                    }
                }
            }
        }
    }
    
    func deleteAllSaveNews(){
        newsCollection = []
        let firestoreCollection = db.collection(K.FStore.savedNewsCollectionName)

        if let currentUserEmail = Auth.auth().currentUser?.email{
            let query = firestoreCollection.whereField(K.FStore.emailField, isEqualTo: currentUserEmail)
            query.getDocuments { (querySnapshot, error) in
                if let e = error {
                    print("Error getting news: \(e)")
                }else{
                    if let documents = querySnapshot?.documents{
                        for document in documents {
                            document.reference.delete()
                        }
                        print("unsaved all news")
                    }else{
                        print("No news found")
                        return
                    }
                }
            }
        }
    }
    
    func fetchSavedNews(){
        self.newsCollection = []
        let firestoreCollection = db.collection(K.FStore.savedNewsCollectionName)
        
        if let currentUserEmail = Auth.auth().currentUser?.email{
            let newsCollection = firestoreCollection.whereField(K.FStore.emailField, isEqualTo: currentUserEmail)
            newsCollection.getDocuments { querySnapshot, error in
                if let e = error{
                    print("Failed to retrive saved news with error: \(e)")
                }else{
                    print("Retrived saved news successfully")
                    if let snapshotDocuments = querySnapshot?.documents{
                        for doc in snapshotDocuments{
                            let data = doc.data()
                            if let title = data[K.FStore.titleField] as? String, let url = data[K.FStore.urlField] as? String{
                                let urlToImage = data[K.FStore.urlToImageField] as? String
                                let news = NewsModel(title: title, url: url, urlToImage: urlToImage)
                                self.newsCollection.append(news)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func isSaved(newsURl:String)->Bool{
        for news in newsCollection{
            if news.url == newsURl{
                return true
            }
        }
        return false
    }
}