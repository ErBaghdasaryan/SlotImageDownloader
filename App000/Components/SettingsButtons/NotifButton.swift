//
//  NotifButton.swift
//  App000
//
//  Created by Er Baghdasaryan on 13.02.25.
//

import UIKit
import SnapKit
import OneSignalFramework

class NotifButton: UIButton {

    private let toggleSwitch = UISwitch()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        self.backgroundColor = UIColor(hex: "#2E2E2E")
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = UIFont(name: "SFProText-Regular", size: 17)
        self.contentHorizontalAlignment = .left
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
        self.layer.cornerRadius = 16
        self.layer.masksToBounds = false

        toggleSwitch.onTintColor = UIColor(hex: "#0084FF")
        toggleSwitch.isOn = false
        toggleSwitch.addTarget(self, action: #selector(notifySwitchChanged), for: .valueChanged)

        self.addSubview(toggleSwitch)

        toggleSwitch.snp.makeConstraints { view in
            view.trailing.equalToSuperview().inset(16)
            view.centerY.equalToSuperview()
            view.width.equalTo(51)
            view.height.equalTo(31)
        }
    }

    func isSwitchOn() -> Bool {
        return toggleSwitch.isOn
    }

    @objc func notifySwitchChanged() {
        if toggleSwitch.isOn {
            enablePushNotifications()
        } else {
            disablePushNotifications()
        }

        UserDefaults.standard.set(toggleSwitch.isOn, forKey: "pushNotificationsEnabled")
    }

    private func enablePushNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                OneSignal.Notifications.requestPermission { accepted in
                    if accepted {
                        print("Notifications enabled")
                    }
                }
            } else {
                print("Notifications permission denied")
            }
        }
    }

    private func disablePushNotifications() {
        OneSignal.User.pushSubscription.optOut()
    }

    func setSwitchState(_ isOn: Bool) {
        toggleSwitch.setOn(isOn, animated: true)
    }
}
