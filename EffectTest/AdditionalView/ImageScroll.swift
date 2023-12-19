//
//  ImageScroll.swift
//  EffectTest
//
//  Created by Георгий Чебаков on 12/17/23.
//
import SwiftUI

struct PhotoScroll: View {
    var imageUrls: ContiguousArray<String>?
    
    @State private var currentUrl: String = ""
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $currentUrl) {
                ForEach(imageUrls ?? ContiguousArray(), id: \.self) { url in
                    Rectangle()
                        .foregroundColor(.clear)
                        .background(
                            AsyncImage(url: URL(string: url)) { image in
                                image
                                    .resizable()
                                    .clipped()
                            } placeholder: {
                                ProgressView()
                            }
                        )
                        .frameCustom(width: 343, height: 257)
                        .cornerRadius(25)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            selectionDots(currentUrl)
                .padding(.bottom, layout(8, width: false))
        }.frameCustom(width: 343, height: 257)
    }
    
    
    @ViewBuilder
    private func selectionDots(_ position: String) -> some View {
        if let imageUrls {
            HStack(alignment: .top, spacing: layout(5, width: true)) {
                ForEach(imageUrls, id: \.self) { select in
                    Circle()
                        .foregroundColor(.clear)
                        .frameCustom(width: 7, height: 7)
                        .background(position == "" ?
                                    (select == imageUrls.first ?
                                        .black : .black.opacity(0.22)
                                    ) : (
                                        position == select ?
                                        .black : .black.opacity(0.22)
                                    )
                        )
                        .cornerRadius(100)
                }
            }
            .padding(.horizontal, layout(10, width: true))
            .padding(.vertical, layout(5, width: false))
            .background(.white)
            .cornerRadius(5)
        }
    }
}
