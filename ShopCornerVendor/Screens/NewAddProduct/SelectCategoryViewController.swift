//
//  SelectCategoryViewController.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 12/01/25.
//

import UIKit

class SelectCategoryViewController: UIViewController {
    
    var openOtherCategory: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSwiftUIView(view: SelectCategoryView(dismiss: {[weak self] in
            self?.dismiss(animated: true)
            
        }, selectOther: {[weak self] in
            self?.dismiss(animated: true)
            self?.openOtherCategory?()
        }), transprent: true)
    }

}
