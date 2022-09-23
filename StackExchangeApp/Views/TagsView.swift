//
//  TagsView.swift
//  StackExchangeApp
//
//  Created by Davit Piloyan on 23.09.22.
//

import SwiftUI

struct TagsView<ViewModel: TagsViewModelProtocol>: View {
    
    @Environment(\.verticalSizeClass) var verticalClasses
    @EnvironmentObject var viewModel: ViewModel
    
    private func columns() -> [GridItem] {
        let count = verticalClasses == .regular ? 3 : 6
        return Array(repeating: GridItem.init(.flexible()), count: count)
        
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                if viewModel.tags.isEmpty {
                    ProgressView()
                        .task {
                            await viewModel.initialFetch()
                        }
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns()) {
                            Section {
                                ForEach(viewModel.tags) { tag in
                                    NavigationLink(value: tag) {
                                        Text(tag.name)
                                            .foregroundColor(.white)
                                            .padding()
                                            .background(.blue)
                                            .cornerRadius(10)
                                    }
                                }
                                
                            } footer: {
                                if viewModel.hasMoreItems() {
                                    footerView()
                                }
                            }
                        }
                    }
                    .refreshable {
                        await viewModel.initialFetch()
                    }
                }
            }
            .navigationDestination(for: Tag.self) { tag in
                screenViewFactory.makeQuestionsView(tagName: tag.name)
            }
        }
        .navigationTitle(Text("Tags"))
        
        
    }
    
    @ViewBuilder
    func footerView() -> some View {
        
        if viewModel.error == nil {
            ProgressView()
                .task {
                    await viewModel.loadMore()
                }
        } else {
            Button {
                Task {
                    await viewModel.loadMore()
                }
            } label: {
                Text("Error try again")
                    .padding()
                    .background(.orange)
            }

        }
        
    }
}

struct TagsView_Previews: PreviewProvider {
    static var previews: some View {
        screenViewFactory.makeTagsView()
    }
}
