// The Swift Programming Language
// https://docs.swift.org/swift-book
import SwiftUI
import Foundation
import Combine
import SUtilKit_SwiftUI

public struct Carousel<C:View,I:View>: View {
    
    private var _numberContent: Int
    private var _content: IA_BListener<GeometryProxy,C>
    private var _spacing: CGFloat = 0
    private var _indicator: IAB_CListener<Binding<Int>,Int,I>
    //
    private let _timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    @State private var slideGesture: CGSize = CGSize.zero
    @State private var _currentIndex: Int = 0
    
    //
    public init(
        numberContent: Int,
        spacing: CGFloat = 0,
        @ViewBuilder content: @escaping IA_BListener<GeometryProxy,C>,
        @ViewBuilder indicator: @escaping IAB_CListener<Binding<Int>,Int,I>
        ) {
            self._numberContent = numberContent
            self._content = content
            self._spacing = spacing
            self._indicator = indicator
        }
    
    //
    public var body: some View {
        GeometryReader { geometry in
            // 1
            ZStack(alignment: .bottom) {
                HStack(spacing: _spacing) {
                    self._content(geometry)
                }
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .leading)
                .offset(x: CGFloat(self._currentIndex) * -geometry.size.width, y: 0)
                .animation(.spring())
                // Comment .onReceive method, to omit the Slider with time
                .onReceive(self._timer) { _ in
                    self._currentIndex = (self._currentIndex + 1) % (self._numberContent == 0 ? 1 : self._numberContent)}
                // Comment .gesture method, to omit the Swipe function
                .gesture(
                    DragGesture()
                        .onChanged{ value in
                            self.slideGesture = value.translation
                        }
                        .onEnded{ value in
                            if self.slideGesture.width < -50 {
                                if self._currentIndex < self._numberContent - 1 {
                                    withAnimation {
                                        self._currentIndex += 1
                                    }
                                }
                            }
                            if self.slideGesture.width > 50 {
                                if self._currentIndex > 0 {
                                    withAnimation {
                                        self._currentIndex -= 1
                                    }
                                }
                            }
                            self.slideGesture = .zero
                        })
                
                // 2
                _indicator($_currentIndex,_numberContent)
            }
        }
    }
}

public struct Indicator: View {
    @Binding public var currentIndex: Int
    public let numberContent:Int
    public let spacing:CGFloat = 5
    public let selectColor:Color = Color.white
    public let unselectColor = Color.gray
    
    public    init(currentIndex: Binding<Int>, numberContent: Int) {
        self._currentIndex = currentIndex
        self.numberContent = numberContent
    }
    
    public var body: some View {
        HStack(spacing: spacing) {
            ForEach(0..<self.numberContent, id: \.self) { index in
                Circle()
//                    .frame(width: index == self.currentIndex ? 10 : 8,
//                           height: index == self.currentIndex ? 10 : 8)
                    .frame(width: 8,height: 8)
                    .foregroundColor(index == self.currentIndex ? selectColor  : unselectColor)
//                    .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                    .padding(.bottom, 8)
                    .animation(.spring())
            }
        }
    }
}

struct ImageCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        
        // 8
        Carousel(numberContent: 3, content: {geometry in
                AsyncImage(url: URL(string: "https://hws.dev/paul.jpg"), content: {p in
                    switch p {
                    case .failure:
                        Image(systemName: "photo")
                            .font(.largeTitle)
                    case.success(let image):
                        image.resizable()
                    default:
                        ProgressView()
                    }
                })
                .scaledToFill()
                .frame(width: geometry.size.width, height: geometry.size.height)
                .clipped()
                AsyncImage(url: URL(string: "https://hws.dev/paul.jpg"), content: {p in
                    switch p {
                    case .failure:
                        Image(systemName: "photo")
                            .font(.largeTitle)
                    case.success(let image):
                        image.resizable()
                    default:
                        ProgressView()
                    }
                })
                .scaledToFill()
                .frame(width: geometry.size.width, height: geometry.size.height)
                .clipped()
                AsyncImage(url: URL(string: "https://hws.dev/paul.jpg"), content: {p in
                    switch p {
                    case .failure:
                        Image(systemName: "photo")
                            .font(.largeTitle)
                    case.success(let image):
                        image.resizable()
                    default:
                        ProgressView()
                    }
                })
                .scaledToFill()
                .frame(width: geometry.size.width, height: geometry.size.height)
                .clipped()
            }
        , indicator: { b,n in
            Indicator(currentIndex: b, numberContent: n)
        })
            .frame(width: .infinity, height: 300, alignment: .center)
    }
}
