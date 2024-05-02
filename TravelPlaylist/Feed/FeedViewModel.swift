import Foundation
import FirebaseFirestore
import FirebaseAuth

class FeedViewModel: ObservableObject {
    @Published var showingCreatePostView = false
    @Published var showingPostItemView = false
    @Published var title = ""
    @Published var content = ""
    @Published var showAlert = false
    @Published var feed: [PostItem] = []
    
    private var db = Firestore.firestore()
    
    init() {
        fetchPostItem()
    }
    
    func fetchPostItem() {
        db.collectionGroup("journey")
            .order(by: "createDate", descending: true)
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Error fetching posts: \(error)")
                    return
                }
                
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                
                self.feed = documents.compactMap { document in
                    let data = document.data()
                    guard let id = document.documentID as? String,
                          let authorName = data["authorName"] as? String,
                          let author = data["author"] as? String,
                          let content = data["content"] as? String,
                          let createDate = data["createDate"] as? TimeInterval,
                          let latitude = data["latitude"] as? Double,
                          let longitude = data["longitude"] as? Double else {
                        print("Invalid document data")
                        return nil
                    }
                    return PostItem(id: id, authorName: authorName, author: author, content: content, createDate: createDate, latitude: latitude, longitude: longitude)
                }
            }
    }
}
