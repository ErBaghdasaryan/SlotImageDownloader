//
//  PrivacyAndTermsButton.swift
//  App000
//
//  Created by Er Baghdasaryan on 07.02.25.
//

import UIKit
import SnapKit

public class PrivacyAndTermsButton: UIView {

    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    public let readButton = UIButton(type: .system)

    public init(title: String, icon: UIImage?) {
        super.init(frame: .zero)
        setupView(title: title, icon: icon)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView(title: "Default Title", icon: UIImage(systemName: "person.2.fill"))
    }
    
    private func setupView(title: String, icon: UIImage?) {
        backgroundColor = UIColor(hex: "#CAECFF")

        layer.cornerRadius = 12

        iconImageView.image = icon
        iconImageView.tintColor = .black

        titleLabel.text = title
        titleLabel.font = UIFont(name: "SFProText-Bold", size: 17)
        titleLabel.textColor = .black

        readButton.setTitle("Read", for: .normal)
        readButton.setTitleColor(.black, for: .normal)
        readButton.backgroundColor = UIColor(hex: "#37A2F4")
        readButton.layer.cornerRadius = 17

        addSubview(iconImageView)
        addSubview(titleLabel)
        addSubview(readButton)

        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(24)
        }

        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(6)
            make.centerY.equalToSuperview()
        }

        readButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.width.equalTo(63)
            make.height.equalTo(34)
        }
    }
}
