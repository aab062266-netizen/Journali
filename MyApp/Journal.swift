//
//  journal.swift
//  MyApp
//
//  Created by abeer alrashedi on 09/11/2026.
//

import Foundation

struct Journal: Identifiable {
    let id = UUID()
    var title: String
    var content: String
    var date: Date
    var isBookmarked: Bool
}
