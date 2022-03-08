//
//  ActivityView.swift
//  FoodMix
//
//  Created by Yuan on 27/02/2022.
//

import SwiftUI

struct ActivityView: View {
    
    @StateObject var viewModel: ActivityViewModel = ActivityViewModel()
    
    @State var getFirst: Bool = false
            
    var body: some View {
        
        VStack(spacing: 0) {
            
            ActivityAppBar()
                .padding(.horizontal, 25)
            
            // top 3
            ActivityBigTop()
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.blue.opacity(0.03).ignoresSafeArea())
        .overlay(
            
            ActivityListAuthor()
            
            ,alignment: .bottom
            
        )
        .onAppear {
            
            if viewModel.loadingFirst {
                return
            }
            getFirst = false
            viewModel.getFirstAuthors()
            
        }
        .environmentObject(viewModel)
    }

}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper {
            
            MainView()
            
        }
    }
}
