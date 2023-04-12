//
//  ArticleDetailView.swift
//  NewsApp
//
//  Created by Imen Ksouri on 05/04/2023.
//

import SwiftUI

struct ArticleDetailView: View {
    var article: Article
    
    var body: some View {
        ScrollView {
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
                .frame(minWidth: 300)
            }
            VStack(alignment: .leading) {
                if let title = article.title {
                    Text(title)
                        .font(.title2).bold()
                        .padding(.bottom, 1)
                }
                if let author = article.author {
                    if !author.isEmpty {
                        Text("Author: \(author)")
                            .font(.caption)
                            .padding(.bottom, 2)
                    }
                }
                if let publishedDate = article.published_date {
                    Text("Pulished on \(publishedDate)")
                        .font(.caption)
                        .padding(.bottom, 2)
                }
                if let topic = article.topic {
                    Text("#\(topic)")
                        .font(.caption)
                        .padding(.bottom, 20)
                }
                if let summary = article.summary {
                    Text(summary)
                }
                
                if let link = article.link?.replacing("http://", with: "https://") {
                    Link("Read full article on \(article.clean_url!)",
                         destination: URL(string: link)!)
                    .padding(.top, 5)
                    .padding(.bottom, 20)
                }
            }
            .padding(20)
        }
    }
}

struct ArticleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleDetailView(article: Article.sampleArticle1)
    }
}
