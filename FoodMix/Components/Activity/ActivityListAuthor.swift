//
//  ActivityListAuthor.swift
//  FoodMix
//
//  Created by Yuan on 08/03/2022.
//

import SwiftUI

struct ActivityListAuthor: View {
    
    @EnvironmentObject var viewModel: ActivityViewModel
    
    @State var offset: CGFloat = .zero
    
    let filters: [FilterItem] = [
        FilterItem(name: "Công Thức", value: "countRecipe"),
        FilterItem(name: "Đánh Giá", value: "countRating")
    ]
    
    var body: some View {
        CustomBottomSheet(offset: $offset, overlay: false, minHeight: getScreenBounds().height * 0.08, midHeight: getScreenBounds().height * 0.45, maxHeight: getScreenBounds().height * 0.85) {
        
            VStack(spacing: 20) {
                
                TitleView(title: "Đầu Bếp Nổi Bật") {
                    
                    TabFilterView<FilterItem>(
                        filters: filters,
                        current: $viewModel.current,
                        title: { item in
                            return item.name
                        },
                        isCurrent: { tab, current in
                            return tab.value == current.value
                        }
                    )
                        .disabled(viewModel.loadingFirst || viewModel.loading)
                        .onChange(of: viewModel.current.value) { _ in
                            
                            viewModel.loadingFirst = false
                            viewModel.page = 0
                            viewModel.authors.removeAll()
                            viewModel.getFirstAuthors()
                            
                        }
                    
                }
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(spacing: 20) {
                        
                        if viewModel.authors.count > 3 {
                            
                            Group {
                                
                                ForEach((4...(viewModel.authors.count - 1)), id: \.self) { index in
                                    
                                    AuthorItem(index: index, author: viewModel.authors[index - 1])
                                    
                                }
                                
                            }
                            
                        }
                        
                        if viewModel.loading {
                            
                            Group {
                                
                                ForEach(0 ..< 3) { item in
                                    AuthorItemPlaceholder()
                                }
                                
                            }
                            .redacted(reason: .placeholder)
                            
                        }
                        
                    }
                    
                }
                
            }
            .padding(.horizontal, 25)
            .frame(maxWidth: .infinity)
        }
    }
    
    @ViewBuilder
    private func AuthorItem(index: Int, author: User) -> some View {
        
        HStack(spacing: 15) {
            
            Text("\(index)")
            
            RecipeAvatar(avatar: author.avatar)
                .scaledToFit()
                .frame(width: 60, height: 60)
                .cornerRadius(60)
                .shadow(color: .black.opacity(0.1), radius: 10, x: 0.0, y: 0)
            
            VStack(alignment: .leading, spacing: 8) {
                
                Text(author.name)
                    .font(.custom(.customFont, size: 18))
                    .lineLimit(1)
                
                Text("@\(author.slug)")
                    .font(.custom(.customFont, size: 14))
                    .foregroundColor(.gray)
                
            }
            
            Spacer()
            
            if viewModel.current.value == "countRecipe" {
                
                AuthorBadge(text: "\(author.countRecipe ?? 0) CT")
                
            } else {
                
                AuthorBadge(text: "\(author.countRating ?? 0) ĐG")
                
            }
            
        }
        
    }
    
    @ViewBuilder
    private func AuthorBadge(text: String) -> some View {
        
        Text(text)
            .font(.system(size: 14))
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .padding(.vertical, 10)
            .padding(.horizontal, 15)
            .background(Color("Warning"))
            .cornerRadius(10)
            .shadow(color: .black.opacity(0.1), radius: 10, x: 0.0, y: 0)
        
    }
    
    @ViewBuilder
    private func AuthorItemPlaceholder() -> some View {
        
        HStack(spacing: 15) {
            
            Text("1")
            
            Image("avatar")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .cornerRadius(60)
                .shadow(color: .black.opacity(0.1), radius: 10, x: 0.0, y: 0)
            
            VStack(alignment: .leading, spacing: 8) {
                
                Text("Kim Ngân")
                    .font(.custom(.customFont, size: 18))
                    .lineLimit(1)
                
                Text("@dnstylish")
                    .font(.custom(.customFont, size: 14))
                    .foregroundColor(.gray)
                
            }
            
            Spacer()
            
            Text("120CT")
                .font(.system(size: 14))
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding(.vertical, 10)
                .padding(.horizontal, 15)
                .background(Color("Warning"))
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.1), radius: 10, x: 0.0, y: 0)
            
        }
        
    }
}

struct ActivityListAuthor_Previews: PreviewProvider {
    static var previews: some View {
        
        PreviewWrapper {
            
            ActivityView()
            
        }
    }
}
