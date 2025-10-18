//
//  PlayingPannelView.swift
//  UIKitPlayground
//
//  Created by 井本　智博 on 2025/10/07.
//

import SwiftUI

@available(iOS 26.0, *)
struct PlayingPannelView: View {
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: "https://picsum.photos/500/200"))
                .overlay {
                    HStack {
                        Button(action: {
                            
                        }, label: {
                            Image(systemName: "play.circle")
                                .resizable()
                                .frame(width: 60 ,height: 60)
                        })
                        .glassEffect(.clear)
                    }
                }
            
            Spacer()
        }
        .ignoresSafeArea()
    }
}

#Preview {
    if #available(iOS 26.0, *) {
        PlayingPannelView()
    } else {
        // Fallback on earlier versions
    }
}
