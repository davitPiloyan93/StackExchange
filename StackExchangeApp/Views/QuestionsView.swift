//
//  QuestionsView.swift
//  StackExchangeApp
//
//  Created by Davit Piloyan on 23.09.22.
//

import SwiftUI

struct QuestionsView<ViewModel: QuestionsViewModelProtocol>: View {
    
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        
        ZStack {
            List {
                ForEach(viewModel.questions) { question in
                    Text(question.title)
                        .font(.headline)
                        .background(.orange)
                }
            }
        }
        .task {
            await viewModel.initialFetch()
        }
        
    }
}

struct QuestionsView_Previews: PreviewProvider {
    static var previews: some View {
        screenViewFactory.makeQuestionsView(tagName: "Swift")
    }
}
