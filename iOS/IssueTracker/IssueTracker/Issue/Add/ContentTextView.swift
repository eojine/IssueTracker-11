//
//  CommentTextView.swift
//  IssueTracker
//
//  Created by 양어진 on 2020/11/05.
//  Copyright © 2020 양어진. All rights reserved.
//

import UIKit

protocol InsertPhotoDelegate: class {
    func showPhotoPicker()
}

final class ContentTextView: UITextView {
    
    var placeholderText = "코멘트는 여기에 작성하세요"
    weak var photoDelegate: InsertPhotoDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        delegate = self
        addMenuItem()
    }
    
    private func addMenuItem() {
        let insertPhotoMenu = UIMenuItem(title: "Insert Photo",
                                         action: #selector(insertPhotoDidTap))
        UIMenuController.shared.menuItems = [insertPhotoMenu]
    }
    
    override func canPerformAction(_ action: Selector,
                                   withSender sender: Any?) -> Bool {
        return action == #selector(cut(_:))
            || action == #selector(copy(_:))
            || action == #selector(paste(_:))
            || action == #selector(insertPhotoDidTap)
    }
    
    @objc private func insertPhotoDidTap() {
        photoDelegate?.showPhotoPicker()
    }
    
}

extension ContentTextView: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        setTextView()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            setTextView()
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
        }
        return true
    }
    
    private func setTextView() {
        if self.text == placeholderText {
            self.text = nil
            self.textColor = .black
        } else if self.text.isEmpty {
            self.text = placeholderText
            self.textColor = .lightGray
        }
    }
    
}
