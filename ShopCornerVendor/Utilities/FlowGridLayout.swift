//
//  FlowGridLayout.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 20/12/24.
//


import SwiftUI

/// Holds the parent view's size so that we can recalculate height on preference changes
var sizeODD = CGSize.zero

struct DynamicWidthGrid<Data: RandomAccessCollection, Content: View>: View where Data.Element: Hashable, Data.Index == Int {

    @Binding var height: CGFloat
    let items: Data
    @ViewBuilder let content: (Data.Element) -> Content
    
    /// Stores computed sizes for each item
    @State private var itemSizes: [Data.Element: CGSize] = [:]

    var body: some View {
        GeometryReader { geometry in
            generateGrid(in: geometry.size)
        }
        .onPreferenceChange(ItemWidthPreferenceKey.self) { preferences in
            preferences.forEach { preference in
                // Safely cast to our Data.Element type
                guard let element = preference.key as? Data.Element else { return }
                itemSizes[element] = preference.value
            }
            // Recalculate the total height on the main thread to avoid layout warnings
            DispatchQueue.main.async {
                height = calculateHeight(in: sizeODD)
            }
        }
    }
    
    // MARK: - Private Helpers
    
    /// Builds rows by grouping items that fit in the given width
    private func buildRows(in size: CGSize) -> [[Data.Element]] {
        var rows: [[Data.Element]] = [[]]
        var currentRowWidth: CGFloat = 0
        
        for item in items {
            let itemSize = itemSizes[item, default: CGSize(width: size.width, height: 40)]
            // If adding this item exceeds the available width, start a new row
            if currentRowWidth + itemSize.width > size.width {
                rows.append([item])
                currentRowWidth = itemSize.width
            } else {
                rows[rows.endIndex - 1].append(item)
                currentRowWidth += itemSize.width
            }
        }
        
        return rows
    }

    /// Calculates total height of all rows (including spacing) based on measured item sizes
    private func calculateHeight(in size: CGSize) -> CGFloat {
        let rows = buildRows(in: size)
        var totalHeight: CGFloat = 0
        
        for (index, row) in rows.enumerated() {
            // Find the max height in the current row
            let rowHeight = row
                .map { itemSizes[$0, default: CGSize(width: size.width, height: 40)].height }
                .max() ?? 0
            
            totalHeight += rowHeight
            // Add row spacing unless it's the last row
            if index < rows.count - 1 {
                totalHeight += 10
            }
        }
        
        return totalHeight
    }

    /// Uses rows to build a vertical stack of HStacks
    private func generateGrid(in size: CGSize) -> some View {
        // Store the size so we can update height later
        sizeODD = size

        let rows = buildRows(in: size)
        
        return VStack(alignment: .leading, spacing: 0) {
            ForEach(rows.indices, id: \.self) { rowIndex in
                HStack(alignment: .top,spacing: 0) {
                    ForEach(rows[rowIndex], id: \.self) { item in
                        content(item)
                            .background(
                                WidthGetter(item: item)
                            )
                    }
                }
            }
        }
    }
}

// MARK: - Helpers for measuring item widths/heights

struct WidthGetter<Item: Hashable>: View {
    let item: Item

    var body: some View {
        GeometryReader { geometry in
            Color.clear
                .preference(
                    key: ItemWidthPreferenceKey.self,
                    value: [item: CGSize(width: geometry.size.width, height: geometry.size.height)]
                )
        }
    }
}

struct ItemWidthPreferenceKey: PreferenceKey {
    typealias Value = [AnyHashable: CGSize]

    static var defaultValue: [AnyHashable: CGSize] = [:]

    static func reduce(value: inout [AnyHashable: CGSize], nextValue: () -> [AnyHashable: CGSize]) {
        value.merge(nextValue()) { $1 }
    }
}

