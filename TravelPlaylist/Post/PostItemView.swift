//
//  PostItemView.swift
//  TravelPlaylist
//
//  Created by Thanadon Boontawee on 24/4/2567 BE.
//

import SwiftUI

struct PostItemView: View {
    @StateObject var viewModel = PostItemViewModel()
    let item: PostItem
    
    var body: some View {
        HStack {
            VStack(alignment: .center) {
                HStack {
                    Text(item.authorName)
                        .font(.headline)
                    Text(item.author)
                        .font(.headline)
                }
                
                Text(item.content)
                    .font(.body)
                
                
                Text("Song") // item.track
                    .font(.title)
                    .bold()
                
                Text("Artist") // item.artist
                
                Text("Location") // item.location
//                Text(item.content)
//                    .font(.title)
//                    .bold()
                
                Text("\(Date(timeIntervalSince1970: item.createDate).formatted(date: .abbreviated, time: .shortened))")
                    .font(.footnote)
                    .foregroundColor(Color(.secondaryLabel))
                
                MapsView(latitude: item.latitude,longitude: item.longitude)
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.blue.opacity(0.3))
                    .cornerRadius(10)
                    .padding()
                
                Text("latitude: \(item.latitude)")
                    .font(.body)
                Text("longitude: \(item.longitude)")
                    .font(.body)
                
            }
        }
    }
}

//struct PostItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostItemView(item: PostItem(
//            id: "123",
//            authorName: "John Doe",
//            author: "@johndoe",
//            content: "Get Milk in today.",
//            createDate: Date().timeIntervalSince1970)
//        )
//    }
//}
