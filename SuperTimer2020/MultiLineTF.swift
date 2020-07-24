//
//  MultiLineTF.swift
//  SuperTimer2020
//
//  Created by Ryan S.Kennedy on 20.07.2020.
//  Copyright © 2020 Ryan S.Kennedy. All rights reserved.
//

import SwiftUI

struct MultiLineTF : UIViewRepresentable {
    
    @Binding var txt : String
    
    @State var defValue : String = ""
    
    @State var isEditable : Bool = false
    
    func makeCoordinator() -> MultiLineTF.Coordinator {
        
        return  MultiLineTF.Coordinator(parent1 : self)
    }
    
    func makeUIView(context: UIViewRepresentableContext<MultiLineTF>) -> UITextView {
        
        let tView = UITextView()
        tView.isEditable = self.isEditable ? true : false
        tView.isUserInteractionEnabled = true
        tView.isScrollEnabled = true
        tView.text = self.defValue == "" ? "Type description here..." : self.defValue
        tView.textColor = self.defValue == "" ? .gray : .black
        tView.font = .systemFont(ofSize: 15)
        tView.delegate = context.coordinator
        
        return tView
    }
    
    func updateUIView (_ uiView: UITextView, context: UIViewRepresentableContext<MultiLineTF>) {
        
    }
    
    class Coordinator : NSObject, UITextViewDelegate {
        
        var parent : MultiLineTF
        
        init(parent1 : MultiLineTF) {
            
            parent = parent1
        }
        
        func textViewDidChange(_ textView: UITextView) {
            
            self.parent.txt = textView.text
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            
            textView.text = textView.text == "Type description here..." ? "" : textView.text
            textView.textColor = .label
        }
    }
}
