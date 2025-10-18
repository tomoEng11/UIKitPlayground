//
//  LibraryView.swift
//  UIKitPlayground
//
//  Created by 井本　智博 on 2025/10/07.
//

import SwiftUI

@available(iOS 26.0, *)
struct LibraryView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    ForEach(0..<20) { index in
                        Text("コンテンツ \(index + 1)")
                            .font(.title3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background(.ultraThinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    }
                }
                .padding()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {}) {
                        Label("フィルター", systemImage: "line.3.horizontal.decrease.circle")
                    }
                }
                
               

                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {}) {
                        Label("追加", systemImage: "plus")
                    }
                }
            }
            .safeAreaBar(edge: .top) {
                HStack {
                    Image(systemName: "swift")
                    Button(action: {}) {
                        Label("サブスク", systemImage: "plus")
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
        }
    }
}

#Preview {
    if #available(iOS 26.0, *) {
        LibraryView()
    } else {
        // Fallback on earlier versions
    }
}
