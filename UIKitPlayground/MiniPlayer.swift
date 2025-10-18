//
//  MiniPlayer.swift
//  UIKitPlayground
//
//  Created by 井本　智博 on 2025/09/27.
//

import SwiftUI
import Playgrounds

@available(iOS 26.0, *)
struct MiniPlayerView: View {
    var body: some View {
        VStack() {
            HStack() {
                Image(systemName: "swift")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                VStack(alignment: .leading) {
                    Text("Sexy Zone ｢人生遊戯｣ (YouTube Ver.) 2025/09/27")
                        .fontWeight(.medium)
                    Text("timelesz")
                }
                .lineLimit(1)
                .truncationMode(.tail)
                .font(.system(size:10))
                HStack {
                    Button(action: {}) {
                        Image(systemName: "gobackward.15")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                    }
                    
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "play.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                    })
                }
                .tint(.primary)
            }
            RoundedRectangle(cornerRadius: 10)
                .frame(height: 4)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .glassEffect(.regular, in: .containerRelative)
    }
}




#Preview {
    if #available(iOS 26.0, *) {
        MiniPlayerView()
    } else {
        // Fallback on earlier versions
    }
}

#Playground {
    
}
