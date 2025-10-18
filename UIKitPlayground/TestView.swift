//
//  TestView.swift
//  UIKitPlayground
//
//  Created by 井本　智博 on 2025/09/27.
//

import SwiftUI
import Playgrounds

@available(iOS 26.0, *)
struct TestView: View {
    @State private var showDialog: Bool = false
    let array = [1,2,4]
    var body: some View {
        VStack {
            Button("確認") {
                showDialog.toggle()
            }
            
        }
        .frame(width: 300, height: 50)
        .border(.pink)
        .confirmationDialog("確認Dialog", isPresented: $showDialog, actions: {
//                Button(role: .confirm, action: {})
//
//                Button(role: .close, action: {})
            // キャンセルは使えない？
//                Button(role: .destructive, action: {})
            Button(action: {
                debugPrint(array)
            }) {
                Text("ボタン")
            }
            Button("q", action: {
                print(array)
            })
            Button(role: .cancel, action: {
                print("HHHH")
            })
            
        })
    }
}

#Preview {
    if #available(iOS 26.0, *) {
        TestView()
    } else {
        // Fallback on earlier versions
    }
}


#Playground {
    let text = "Hello"
    let expr: PartialRangeUpTo<String.Index> = ..<text.index(text.startIndex, offsetBy: 3)
    let range = expr.relative(to: text)

    print(text[range]) // "Hel"
}
