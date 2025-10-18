//
//  RefreshableScrollView.swift
//  UIKitPlayground
//
//  Created by 井本　智博 on 2025/10/07.
//

import SwiftUI

@available(iOS 26.0, *)
struct RefreshableScrollView: View {
    var body: some View {
        ScrollView {
            Button("Button") {
                
            }
            .buttonStyle(.glass)
            LazyVStack {
                Color.blue
                    .frame(width: 300, height: 100)
                ForEach(0..<12) { index in
                    Rectangle()
                        .foregroundStyle(.red)
                        .frame(width: 300, height: 100)
                }
            }
        }
        .refreshable {
            
        }
        .safeAreaBar(edge: .top) {
            HStack {
                Image(systemName: "swift")
                
            }
            .foregroundStyle(.blue)
        }
    }
}

#Preview {
    if #available(iOS 26.0, *) {
        RefreshableScrollView()
    } else {
        // Fallback on earlier versions
    }
}
