//
//  SplashView.swift
//  MyApp
//
//  Created by abeer alrashedi on 16/11/2026.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            
            LinearGradient(
                colors: [Color("TopGradientColor"), Color("BottomGradientColor")],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Image("SplashNotebook")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 81.46, height: 106)
                
                Text("Journali")
                    .font(.display)
                    .foregroundStyle(Color("TextPrimary"))
                    .padding(.top, 21)
                
                Text("Your thoughts, your story")
                    .font(.bodySupporting)
                    .tracking(1)
                    .foregroundStyle(Color("TextPrimary"))
                    .padding(.top, 9)
            }
        }
    }
}

#Preview {
    SplashView()
}
