//
//  StackExchangeAppApp.swift
//  StackExchangeApp
//
//  Created by Davit Piloyan on 23.09.22.
//

import SwiftUI

@main
struct StackExchangeAppApp: App {
    var body: some Scene {
        WindowGroup {
            screenViewFactory.makeTagsView()
        }
    }
}
