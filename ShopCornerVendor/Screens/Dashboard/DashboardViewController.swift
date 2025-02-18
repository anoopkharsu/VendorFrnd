//
//  DashboardViewController.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 05/12/24.
//

import UIKit

class DashboardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }


    @IBAction func pressed(_ sender: UIButton) {
        let ff = DashboardViewController()
        navigationController?.pushViewController(ff, animated:true)
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
