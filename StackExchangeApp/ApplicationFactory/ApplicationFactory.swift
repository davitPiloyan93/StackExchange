//
//  ApplicationFactory.swift
//  StackExchangeApp
//
//  Created by Davit Piloyan on 23.09.22.
//

import Foundation


import SwiftUI

final class ApplicationFactory {
    
    let stackExchangeNetworkService: StackExchangeNetworkService
    let stackExchangeService: StackExchangeService
    
    
    init() {
        let networkService = NetworkService()
        stackExchangeNetworkService = StackExchangeNetworkService(networkService: networkService)
        stackExchangeService = StackExchangeService(networkService: stackExchangeNetworkService)
    }
}

let screenViewFactory = ScreenViewFactoryImpl()

final class ScreenViewFactoryImpl {
    
    fileprivate let applicationFactory = ApplicationFactory()
    fileprivate init(){}
    
    func makeTagsView() -> some View {
        let viewModel = TagsViewModel(stackExchangeService: applicationFactory.stackExchangeService)
        
        return TagsView<TagsViewModel>()
            .environmentObject(viewModel)
    }
}
