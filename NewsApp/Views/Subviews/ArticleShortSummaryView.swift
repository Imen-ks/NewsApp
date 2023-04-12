//
//  ArticleShortSummaryView.swift
//  NewsApp
//
//  Created by Imen Ksouri on 06/04/2023.
//

import SwiftUI

struct ArticleShortSummaryView: View {
    var headline: Article

    var body: some View {
        
        VStack {
            if let media = headline.media?.replacing("http://", with: "https://") {
                AsyncImage(url: URL(string: media)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                    
                } placeholder: {
                    Rectangle()
                        .foregroundColor(.gray)
                        .frame(minHeight: 100)
                }
                .frame(maxWidth: 200, maxHeight: 100)
                .cornerRadius(10, corners: [.topLeft, .topRight])
            } else {
                Rectangle()
                    .foregroundColor(.gray)
                    .frame(minHeight: 100)
                    .cornerRadius(10, corners: [.topLeft, .topRight])
            }
                        
            VStack {
                if let title = headline.title {
                    Text(title)
                        .font(.headline).bold()
                        .padding(.bottom, 1)
                }
            }
            .cornerRadius(10, corners: [.bottomLeft, .bottomRight])
            .frame(maxWidth: 200, minHeight: 100)
            .foregroundColor(.black)
            .padding(.bottom, 8)
        }
        .overlay(RoundedRectangle(cornerRadius: 10)
            .stroke(Color.black, lineWidth: 0.3))
        .fixedSize(horizontal: false, vertical: false)
        .padding(.bottom, 5)
    }
}

struct ArticleShortSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            ArticleShortSummaryView(headline: Article.sampleHeadline1)
        }
    }
}
