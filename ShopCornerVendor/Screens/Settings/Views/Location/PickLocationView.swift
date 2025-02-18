//
//  PickLocationView.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 16/02/25.
//

import SwiftUI
import CoreLocation

struct PickLocationView: View {
    @State private var zoomLevel: Float = 18
    @State var centerCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    let comfirmLocation: (CLLocationCoordinate2D) -> Void
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            ZStack {
                // The representable that wraps GMSMapView
                GoogleMapView(centerCoordinate: $centerCoordinate,
                              zoomLevel: $zoomLevel)
                
                // Overlays: the pin + tooltip + back button
                // 1) Center pin
                VStack(spacing: 4) {
                    Image(systemName: "mappin")
                    //                            .fill(Color.orange)
                        .font(.largeTitle)
                        .frame(width: 30, height: 30)
                        .shadow(color: .black.opacity(0.2),radius: 3, x: 0, y: 2)
                        .transformEffect(.init(translationX: 0, y: -15))
                }
            }
            HStack {
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                }
                
                Button {
                    comfirmLocation(centerCoordinate)
                } label: {
                    Text("Confirm Location")
                }
            }
        }
    }
}
