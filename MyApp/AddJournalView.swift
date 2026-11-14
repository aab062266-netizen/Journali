//
//  AddJournalView.swift
//  MyApp
//
//  Created by abeer alrashedi on 12/11/2026.
//

import SwiftUI

struct AddJournalView: View {
    @ObservedObject var viewModel: JournalViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var title = ""
    @State private var content = ""
    var body: some View {
        NavigationStack {
            ZStack {
                Color("CardSurface").ignoresSafeArea()
                VStack(alignment: .leading, spacing: 8) {
                    TextField("Title", text: $title)
                        .font(.headingM)
                        .foregroundStyle(Color("TextPrimary"))
                    Text(Date().formatted(date: .numeric, time: .omitted))
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
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.addJournal(title: title, content: content)
                        dismiss()
                    } label: {
                        Image(systemName: "checkmark")
                    }
                    .tint(Color("PrimaryAccent"))
                    .disabled(title.isEmpty)
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    AddJournalView(viewModel: JournalViewModel())
}
