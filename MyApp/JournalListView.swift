//
//  JournalListView.swift
//  MyApp
//
//  Created by abeer alrashedi on 11/11/2026.
//

import SwiftUI

struct JournalListView: View {
    @StateObject private var viewModel = JournalViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                if viewModel.journals.isEmpty {
                    VStack(spacing: 8) {
                        Image("EmptyNotebook")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 151)
                        Text("Begin Your Journal")
                            .font(.headingM)
                            .foregroundStyle(Color("TextAccent"))
                        Text("Craft your personal diary, tap the plus icon to begin")
                            .font(.bodySupporting)
                            .foregroundStyle(Color("TextPrimary"))
                            .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal, 32)
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(viewModel.journals) { journal in
                                JournalCardView(journal: journal)
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                }
            }
            .navigationTitle("Journal")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    HStack {
                        Button {
                            // الفلتر، نضيفه لاحقًا
                        } label: {
                            Image(systemName: "line.3.horizontal.decrease")
                        }
                        Button {
                            // إضافة يومية، نضيفها لاحقًا
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    JournalListView()
}
