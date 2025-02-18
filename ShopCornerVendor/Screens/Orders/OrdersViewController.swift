//
//  OrdersViewController.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 07/12/24.
//

import UIKit
import MapKit

class OrdersViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addSwiftUIView(view: OrdersView(shareLocation: {[weak self] lat, long in
            self?.shareMapItem(latitude: lat, longitude: long)
        }))
    }


    
    func shareMapItem(latitude: Double, longitude: Double) {
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let placemark = MKPlacemark(coordinate: coordinate)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "Shared Location"
        let url = URL(string: "https://www.google.com/maps/search/?api=1&query=\(latitude),\(longitude)")!
        
        let activityVC = UIActivityViewController.init(activityItems: [url], applicationActivities: nil)
        
        if let popover = activityVC.popoverPresentationController {
            popover.sourceView = self.view
            popover.sourceRect = CGRect(x: self.view.bounds.midX,
                                        y: self.view.bounds.midY,
                                        width: 0,
                                        height: 0)
            popover.permittedArrowDirections = []
        }
        
        self.present(activityVC, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
