//
//  LatestHeadlinesListView.swift
//  NewsApp
//
//  Created by Imen Ksouri on 05/04/2023.
//

import SwiftUI

struct LatestHeadlinesListView: View {
    @Binding var headlines: [Article]
    @Binding var showingLatestHeadlines: Bool
    
    var topics: [String?] {
        Array(Set(headlines.map { $0.topic }))
    }
    
    let columns = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            if let topics = topics {
                // Multiple horizontal grid views if the articles displayed relate to many different topics (i.e. "All topics" has been selected in the search form)
                if topics.count > 1 {
                    ForEach(topics, id: \.self) { topic in
                        VStack(alignment: .leading) {
                            Text("# \(topic!)")
                                .font(.title)
                                .bold()
                                .foregroundColor(.accentColor)
                            ScrollView(.horizontal) {
                                LazyHGrid(rows: [GridItem()]) {
                                    ForEach(headlines) { headline in
                                        if headline.topic == topic {
                                            NavigationLink {
                                                ArticleDetailView(article: headline)
                                            } label: {
                                                ArticleShortSummaryView(headline: headline)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                // Simple vertical scrollview if one specific topic has been selected
                } else if topics.count == 1 {
                    VStack(alignment: .leading) {
                        Text("# \(topics[0]!)")
                            .font(.title)
                            .bold()
                            .foregroundColor(.accentColor)
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(headlines) { headline in
                                NavigationLink {
                                    ArticleDetailView(article: headline)
                                } label: {
                                    ArticleSummaryView(article: headline)
                                }
                            }
                        }
                    }
                }
            }
        }
        .padding(.horizontal)
        .navigationTitle("Latest Headlines")
    }
}

struct LatestHeadlinesListView_Previews: PreviewProvider {
    @State static private var headlines = Article.sampleHeadlines
    static var previews: some View {
        LatestHeadlinesListView(headlines: $headlines, showingLatestHeadlines: .constant(true))
    }
}
