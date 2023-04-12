//
//  SourcesListView.swift
//  NewsApp
//
//  Created by Imen Ksouri on 04/04/2023.
//

import SwiftUI

struct SourcesListView: View {
    @Binding var sources: [String]
    @Binding var showingSources: Bool
    
    var body: some View {
        List(sources, id: \.self) { source in
            if let url = URL(string: "https://\(source)") {
                HStack {
                    Image(systemName: "arrow.right.circle.fill")
                    Link(source,
                         destination: url)
                }
                .foregroundColor(.accentColor)
            }
        }
        .padding(.horizontal)
        .navigationTitle("Sources")
        .listStyle(.plain)
    }
}

struct SourcesListView_Previews: PreviewProvider {
    @State static private var sources = Article.sampleSources
    static var previews: some View {
        SourcesListView(sources: $sources, showingSources: .constant(true))
    }
}
