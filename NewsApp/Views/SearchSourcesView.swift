//
//  FormSearchSourcesView.swift
//  NewsApp
//
//  Created by Imen Ksouri on 06/04/2023.
//

import SwiftUI

struct SearchSourcesView: View {
    @ObservedObject var viewModel: ViewModelSources = ViewModelSources()
    @State private var sources: [String] = []
    @State private var country: Country = .ALL
    @State private var language: Language = .all
    @State private var topic: Topic = .all
    @State private var showAlert = false
    @State private var showingSources = false
    @State var isSearchingLatestHeadlines = false
    @State var isSearchingSources = true
    
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
                Section("SOURCES SELECTION CRITERIA") {
                    SearchForm(topic: $topic, country: $country, language: $language, isSearchingLatestHeadlines: $isSearchingLatestHeadlines, isSearchingSources: $isSearchingSources)
                    
                }
                .padding(5)
                Section {
                    Button {
                        if country == .ALL && language == .all && topic == .all {
                            showAlert = true
                        } else {
                            showingSources.toggle()
                            viewModel.updateParams(language: languageParam, country: countryParam, topic: topicParam)
                            Task {
                                do {
                                    if let newsApiResponse = try await viewModel.sources {
                                        sources = newsApiResponse.sources
                                    }
                                } catch{
                                    print(error)
                                }
                            }
                        }
                    } label: {
                        Text("Submit")
                    }
                    .frame(minWidth: 300)
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Please select at least one criteria"), dismissButton: .default(Text("Ok")))
                    }
                }
                .navigationDestination(isPresented: $showingSources) {
                    SourcesListView(sources: $sources, showingSources: $showingSources)
                }
            }
            .navigationTitle("Sources")
        }
    }
}

struct SearchSourcesView_Previews: PreviewProvider {
    static var previews: some View {
        SearchSourcesView()
    }
}
