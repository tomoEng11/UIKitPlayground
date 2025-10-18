//
//  StickHeaderView.swift
//  UIKitPlayground
//
//  Created by 井本　智博 on 2025/09/29.
//

import SwiftUI

@available(iOS 26.0, *)
struct StickHeaderView: View {
    @State private var showIcons = true
    private let iconHideThreshold: CGFloat = -80
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 16) {
                GeometryReader { proxy in
                    Color.clear
                        .preference(key: ScrollOffsetPreferenceKey.self, value: proxy.frame(in: .named("stickHeaderScroll")).minY)
                }
                .frame(height: 0)
                
                ForEach(0..<20) { _ in
                    Rectangle()
                        .frame(width: 300, height: 100)
                        .foregroundStyle(.red)
                }
            }
            .padding(.top, 16)
        }
        .coordinateSpace(name: "stickHeaderScroll")
        .onPreferenceChange(ScrollOffsetPreferenceKey.self) { offset in
            let shouldShow = offset > iconHideThreshold
            if showIcons != shouldShow {
                withAnimation(.easeInOut(duration: 0.2)) {
                    showIcons = shouldShow
                }
            }
        }
        .safeAreaBar(edge: .top, content:  {
            VStack {
                if showIcons {
                    Image(systemName: "swift")
                }
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        ForEach(0..<10) { i in
                            Image(systemName: "\(i).circle.fill")
                                .font(.title2)
                                .padding(8)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.bottom, 8)
        })

    }
}

#Preview {
    if #available(iOS 26.0, *) {
        StickHeaderView()
    } else {
        EmptyView()
    }
}

extension Color {
    
}

private struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat { 0 }
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
