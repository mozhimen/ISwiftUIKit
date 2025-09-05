//
//  Grid.swift
//  ISwiftUIKit.Grid
//
//  Created by Taiyou on 2025/7/18.
//
import SwiftUI
import SUtilKit_SwiftUI

public struct GridFixed<T,Content:View>:View {
    let _datas:[T]
    let _columnCount:Int
    var _alignment: Alignment = .center
    var _horizontalSpacing: CGFloat? = nil
    var _verticalSpacing: CGFloat? = nil
    let _content: IAB_CListener<T,Int,Content>
    private var _rowCount: Int {
        UtilKInt.intCeil(a: _datas.count, b: _columnCount)//行数
    }
    private var _isSingleRow: Bool {
        _datas.count <= _columnCount
    }
    
    private var _remainingItemsCount: Int {
        _isSingleRow ? _columnCount - _datas.count : 0
    }
    
    public init(datas:[T],columnCount:Int,alignment: Alignment = .center, horizontalSpacing: CGFloat? = nil, verticalSpacing: CGFloat? = nil, @ViewBuilder content:@escaping IAB_CListener<T,Int,Content>) {
        _datas = datas
        _columnCount = columnCount
        _alignment = alignment
        _horizontalSpacing = horizontalSpacing
        _verticalSpacing = verticalSpacing
        _content = content
    }
    
    private func items(forRow row: Int) -> ArraySlice<T> {
        let start = row * _columnCount
        let end = min(start + _columnCount, _datas.count)
        return _datas[start..<end]
    }
    
    public var body: some View {
        if _datas.isNotEmpty()&&_columnCount>0 {
            Grid(alignment: _alignment,horizontalSpacing: _horizontalSpacing,verticalSpacing: _verticalSpacing, content: {
                ForEach.init(0..<_rowCount,id: \.self, content: { indexRow in
                    GridRow.init(content: {
                        ForEach(Array(items(forRow: indexRow).enumerated()), id: \.offset) { (column, item) in
                            _content(item, indexRow * _columnCount + column)
                        }
                        // 仅当只有一行且不足时补充Spacer
                        if _isSingleRow && _remainingItemsCount > 0 {
                            ForEach(0..<_remainingItemsCount, id: \.self) { _ in
                                Spacer()
                                    .frame(maxWidth: .infinity)
                            }
                        }
                    })
                })
            })
        }
    }
}

#Preview(body: {
    GridFixed(datas: ["1","2","3","4"], columnCount: 6, content: {data,index in
        Text(data)
            .frame(maxWidth: .infinity)
    })
    .frame(maxWidth: .infinity)
})
