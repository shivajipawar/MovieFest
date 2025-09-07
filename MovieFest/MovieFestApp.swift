//
//  MovieFestApp.swift
//  MovieFest
//
//  Created by Shivaji N. Pawar on 07/09/25.
//

import SwiftUI

@main
struct MovieFestApp: App {
    let persistenceController = PersistenceController.shared
    
    init() {
        configureCache()
    }
    
    var body: some Scene {
        WindowGroup {
            HomeScreen()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
    
    private func configureCache() {
        // Configure URLCache with 500MB memory + 500MB disk
        let memoryCapacity = 500 * 1024 * 1024   // 500 MB
        let diskCapacity = 500 * 1024 * 1024     // 500 MB
        let cache = URLCache(memoryCapacity: memoryCapacity,
                             diskCapacity: diskCapacity,
                             diskPath: "MovieFestCache")
        
        URLCache.shared = cache
        
        print("✅ URLCache configured with \(memoryCapacity / 1024 / 1024)MB memory / \(diskCapacity / 1024 / 1024)MB disk")
    }
}
