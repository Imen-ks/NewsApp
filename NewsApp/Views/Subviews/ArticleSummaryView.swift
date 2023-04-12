//
//  ArticleSummaryView.swift
//  NewsApp
//
//  Created by Imen Ksouri on 05/04/2023.
//

import SwiftUI

struct ArticleSummaryView: View {
    var article: Article
    
    var body: some View {
        VStack {
            if let media = article.media?.replacing("http://", with: "https://") {
                AsyncImage(url: URL(string: media)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                    
                } placeholder: {
                    Rectangle()
                        .foregroundColor(.gray)
                        .frame(minHeight: 150)
                }
                .frame(minWidth: 300, maxHeight: 150)
                .cornerRadius(10, corners: [.topLeft, .topRight])
            } else {
                Rectangle()
                    .foregroundColor(.gray)
                    .frame(minHeight: 150)
                    .cornerRadius(10, corners: [.topLeft, .topRight])
            }
                        
            VStack {
                if let title = article.title {
                    Text(title)
                        .font(.title2).bold()
                        .padding(.bottom, 1)
                }
                if let excerpt = article.excerpt {
                    Text(excerpt)
                }
            }
            .cornerRadius(10, corners: [.bottomLeft, .bottomRight])
            .frame(minWidth: 330)
            .foregroundColor(.black)
            .padding(.bottom, 8)
        }
        .overlay(RoundedRectangle(cornerRadius: 10)
            .stroke(Color.black, lineWidth: 0.3))
        .fixedSize(horizontal: false, vertical: true)
    }
}

struct ArticleSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            ArticleSummaryView(article: Article.sampleArticle1)
        }
    }
}
