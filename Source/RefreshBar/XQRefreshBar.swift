//
//  XQRefreshBar.swift
//  XQUIKit
//
//  Created by LaiXuefei on 2020/7/7.
//  Copyright © 2020 LaiXuefei. All rights reserved.
//

import UIKit
import Foundation
import SnapKit
import XQFoundation

public typealias DidClickRefreshBtn = (_ status: XQBarStatus) -> Void

private let kRotationAnimationKey: String = "XQUIKit_rotationAnimation"
private let fShowDuration: Double = 0.3
private let fHideDuration: Double = 0.25
private let fShowSucessedDuration: Double = 2.0

// 刷新栏（需外部自行添加到视图上，并根据回调方法做显示和隐藏）
public class XQRefreshBar: UIView {
    private let contentView = UIView()
    private let detailsLabel = UILabel()
    private let iconImgView = UIImageView()
    private let refreshBtn = UIButton(type: .custom)
    private var bIsShowed = false
    private var currentStatus: XQBarStatus = .unknown {
        willSet {
            if newValue != currentStatus {
                updateUIWithStatus(newValue)
            }
        }
    }
    private let topMargin: Float
    private let barHeight:Float = 56.0

    public var refreshBlock: DidClickRefreshBtn?

// MARK: Life Func
    // 初始化
    public init(supView: UIView, topMargin: Float) {
        self.topMargin = topMargin
        super.init(frame: CGRect.zero)
        supView.addSubview(self)
        setUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

// MARK: Private Func
    // UI布局
    private func setUI() {
        self.backgroundColor = .clear
        self.snp.makeConstraints { (maker) in
            maker.centerX.leading.equalToSuperview()
            maker.height.equalTo(barHeight)
            maker.top.equalToSuperview().offset(topMargin)
        }

        // 内容区
        contentView.layer.cornerRadius = 4.0
        self.addSubview(contentView)
        contentView.snp.makeConstraints { (maker) in
            maker.center.equalToSuperview()
            maker.leading.top.equalToSuperview().offset(5)
        }

        // 右边刷新按钮
        contentView.addSubview(refreshBtn)
        refreshBtn.snp.makeConstraints { (maker) in
            maker.centerY.top.equalToSuperview()
            maker.trailing.equalToSuperview()
            maker.width.equalTo(50.0)
        }
        // 点击刷新按钮
        refreshBtn.addTarget(self, action: #selector(refreshButtonDidClick(_:)), for: .touchUpInside)

        // 右边图标
        contentView.addSubview(iconImgView)
        iconImgView.snp.makeConstraints { (maker) in
            maker.centerY.equalToSuperview()
            maker.trailing.equalToSuperview().offset(-10.0)
            maker.width.height.equalTo(26.0)
        }

        // 文本内容
        contentView.addSubview(detailsLabel)
        detailsLabel.snp.makeConstraints { (maker) in
            maker.centerY.equalToSuperview()
            maker.leading.equalToSuperview().offset(10.0)
            maker.top.equalToSuperview()
            maker.right.equalTo(iconImgView.snp_leftMargin).offset(10.0)
        }

    }

    // 根据状态更新UI
    private func updateUIWithStatus(_ status: XQBarStatus) {
        detailsLabel.text = status.content()
        iconImgView.image = status.icon()
        contentView.backgroundColor = status.bgColor()
        updateAnimationWithStatus(status)
    }

    // 根据状态更新刷新栏动画
    private func updateAnimationWithStatus(_ status: XQBarStatus) {
        switch status {
        case .failed:
            _ = iconImgView.stopRepeatRotate(key:kRotationAnimationKey)
        case .refreshing:
            _ = iconImgView.startRepeatRotate(key:kRotationAnimationKey)
        case .sucessed:
            _ = iconImgView.stopRepeatRotate(key:kRotationAnimationKey)
            iconImgView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            UIView.animate(withDuration: fShowDuration,
                            delay: 0.2,
                            usingSpringWithDamping: 0.3,
                            initialSpringVelocity: 8,
                            options: .curveEaseInOut,
                            animations: {
                                self.iconImgView.transform = CGAffineTransform(scaleX: 1, y: 1)
            }) {[weak self] (_) in
                _ = self?.delay(fShowSucessedDuration) {
                    self?.hide()
                }
            }
        default:
            break
        }
    }

    // 显示刷新栏
    private func show() {
        guard !bIsShowed else { return }
        bIsShowed = true
        self.isHidden = false
        self.snp.updateConstraints { (maker) in
            maker.top.equalToSuperview().offset(topMargin)
        }
        UIView.animate(withDuration: fShowDuration, animations: {
            self.superview?.layoutIfNeeded()
        })
    }

    // 隐藏刷新栏
    private func hide() {
        guard bIsShowed else { return }
        bIsShowed = false

        self.snp.updateConstraints { (maker) in
            maker.top.equalToSuperview().offset(-(topMargin+barHeight))
        }
        UIView.animate(withDuration: fHideDuration, animations: {
            self.superview?.layoutIfNeeded()
        }) { (_) in
            self.isHidden = true
        }
    }

    // 点击刷新按钮
    @objc private func refreshButtonDidClick(_ button: UIButton) {
        // 失败状态，才可以点击刷新按钮
        guard currentStatus == .failed else {
            return
        }
        refreshBlock?(currentStatus)
    }
}

// MARK: Public Func
extension XQRefreshBar {
    public func updateStatus(_  barStatus: XQBarStatus) {
        self.currentStatus = barStatus
        self.show()
    }
}
