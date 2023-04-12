//
//  NewsApp.swift
//  NewsApp
//
//  Created by Imen Ksouri on 04/04/2023.
//

import SwiftUI

@main
struct NewsApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                SearchArticlesView()
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                SearchLatestHeadlinesView()
                    .tabItem {
                        Label("Latest news", systemImage: "newspaper")
                    }
                SearchSourcesView()
                    .tabItem {
                        Label("Websites", systemImage: "globe")
                    }
            }
        }
    }
}
