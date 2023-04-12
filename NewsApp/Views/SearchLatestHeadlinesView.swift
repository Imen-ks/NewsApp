//
//  FormSearchLatestHeadlinesView.swift
//  NewsApp
//
//  Created by Imen Ksouri on 05/04/2023.
//

import SwiftUI

struct SearchLatestHeadlinesView: View {
    @ObservedObject var viewModel: ViewModelLatestHeadlines = ViewModelLatestHeadlines()
    @State private var headlines: [Article] = []
    @State private var period: Period = .all
    @State private var country: Country = .ALL
    @State private var language: Language = .all
    @State private var topic: Topic = .all
    @State private var sources = ""
    @State private var showingLatestHeadlines = false
    @State var isSearchingLatestHeadlines = true
    @State var isSearchingSources = false
    
    var periodParam: String {
        String(describing: period.rawValue)
    }
    var countryParam: String {
        String(describing: country)
    }
    var languageParam: String {
        String(describing: language)
    }
    var topicParam: String {
        String(describing: topic)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("HEADLINES SELECTION CRITERIA") {
                    SearchForm(topic: $topic, country: $country, language: $language, period: $period, sources: $sources, isSearchingLatestHeadlines: $isSearchingLatestHeadlines, isSearchingSources: $isSearchingSources)
                }
                .padding(5)
                Section {
                    Button {
                        showingLatestHeadlines.toggle()
                        viewModel.updateParams(period: periodParam, language: languageParam, country: countryParam, topic: topicParam, sources: sources)
                        Task {
                            do {
                                if let newsApiResponse = try await viewModel.articles {
                                    headlines = newsApiResponse.articles
                                }
                            } catch{
                                print(error)
                            }
                        }
                    } label: {
                        Text("Submit")
                    }
                    .frame(minWidth: 300)
                }
                .navigationDestination(isPresented: $showingLatestHeadlines) {
                    LatestHeadlinesListView(headlines: $headlines, showingLatestHeadlines: $showingLatestHeadlines)
                }
            }
            .navigationTitle("Latest Headlines")
        }
    }
}

struct SearchLatestHeadlinesView_Previews: PreviewProvider {
    static var previews: some View {
        SearchLatestHeadlinesView()
    }
}
