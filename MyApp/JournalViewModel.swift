//
//  JournalViewModel.swift
//  MyApp
//
//  Created by abeer alrashedi on 11/11/2026.
//

import SwiftUI
import Combine

class JournalViewModel: ObservableObject {
    @Published var journals: [Journal] = []
    
    func addJournal(title: String, content: String) {
        let journal = Journal(title: title, content: content, date: Date(), isBookmarked: false)
        journals.append(journal)
    }
}

