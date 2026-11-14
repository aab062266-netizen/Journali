//
//  JournalCardView.swift
//  MyApp
//
//  Created by abeer alrashedi on 10/11/2026.
//

import SwiftUI

struct JournalCardView: View {
    let journal: Journal
    var onBookmarkTap: () -> Void = {}
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(journal.title)
                    .font(.titleCard)
                    .foregroundStyle(Color("TextAccent"))
                Spacer()
                Button(action: onBookmarkTap) {
                    Image(systemName: journal.isBookmarked ? "bookmark.fill" : "bookmark")
                        .foregroundStyle(Color("TextAccent"))
                }
            }
            Text(journal.date.formatted(date: .numeric, time: .omitted))
                .font(.captionS)
                .foregroundStyle(Color("TextSecondary"))
            Text(journal.content)
                .font(.bodyM)
                .foregroundStyle(Color("TextPrimary"))
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color("CardSurface"))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
    
}

#Preview {
    JournalCardView(
        journal: Journal(
          title: "My Birthday",
          content: "Lorem ipsum dolor sit amet",
          date: Date(),
          isBookmarked: true
           )
    )
    .preferredColorScheme(.dark)
}



