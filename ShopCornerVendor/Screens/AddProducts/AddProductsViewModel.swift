//
//  AddProductViewModel.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 08/12/24.
//


import SwiftUI

class AddProductsViewModel: ObservableObject {
    @Published var product = AddProductsModel()
    @Published var navigateToAddProduct: Bool = false
    @Published var isLoading: Bool = false
    @Published var errorMessage: SCToastMessage?
    @Published var showError = false
    let repository = AddProductsRepository()
    
    var products:[SCProduct] {
        product.products
    }
    
    func getSelectedCategory() -> Category? {
        categories.first(where: { $0.name == product.parentCategory1 })
    }
    
    func getSelectedTypes() -> [String]? {
        categories.first(where: { $0.name == product.parentCategory1 })?.subcategories.first(where: { $0.name == product.parentCategory2 })?.types
    }
    
    func addProduct(product: SCProduct) {
        navigateToAddProduct = false
        self.product.addProduct(product: product)
    }
    
    func validateAndSaveProducts(dismiss: @escaping () -> Void) {
        self.isLoading = true
        uploadNextProduct(at: 0, completion: {[weak self] error in
            self?.isLoading = false
            if let error {
                self?.showError = true
                self?.errorMessage = .init(message: error.localizedDescription, type: .error)
                print("Error uploading products: \(error)")
            } else {
                dismiss()
            }
            
        })
        
    }
    
  
    
    private func uploadNextProduct(at index: Int, completion: @escaping (Error?) -> Void) {
        if index >= self.products.count {
            completion(nil)
            return
        }
        let product = products[index]
        
        guard let image = product.productImage else {
            print("Product \(product.name) has no image. Skipping.")
            uploadNextProduct(at: index + 1, completion: completion)
            return
        }
        
        uploadImage(image) {[weak self] url, error in
            if let error {
                completion(error)
                return
            }
            if let url {
                self?.uploadProduct(product, url: url) { error in
                    if let error {
                        completion(error)
                        return
                    }
                    self?.uploadNextProduct(at: index + 1, completion: completion)
                }
            } else {
                completion(SCError(localizedDescription: "Upload failed"))
            }

        }
    }
    
    // Modify uploadImage and uploadProduct to use completion handlers
    func uploadImage(_ image: UIImage, completion: @escaping (String?, Error?) -> Void) {
        guard let imageData = image.resized() else {
            completion(nil,SCError(localizedDescription: "Invaild image"))
            return
        }
        let uploadRequest = SettingsModels.UploadImage.Request(fileName: "product.jpg", fileType: "image/jpeg")
        
        repository.getuploadURL(.uploadImage(request: uploadRequest)) { uploadData, error in
           
            
            if let error = error {
                completion(nil,error)
                return
            }
            
            guard let uploadData = uploadData,
                  let uploadURL = URL(string: uploadData.uploadUrl) else {
                completion(nil,SCError(localizedDescription: "Invaild upload URL"))
                return
            }
            
            SCNetwork.shared.uploadImage(to: uploadURL, imageData: imageData) { uploadError in
                if let uploadError {
                    completion(nil,uploadError)
                } else {
                    completion(uploadData.fileKey,nil)
                }
            }
        }
    }
//    
    func uploadProduct(_ product: SCProduct, url: String, completion: @escaping (Error?) -> Void) {
        let vendId = AuthService.shared.getVendor().id
        var product = product
        product.imageURL = url
        repository.addProduct(product) { _, error in
            completion(error)
        }
        // Implement similar to the async version but use completion handlers
    }
    
    //    AddProductsRepository
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    let categories: [Category] = [
        
        Category(
            name: "Groceries & Staples",
            subcategories: [
                Subcategory(
                    name: "Fruits & Vegetables",
                    icon: "basket_fruits_vegetables",
                    types: [
                        "Fruits",
                        "Vegetables",
                        "Exotic Fruits",
                        "Organic Vegetables"
                    ]
                ),
                Subcategory(
                    name: "Dairy, Bread & Eggs",
                    icon: "milk_bread_egg",
                    types: [
                        "Milk",
                        "Bread",
                        "Eggs",
                        "Cheese"
                    ]
                ),
                Subcategory(
                    name: "Atta, Rice, Oil & Dals",
                    icon: "grain_sack",
                    types: [
                        "Atta",
                        "Rice",
                        "Cooking Oil",
                        "Dals"
                    ]
                ),
                Subcategory(
                    name: "Meats, Fish & Eggs",
                    icon: "meat_fish_eggs",
                    types: [
                        "Chicken",
                        "Fish",
                        "Eggs",
                        "Mutton"
                    ]
                ),
                Subcategory(
                    name: "Masala & Dry Fruits",
                    icon: "spice_jar_nuts",
                    types: [
                        "Spices",
                        "Dry Fruits",
                        "Masala Mixes",
                        "Herbs"
                    ]
                )
            ]
        ),
        Category(
            name: "Snacks & Beverages",
            subcategories: [
                Subcategory(
                    name: "Snacks & Drinks",
                    icon: "chips_soda",
                    types: [
                        "Chips",
                        "Soft Drinks",
                        "Savory Snacks",
                        "Sweets"
                    ]
                ),
                Subcategory(
                    name: "Tea, Coffee & More",
                    icon: "steaming_cup",
                    types: [
                        "Tea",
                        "Coffee",
                        "Green Tea",
                        "Herbal Tea"
                    ]
                ),
                Subcategory(
                    name: "Breakfast & Sauces",
                    icon: "toast_sauce",
                    types: [
                        "Spreads",
                        "Sauces",
                        "Cereal",
                        "Jam"
                    ]
                ),
                Subcategory(
                    name: "Packaged Food",
                    icon: "sealed_box",
                    types: [
                        "Ready-to-Eat",
                        "Noodles",
                        "Soups",
                        "Canned Goods"
                    ]
                ),
                Subcategory(
                    name: "Ice Creams & More",
                    icon: "ice_cream_cone",
                    types: [
                        "Ice Cream",
                        "Frozen Desserts",
                        "Popsicles"
                    ]
                ),
                Subcategory(
                    name: "Frozen Food",
                    icon: "snowflake_package",
                    types: [
                        "Frozen Vegetables",
                        "Frozen Snacks",
                        "Ready-to-Cook"
                    ]
                ),
                Subcategory(
                    name: "Sweet Cravings",
                    icon: "chocolate_candy",
                    types: [
                        "Chocolates",
                        "Candies",
                        "Mithai"
                    ]
                ),
                Subcategory(
                    name: "Cold Drinks & Juices",
                    icon: "glass_citrus",
                    types: [
                        "Juices",
                        "Soft Drinks",
                        "Energy Drinks"
                    ]
                ),
                Subcategory(
                    name: "Munchies",
                    icon: "snack_bowl",
                    types: [
                        "Trail Mix",
                        "Dry Snacks",
                        "Crunchy Snacks"
                    ]
                ),
                Subcategory(
                    name: "Biscuits & Cookies",
                    icon: "cookie_bite",
                    types: [
                        "Cream Biscuits",
                        "Plain Biscuits",
                        "Cookies"
                    ]
                ),
                Subcategory(
                    name: "Paan Corner",
                    icon: "betel_leaf",
                    types: [
                        "Paan",
                        "Supari",
                        "Mukhwas"
                    ]
                )
            ]
        ),
        Category(
            name: "Beauty & Personal Care",
            subcategories: [
                Subcategory(
                    name: "Makeup & Beauty",
                    icon: "lipstick",
                    types: [
                        "Lipstick",
                        "Foundation",
                        "Eye Makeup",
                        "Blush"
                    ]
                ),
                Subcategory(
                    name: "Skincare",
                    icon: "lotion_bottle",
                    types: [
                        "Moisturizers",
                        "Face Wash",
                        "Sunscreen"
                    ]
                ),
                Subcategory(
                    name: "Bath & Body",
                    icon: "soap_bubbles",
                    types: [
                        "Soap",
                        "Shower Gel",
                        "Bath Bombs"
                    ]
                ),
                Subcategory(
                    name: "Hair Care",
                    icon: "shampoo_comb",
                    types: [
                        "Shampoo",
                        "Conditioner",
                        "Hair Oil",
                        "Serums"
                    ]
                ),
                Subcategory(
                    name: "Fragrances & Grooming",
                    icon: "perfume_bottle",
                    types: [
                        "Perfume",
                        "Deodorant",
                        "Aftershave"
                    ]
                ),
                Subcategory(
                    name: "Feminine Hygiene",
                    icon: "blossom",
                    types: [
                        "Sanitary Napkins",
                        "Tampons",
                        "Pantyliners"
                    ]
                ),
                Subcategory(
                    name: "Sexual Wellness",
                    icon: "heart_shield",
                    types: [
                        "Condoms",
                        "Lubricants",
                        "Intimate Wash"
                    ]
                ),
                Subcategory(
                    name: "Baby Care",
                    icon: "baby_bottle",
                    types: [
                        "Diapers",
                        "Baby Food",
                        "Baby Skincare"
                    ]
                )
            ]
        ),
        Category(
            name: "Apparel & Lifestyle",
            subcategories: [
                Subcategory(
                    name: "Jewellery & Accessories",
                    icon: "necklace",
                    types: [
                        "Necklaces",
                        "Earrings",
                        "Rings",
                        "Bracelets"
                    ]
                ),
                Subcategory(
                    name: "Apparel & Lifestyle",
                    icon: "tshirt",
                    types: [
                        "Casual Wear",
                        "Formal Wear",
                        "Ethnic Wear"
                    ]
                )
            ]
        ),
        Category(
            name: "Health & Wellness",
            subcategories: [
                Subcategory(
                    name: "Pharma & Wellness",
                    icon: "capsule_leaf",
                    types: [
                        "Medicines",
                        "Supplements",
                        "First Aid"
                    ]
                )
            ]
        ),
        Category(
            name: "Home & Household Essentials",
            subcategories: [
                Subcategory(
                    name: "Household Essentials",
                    icon: "house_broom",
                    types: [
                        "Cleaning Supplies",
                        "Detergents",
                        "Disinfectants"
                    ]
                ),
                Subcategory(
                    name: "Home Needs",
                    icon: "home_heart",
                    types: [
                        "Furniture",
                        "Decor",
                        "Storage"
                    ]
                ),
                Subcategory(
                    name: "Kitchenware & Appliances",
                    icon: "saucepan",
                    types: [
                        "Cookware",
                        "Utensils",
                        "Small Appliances"
                    ]
                ),
                Subcategory(
                    name: "Cleaning Essentials",
                    icon: "spray_bottle",
                    types: [
                        "Mops",
                        "Brushes",
                        "Cloths"
                    ]
                )
            ]
        ),
        Category(
            name: "Electronics & Appliances",
            subcategories: [
                Subcategory(
                    name: "Electronics & Appliances",
                    icon: "tv_screen",
                    types: [
                        "TVs",
                        "Washing Machines",
                        "Refrigerators",
                        "Microwaves"
                    ]
                )
            ]
        ),
        Category(
            name: "Miscellaneous",
            subcategories: [
                Subcategory(
                    name: "Pet Care",
                    icon: "paw_print",
                    types: [
                        "Pet Food",
                        "Pet Toys",
                        "Grooming Supplies"
                    ]
                ),
                Subcategory(
                    name: "Toys & Sports",
                    icon: "football_toy",
                    types: [
                        "Action Figures",
                        "Board Games",
                        "Sports Equipment"
                    ]
                ),
                Subcategory(
                    name: "Stationery & Crafts",
                    icon: "pencil_scissors",
                    types: [
                        "Pens",
                        "Paper",
                        "Craft Supplies"
                    ]
                )
            ]
        )
    ]
    
}


import Foundation

struct Subcategory: Identifiable {
    let id = UUID() // Unique ID for each subcategory
    let name: String
    let icon: String
    let types: [String]
}

struct Category: Identifiable {
    let id = UUID() // Unique ID for each category
    let name: String
    let subcategories: [Subcategory]
}
