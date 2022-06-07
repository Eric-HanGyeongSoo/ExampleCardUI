//
//  CardView.swift
//  ExampleCardUI
//
//  Created by 한경수 on 2022/06/07.
//

import SwiftUI

struct CardView: View {
  @Binding var offset: CGSize
  @Binding var currentIndex: Int
  var index: Int
  var anchor: UnitPoint {
    if offset.width > 0 {
      return .bottomTrailing
    } else {
      return .bottomLeading
    }
  }
  var greenOpacity: Double {
    if offset.width < 0 {
      return 0
    } else {
      return offset.width / (UIScreen.main.bounds.width / 4)
    }
  }
  
  var yellowOpacity: Double {
    if offset.width > 0 {
      return 0
    } else {
      return abs(offset.width) / (UIScreen.main.bounds.width / 4)
    }
  }
  
  var degrees: Angle {
    return .degrees(Double((offset.width / UIScreen.main.bounds.width)*45))
  }
  
  var backgroundColor: Color {
    switch index % 3 {
    case 0:
      return Color.brown
    case 1:
      return Color.blue
    default:
      return Color.pink
    }
  }
  
  var preCardOffset: CGSize {
    if index >= currentIndex {
      return .zero
    } else if index == currentIndex - 1 {
      return CGSize(width: 10, height: -10)
    } else {
      return CGSize(width: 20, height: -20)
    }
  }
  
  var preCardWidthMultiplier: Double {
    if index >= currentIndex {
      return 1
    } else if index == currentIndex - 1 {
      return 280 / 300
    } else {
      return 260 / 300
    }
  }
  
  var body: some View {
    GeometryReader { geometry in
      ZStack(alignment: .top) {
        Text("Example")
          .frame(width: geometry.size.width * preCardWidthMultiplier, height: geometry.size.height)
          .background(Color.white)
        
        Text("알겠어요")
          .frame(width: geometry.size.width * preCardWidthMultiplier, height: 50)
          .background(Color.green)
          .foregroundColor(Color.white)
          .opacity(greenOpacity)
        
        Text("복습할래요")
          .frame(width: geometry.size.width * preCardWidthMultiplier, height: 50)
          .background(Color.yellow)
          .foregroundColor(Color.black)
          .opacity(yellowOpacity)
      }
      .frame(width: geometry.size.width * preCardWidthMultiplier, height: geometry.size.height)
      .cornerRadius(8)
      .overlay(
        RoundedRectangle(cornerRadius: 8)
          .stroke(Color.gray, lineWidth: 1)
      )
      .offset(preCardOffset)
      .offset(offset)
      .rotationEffect(degrees, anchor: anchor)
      .gesture(
        DragGesture()
          .onChanged { gesture in
            offset = gesture.translation
          }
          .onEnded { gesture in
            if offset.width > UIScreen.main.bounds.width / 4 {
              withAnimation {
                currentIndex -= 1
                offset.width = UIScreen.main.bounds.width * 1.5
              }
            } else if abs(offset.width) > UIScreen.main.bounds.width / 4 {
              withAnimation {
                currentIndex -= 1
                offset.width = -UIScreen.main.bounds.width * 1.5
              }
            } else {
              withAnimation {
                offset = .zero
              }
            }
          }
      )
    }
  }
}

struct CardView_Previews: PreviewProvider {
  static var previews: some View {
    CardView(
      offset: .constant(CGSize.zero),
      currentIndex: .constant(0),
      index: 0).previewLayout(.fixed(width: 300, height: 500))
  }
}
