//
//  DataService.swift
//  PressPilot
//
//  Created by Md. Mahinur Rahman on 5/30/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class DataService: ObservableObject{
    let db = Firestore.firestore()
    
    @Published var userData:UserData?
    @Published var newsCollection = [News]()
    
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
                        let data = snapshotDocuments[0].data()
                        if let firstName = data[K.FStore.firstNameField] as? String, let lastName = data[K.FStore.lastNameField] as? String, let email = data[K.FStore.emailField] as? String{
                            self.userData = UserData(firstName: firstName, lastname: lastName, email: email)
                        }
                    }
                }
            }
        }
    }
    
    func saveNews(email:String? ,title:String, url:String, urlToImage:String?){
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
                self.fetchSavedNews()
            }
        }
    }
    
    func deleteSaveNews(email:String?, url:String){
        let firestoreCollection = db.collection(K.FStore.savedNewsCollectionName)
        
        if let currentUserEmail = Auth.auth().currentUser?.email{
            let newsCollection = firestoreCollection.whereField(K.FStore.emailField, isEqualTo: currentUserEmail)
            
            let query = newsCollection.whereField(K.FStore.urlField, isEqualTo: url)
            query.getDocuments { (querySnapshot, error) in
                if let e = error {
                    print("Error getting news: \(e)")
                }else{
                    if let documents = querySnapshot?.documents{
                        for document in documents {
                            document.reference.delete()
                        }
                        self.fetchSavedNews()
                        print("unsaved news")
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
                                let news = News(title: title, url: url, urlToImage: urlToImage)
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
