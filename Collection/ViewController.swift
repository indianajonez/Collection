//
//  ViewController.swift
//  Collection
//
//  Created by Ekaterina Saveleva on 27.07.2023.
//

import UIKit

class ViewController: UIViewController {
    
    
    // MARK: - Private properties

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 30
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16)//(top: 0, left: 10, bottom: 20, right: 10)

        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .systemBackground
        collection.delegate = self
        collection.dataSource = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        //collection.showsHorizontalScrollIndicator = false
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
        return collection
    }()

    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Colllection"
        view.addSubview(collectionView)
        setupConstraits()
        
        }
    
    
    // MARK: - Private methods
    
    private func setupConstraits() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}



// MARK: - UICollectionViewDelegateFlowLayout

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_
                        collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width: CGFloat = view.frame.width - 50
        let height: CGFloat = collectionView.frame.height / 1.5
        return CGSize(width: width, height: height)
    }
    
    func scrollViewWillEndDragging(_
                                   scrollView: UIScrollView,
                                   withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>
    ){
           let pageWidth: CGFloat = view.frame.width - 50
           let cellWidth = pageWidth + 10
           let targetContentOffsetXPoint = targetContentOffset.pointee.x / cellWidth
           targetContentOffset.pointee.x = round(targetContentOffsetXPoint) * cellWidth - 20
       }
   }



// MARK: - UICollectionViewDataSource

extension ViewController: UICollectionViewDataSource {
       func collectionView( _
                            collectionView: UICollectionView,
                            numberOfItemsInSection section: Int
       ) -> Int { 10 }

       func collectionView(_
                           collectionView: UICollectionView,
                           cellForItemAt indexPath: IndexPath
       ) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "collectionCell",
            for: indexPath
           )
           cell.backgroundColor = UIColor.init(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1
           )
           cell.layer.cornerRadius = 10
           return cell
       }
   }
