//
//  BottomMenuView.swift
//  IssueTracker
//
//  Created by 김근수 on 2020/11/04.
//  Copyright © 2020 김근수. All rights reserved.
//

import UIKit

protocol IssuesCloseDelegate: class {
    func issuesClose()
}

final class BottomMenuView: UIView {
    
    @IBOutlet weak var closeIssuesButton: UIButton!
    
    weak var delegate: IssuesCloseDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        let name = String(describing: BottomMenuView.self)
        guard let view = Bundle.main.loadNibNamed(name, owner: self, options: nil)?.first as? UIView  else { return }
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
        closeIssuesButton.addTarget(self, action: #selector(closeIssuesButtonDidTap), for: .touchUpInside)
    }
    
    public func toggle(with isEditing: Bool) {
        guard let superView = self.superview else { return }
        self.frame.origin.y = isEditing ? superView.frame.height - frame.height : superView.frame.height
    }
    
    @objc func closeIssuesButtonDidTap() {
        delegate?.issuesClose()
    }
    
}
