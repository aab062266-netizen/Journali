//
//  JournalListView.swift
//  MyApp
//
//  Created by abeer alrashedi on 11/11/2026.
//

import SwiftUI

struct JournalListView: View {
    @StateObject private var viewModel = JournalViewModel()
    @State private var showAddJournal = false
    @State private var journalToDelete: Journal?
    @State private var showDeleteAlert = false
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
                    List {
                        ForEach(viewModel.journals) { journal in
                            JournalCardView(journal: journal) {
                                viewModel.toggleBookmark(journal)
                            }
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                Button {
                                journalToDelete = journal
                                showDeleteAlert = true
                                } label: {
                                    Image(systemName: "trash.fill")
                                }
                                .tint(Color("Destructive"))
                            }
                        }
                        
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
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
                showAddJournal = true
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
            .sheet(isPresented: $showAddJournal) {
                AddJournalView(viewModel: viewModel)
            }
            .alert("Delete Journal?", isPresented: $showDeleteAlert) {
                Button("Cancel", role: .cancel) {}
                Button("Delete", role: .destructive) {
                    if let journalToDelete {
                        viewModel.deleteJournal(journalToDelete)
                    }
                }
            } message: {
                Text("Are you sure you want to delete this journal?")
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    JournalListView()
}
