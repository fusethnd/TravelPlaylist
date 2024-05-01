//
//  JoerneyView.swift
//  TravelPlaylist
//
//  Created by Thanadon Boontawee on 24/4/2567 BE.
//

import SwiftUI
import FirebaseFirestoreSwift

struct JoerneyView: View {
    @StateObject var joerneyViewModel: JoerneyViewModel
    
    init(userId: String) {
        self._joerneyViewModel = StateObject(wrappedValue: JoerneyViewModel(userId: userId))
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List(joerneyViewModel.posts) { post in
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Author: \(post.author)")
                            .font(.headline)
                        Text("Content: \(post.content)")
                            .font(.body)
                            .foregroundColor(.secondary)
                        
                    }
                    .padding(.vertical, 8)
                }
                .navigationTitle("My Journey")
            }
            .navigationBarTitle("Journey")
        }
    }
}


//struct JoeyneyView_Previews: PreviewProvider {
//    static var previews: some View {
//        JoerneyView(userId: "kSHThjwK0DPwt4hrCsu2dQ17gHU2")
//    }
//}
