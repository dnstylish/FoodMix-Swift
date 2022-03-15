//
//  NavigationExtention.swift
//  FoodMix
//
//  Created by Yuan on 07/03/2022.
//

import SwiftUI

extension View {
    
    func withAuth() -> some View {
        return self.modifier(WithAuth())
    }
}

struct WithAuth: ViewModifier {
    
    @State private var isActive: Bool = false
    
    @Environment(\.authKey) private var authKey
    
    func body(content: Content) -> some View {
        
        Group {
            
            if authKey {
                content
            } else {
                
                Button {
                    
                    print("❌ DEBUG: \("134")")

                    isActive.toggle()
                    
                    
                } label: {
                    content.disabled(true)
                }
                .fullScreenCover(isPresented: $isActive) {
                    WelcomeView()
                }
                
            }
            
        }
        
    }
}
