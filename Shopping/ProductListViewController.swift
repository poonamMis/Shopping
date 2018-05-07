//
//  ViewController.swift
//  Shopping
//
//  Created by king on 4/24/18.
//  Copyright © 2018 king. All rights reserved.
//

import UIKit

class ProductListViewController: UIViewController , UICollectionViewDataSource, UICollectionViewDelegate{

    @IBOutlet weak var collectionView: UICollectionView!
    var arrProduct = [Product]()
    var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("In 1st tab")
        
        self.navigationItem.title = "Shopping"
        
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 140, height: 185)
        self.collectionView?.collectionViewLayout = layout
        
        /*
        let imgTop = UIImage.init(named: "top")!
        let imgJeans = UIImage.init(named: "jeans")!
        let imgGlers = UIImage.init(named: "sunglasses")!
        let imgWatch = UIImage.init(named: "watch")!
        let imgShooes = UIImage.init(named: "shooes")!
        
        arrProduct.append(Product.init(name: "VeroModa Top", price: 999.0, image: imgTop)!)
        arrProduct.append(Product.init(name: "Levi's Jeans", price: 3200.0, image: imgJeans)!)
        arrProduct.append(Product.init(name: "Glare", price: 700.0, image: imgGlers)!)
        arrProduct.append(Product.init(name: "Watch", price: 2000.0, image: imgWatch)!)
        arrProduct.append(Product.init(name: "Shooes", price: 900.0, image: imgShooes)!)
        */
        
        self.getProductList()
    }

    func getProductList(){
        let strUrl: String = "https://mobiletest-hackathon.herokuapp.com/getdata/"
        let url: URL = URL(string: strUrl)!
        let request: NSMutableURLRequest = NSMutableURLRequest.init(url: url)
        request.httpMethod = "GET"
        
        let connection: URLSession = URLSession.shared
        
        let task = connection.dataTask(with: url) { (data, response, error) in
            
            guard let _=data, error == nil else{
                return
            }
            
            do{
                let jsonDecoder = JSONDecoder()
                let product =  try jsonDecoder.decode([String:[Product]].self, from: data!)
                self.arrProduct = product["products"]!
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
                print(product)

            }catch let error as NSError {
                print(error)
            }
        }
        
        task.resume()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrProduct.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as? ProductCollectionViewCell else{
            fatalError("Can not create cell")
        }
        
        let product = arrProduct[indexPath.row]
        
        // cell.productImage.image = UIImage.init(named: product.productImage!)
        cell.productName.text = product.productName
        cell.productPrice.text =  String(product.ProductPrice)
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

