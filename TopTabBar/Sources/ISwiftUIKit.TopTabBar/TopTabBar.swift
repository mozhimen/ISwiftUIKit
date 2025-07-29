//
//  TopTabBar.swift
//  ISwiftUIKit.TopTabBar
//
//  Created by Taiyou on 2025/7/21.
//
import SwiftUI
import SUtilKit_SwiftUI

public struct TopTabBar<T,V:View>: View {
    @State private var _indexSelected: Int = 0 {
        didSet{
            _selectListener?(_datas[_indexSelected], _indexSelected)
        }
    }
    private var _datas: [T]
    private var _content: IABC_DListener<T,Int,Int,V>
    private var _selectListener: IAB_Listener<T,Int>? = nil
    private let _leftOffset: CGFloat = 0.1
    
    public init(
        datas: [T],
        @ViewBuilder content:@escaping IABC_DListener<T, Int, Int, V>,
        indexDefault:Int = 0,
        selectListener: IAB_Listener<T, Int>? = nil) {
            self._datas = datas
            self._content = content
            self._indexSelected = indexDefault
            self._selectListener = selectListener
        }
    
    public var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false){
                HStack {
                    ForEach(_datas.indices, id:\.self, content: {index in
                        _content(_datas[index],index,_indexSelected)
                            .onTapGesture {
                                withAnimation{
                                    _indexSelected = index
                                }
                            }
                    })
                }
            }.onChange(of: _indexSelected) { value in
                withAnimation() {
                    proxy.scrollTo(value, anchor: UnitPoint(x: UnitPoint.leading.x + _leftOffset, y: UnitPoint.leading.y))
                    print("value \(value) x \(UnitPoint.leading.x)")
                }
            }.animation(.easeInOut)
        }
    }
    
}

//struct TabBarView: View {
//    @Binding var index: Int
//    var titles = ["Home", "NewTab1","NewTab2","NewTab3","NewTab4"]
//    var body: some View {
//        ScrollViewReader { proxy in
//            ScrollView(.horizontal, showsIndicators: false){
//                HStack {
//                    ForEach(titles.indices) {id in
//                        let title = Text(titles[id]).id(id)
//                            .onTapGesture {
//                                withAnimation() {
//                                    index = id
//                                }
//                            }
//                        if self.index == id {
//                            title.foregroundColor(.black)
//                        } else {
//                            title.foregroundColor(.gray)
//                        }
//                    }
//                    .font(.title)
//                    .padding(.top, 50)
//                    .padding(.horizontal, 5)
//                }
//                .padding(.leading, 20)
//            }.onChange(of: index) { value in
//                withAnimation() {
//                    proxy.scrollTo(value, anchor: UnitPoint(x: UnitPoint.leading.x + leftOffset, y: UnitPoint.leading.y))
//                }
//            }.animation(.easeInOut)
//        }
//    }
//    private let leftOffset: CGFloat = 0.1
//}
let items = ["首页", "发现", "消息", "我的","其他","特色"]

#Preview {
    TopTabBar(
        datas: items,
        content: { item, index, selectedIndex in
            Text(item)
                .padding()
                .background(selectedIndex == index ? Color.blue : Color.gray)
                .foregroundColor(.white)
                .cornerRadius(8)
        },
        selectListener: { item, index in
            print("选择了: \(item) at \(index)")
        }
    )
}
