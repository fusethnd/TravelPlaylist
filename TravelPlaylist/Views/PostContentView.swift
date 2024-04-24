//
//  PostContentView.swift
//  TravelPlaylist
//
//  Created by Thanadon Boontawee on 24/4/2567 BE.
//

import SwiftUI
import FirebaseFirestoreSwift

struct PostContentView: View {
    @StateObject var viewModel: PostContentViewModel
    let item: PostItem

    init(userId: String, item: PostItem) {
        self.item = item
        self._viewModel = StateObject(wrappedValue: PostContentViewModel(userId: userId))
    }

    var body: some View {

        VStack {
            // show profile

            // show location

            // show content
            HStack {
                Text(item.content)
                    .font(.title3)
                    .foregroundColor(Color(.secondaryLabel))
                Spacer()
            }
            
            // show track
        }
//        .navigationTitle(item.title)
        .toolbar {
            Button {
                viewModel.showingItemView = true
            } label: {
                Image(systemName: "pencil")
            }
        }
        .padding()

        Spacer()
    }
}

struct PostContentView_Previews: PreviewProvider {
    static var previews: some View {
        PostContentView(
            userId: "A7fMXIMP7pctLhRFNH5Ue17uzYB2",
            item: PostItem(
                id: "123",
                content: "temp",
                createDate: Date().timeIntervalSince1970
            )
        )
    }
}
