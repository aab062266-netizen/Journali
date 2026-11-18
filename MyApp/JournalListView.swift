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
    @State private var journalToEdit: Journal?
    @State private var journalToDelete: Journal?
    @State private var showDeleteAlert = false
    @State private var sortByBookmark = false
    @State private var showBookmarkedOnly = false
    @State private var isGrid = false
    @State private var searchText = ""
    
    private let gridColumns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var sortedJournals: [Journal] {
        var list = viewModel.journals
        
        if !searchText.isEmpty {
            list = list.filter { journal in
                journal.title.localizedCaseInsensitiveContains(searchText) ||
                journal.content.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        if showBookmarkedOnly {
            list = list.filter { $0.isBookmarked }
        }
        
        if sortByBookmark {
            list.sort { first, second in
                if first.isBookmarked != second.isBookmarked {
                    return first.isBookmarked
                }
                return first.date > second.date
            }
        } else {
            list.sort { $0.date > $1.date }
        }
        
        return list
    }
    
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
                } else if isGrid {
                    ScrollView {
                        LazyVGrid(columns: gridColumns, spacing: 16) {
                            ForEach(sortedJournals) { journal in
                                JournalCardView(journal: journal, isCompact: true) {
                                    viewModel.toggleBookmark(journal)
                                }
                                .onTapGesture {
                                    journalToEdit = journal
                                }
                                .contextMenu {
                                    Button("Delete", role: .destructive) {
                                        journalToDelete = journal
                                        showDeleteAlert = true
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 26)
                        .padding(.vertical, 8)
                    }
                } else {
                    List {
                        ForEach(sortedJournals) { journal in
                            JournalCardView(journal: journal) {
                                viewModel.toggleBookmark(journal)
                            }
                            .onTapGesture {
                                journalToEdit = journal
                            }
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets(top: 8, leading: 26, bottom: 8, trailing: 26))
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
            .toolbarTitleDisplayMode(.inlineLarge)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    HStack {
                        Menu {
                            Button("Sort by Bookmark") {
                                sortByBookmark = true
                            }
                            Button("Sort by Entry Date") {
                                sortByBookmark = false
                            }
                            Toggle("Show Bookmarked Only", isOn: $showBookmarkedOnly)
                            Toggle("Grid View", isOn: $isGrid)
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
            .searchable(text: $searchText)
            .sheet(isPresented: $showAddJournal) {
                AddJournalView(viewModel: viewModel)
            }
            .sheet(item: $journalToEdit) { journal in
                AddJournalView(viewModel: viewModel, journal: journal)
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
