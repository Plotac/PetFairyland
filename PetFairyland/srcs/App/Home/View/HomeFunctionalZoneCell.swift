//
//  HomeFunctionalZoneCell.swift
//  PetFairyland
//
//  Created by Ja on 2023/9/21.
//

import UIKit

protocol HomeFunctionalZoneCellDelegate: NSObjectProtocol {
    func didSelect(item: HomeFunctionItem)
}

class HomeFunctionalZoneCell: UITableViewCell {
    
    let cellMargin: CGFloat = 12
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set {
            var frame = newValue
            frame.origin.x += cellMargin
            frame.size.width -= 2 * cellMargin
            super.frame = frame
        }
    }
    
    var zone: HomeFunctionZone? {
        didSet {
            if let zone = zone {
                zoneTitleLab.text = zone.title
                
                collectinView.reloadData()
            }
        }
    }
    
    weak var delegate: HomeFunctionalZoneCellDelegate?
    
    lazy var zoneTitleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = .black
        lab.font = UIFont.pingfang(style: .medium, size: 16)
        return lab
    }()
    
    lazy var collectinView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.dataSource = self
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.register(HomeFunctionCell.self, forCellWithReuseIdentifier: HomeFunctionCell.reuseIdentity())
        return cv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeFunctionalZoneCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { zone?.functionItems.count ?? 0 }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeFunctionCell.reuseIdentity(), for: indexPath) as? HomeFunctionCell ?? HomeFunctionCell()
        cell.item = zone?.functionItems.safeIndex(newIndex: indexPath.item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let item = zone?.functionItems.safeIndex(newIndex: indexPath.item) {
            delegate?.didSelect(item: item)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let zone = zone else { return .zero }
        let width: CGFloat = (Screen.width - cellMargin * 2) / CGFloat(zone.maxiNumberOfDisplaysPerRow)
        return CGSize(width: width, height: zone.itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return zone?.minimumLineSpacing ?? 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return zone?.minimumInteritemSpacing ?? 0
    }
    
}

extension HomeFunctionalZoneCell {
    func setupUI() {
        contentView.addSubview(zoneTitleLab)
        zoneTitleLab.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.left.equalToSuperview().offset(12)
        }
        
        contentView.addSubview(collectinView)
        collectinView.snp.makeConstraints { make in
            make.top.equalTo(zoneTitleLab.snp.bottom).offset(15)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(15)
        }
    }
}
