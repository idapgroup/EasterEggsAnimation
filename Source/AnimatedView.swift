//
//  AnimatedView.swift
//  DiagonalAnimationSwiftUI
//
//  Created by Alexander Ermakov on 12.02.2024.
//  Copyright © 2024 IDAP. All rights reserved.
	

import UIKit

public final class AnimatedView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: -
    // MARK: Variables
    
    var xOffset: CGFloat = 0
    var yOffset: CGFloat = 0
    
    private var collectionView: UICollectionView?
    private var displayLink = CADisplayLink()
    
    private let patternImage: UIImage?
    private let divider: CGFloat
    private let dates: [String]
    
    // MARK: -
    // MARK: Initializations
    
    public init(patternImage: UIImage?, divider: CGFloat = 1000, dates: [String] = []) {
        self.patternImage = patternImage
        self.divider = divider
        self.dates = dates
        
        super.init(frame: .zero)
        
        self.backgroundColor = .clear
        self.isUserInteractionEnabled = false
        self.prepareCollection()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: Public functions
    
    public func animate() {
        self.displayLink = CADisplayLink(target: self, selector: #selector(self.animateCollection))
        self.displayLink.add(to: .main, forMode: .common)
    }
    
    // MARK: -
    // MARK: Private functions
    
    private func prepareCollection() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY/MM/dd"
        if !self.dates.isEmpty && !dates.contains(dateFormatter.string(from: Date.now)) {
            return
        }
        
        self.collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: self.collectionLayout()
        )
        
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        self.collectionView?.backgroundColor = .clear
        self.collectionView?.contentInsetAdjustmentBehavior = .never
        self.collectionView?.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView?.register(
            OuterCollectionViewCell.self,
            forCellWithReuseIdentifier: String(describing: OuterCollectionViewCell.self)
        )
        
        self.addSubview(self.collectionView ?? UIView())
        
        guard let collectionView else { return }
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    private func collectionLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalHeight(1.0)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(2.0),
            heightDimension: .fractionalHeight(1.0)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    @objc private func animateCollection() {
        guard let collectionView else { return }
        let collectionWidth = collectionView.contentSize.width
        let collectionHeight = collectionView.contentSize.height

        if
            self.xOffset <= collectionWidth - self.bounds.width
            && self.yOffset <= collectionHeight - self.bounds.height
        {
            self.xOffset += collectionWidth / self.divider
            self.yOffset += collectionHeight / self.divider
            self.collectionView?.contentOffset.x = self.xOffset
            self.collectionView?.contentOffset.y = self.yOffset
        } else {
            self.xOffset = 0
            self.yOffset = 0
        }
    }
    
    // MARK: -
    // MARK: UICollectionViewDelegate, UICollectionViewDataSource
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: OuterCollectionViewCell.self),
            for: indexPath
        ) as? OuterCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configureWith(patternImage: self.patternImage)
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.bounds.width, height: self.bounds.height)
    }
}

fileprivate class OuterCollectionViewCell: UICollectionViewCell {
    
    // MARK: -
    // MARK: Variables
    
    private let imageView = UIImageView()
    
    // MARK: -
    // MARK: Initializations
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        self.prepare()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: Public funcitons
    
    public func configureWith(patternImage: UIImage?) {
        self.imageView.image = patternImage
    }
    
    // MARK: -
    // MARK: Private functions
    
    private func prepare() {
        self.contentView.addSubview(self.imageView)
        self.imageView.contentMode = .scaleToFill
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ])
    }
}
