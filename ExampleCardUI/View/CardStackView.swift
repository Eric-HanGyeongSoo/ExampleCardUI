//
//  CardStackView.swift
//  ExampleCardUI
//
//  Created by 한경수 on 2022/06/07.
//

import SwiftUI

struct CardStackView: View {
  @State private var offsets: [CGSize] = Array(repeating: CGSize.zero, count: 20)
  @State private var currentIndex = 19
  var body: some View {
    VStack {
      Spacer()
      ZStack {
        ForEach(0..<offsets.count) { index in
          CardView(
            offset: $offsets[index],
            currentIndex: $currentIndex,
            index: index)
          .frame(width: 300, height: 500)
        }
      }
      Spacer()
      Button(action: {
        if currentIndex < offsets.count-1 {
          withAnimation(.easeInOut(duration: 0.5)) {
            offsets[currentIndex+1] = .zero
            currentIndex += 1
          }
        }
      }) {
        Text("Back")
      }
    }
    .padding(30)
  }
}

struct CardStackView_Previews: PreviewProvider {
  static var previews: some View {
    CardStackView()
  }
}
