//
//  AddJournalView.swift
//  MyApp
//
//  Created by abeer alrashedi on 12/11/2026.
//


import SwiftUI

struct AddJournalView: View {
    @ObservedObject var viewModel: JournalViewModel
    var journal: Journal? = nil
    @Environment(\.dismiss) private var dismiss
    @State private var title = ""
    @State private var content = ""
    @State private var showDiscardAlert = false
    
    private var hasChanges: Bool {
        if let journal {
            return title != journal.title || content != journal.content
        } else {
            return !title.isEmpty || !content.isEmpty
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("CardSurface").ignoresSafeArea()
                
                VStack(alignment: .leading, spacing: 8) {
                    TextField("Title", text: $title)
                        .font(.headingM)
                        .foregroundStyle(Color("TextPrimary"))
                    Text((journal?.date ?? Date()).formatted(date: .numeric, time: .omitted))
                        .font(.captionS)
                        .foregroundStyle(Color("TextSecondary"))
                    ZStack(alignment: .topLeading) {
                        TextEditor(text: $content)
                            .font(.bodyM)
                            .foregroundStyle(Color("TextPrimary"))
                            .scrollContentBackground(.hidden)
                        if content.isEmpty {
                            Text("Type your Journal...")
                                .font(.bodyM)
                                .foregroundStyle(Color("TextSecondary"))
                                .padding(.top, 8)
                                .padding(.leading, 5)
                                .allowsHitTesting(false)
                        }
                    }
                }
                .padding(16)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        if hasChanges {
                            showDiscardAlert = true
                        } else {
                            dismiss()
                        }
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        if let journal {
                            viewModel.updateJournal(journal, title: title, content: content)
                        } else {
                            viewModel.addJournal(title: title, content: content)
                        }
                        dismiss()
                    } label: {
                        Image(systemName: "checkmark")
                    }
                    .tint(Color("PrimaryAccent"))
                    .disabled(title.isEmpty)
                }
            }
            .alert("Are you sure you want to discard changes on this journal?", isPresented: $showDiscardAlert) {
                Button("Discard Changes", role: .destructive) {
                    dismiss()
                }
                Button("Keep Editing", role: .cancel) {}
            }
            .onAppear {
                if let journal {
                    title = journal.title
                    content = journal.content
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    AddJournalView(viewModel: JournalViewModel())
}
