//
//  KeyBoardResponder.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 16.07.2023.
//

import SwiftUI

//        KeyboardView {
//            VStack(spacing: 40) {
//                colorShape(
//                    red: $redSliderValue,
//                    green: $greenSliderValue,
//                    blue: $blueSliderValue
//                )
//                .frame(height: 200)
//
//                VStack(spacing: 10) {
//                    ColorSliderView(value: $redSliderValue, color: .red)
//                    ColorSliderView(value: $greenSliderValue, color: .green)
//                    ColorSliderView(value: $blueSliderValue, color: .blue)
//                }
//
//                Spacer()
//            }
//            .padding()
//        } toolBar: {
//            HStack {
//                Spacer()
//                Button(action: {
//                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//                }, label: {
//                    Text("Done")
//                })
//            }.padding()
//        }
//        .navigationBarTitle("Sign Up", displayMode: .inline)

//final class KeyboardResponder: ObservableObject {
//    
//    private var notificationCenter: NotificationCenter
//    @Published private(set) var currentHeight: CGFloat = 0
//
//    init(center: NotificationCenter = .default) {
//        notificationCenter = center
//        notificationCenter.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//        notificationCenter.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
//
//    func dismiss() {
//        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//    }
//    
//    deinit {
//        notificationCenter.removeObserver(self)
//    }
//
//    @objc func keyBoardWillShow(notification: Notification) {
//        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
//            currentHeight = keyboardSize.height
//        }
//    }
//
//    @objc func keyBoardWillHide(notification: Notification) {
//        currentHeight = 0
//    }
//}
//
//struct KeyboardView<Content, ToolBar> : View where Content : View, ToolBar: View {
//    @StateObject private var keyboard: KeyboardResponder = KeyboardResponder()
//    let toolbarFrame: CGSize = CGSize(width: UIScreen.main.bounds.width, height: 40.0)
//    var content: () -> Content
//    var toolBar: () -> ToolBar
//    
//    var body: some View {
//        ZStack {
//            content()
//                .padding(.bottom, (keyboard.currentHeight == 0) ? 0 : toolbarFrame.height)
//            VStack {
//                 Spacer()
//                 toolBar()
//                    .frame(width: toolbarFrame.width, height: toolbarFrame.height)
//                    .background(Color.secondary)
//            }.opacity((keyboard.currentHeight == 0) ? 0 : 1)
//            .animation(.easeOut)
//        }
//        .padding(.bottom, keyboard.currentHeight)
//        .edgesIgnoringSafeArea(.bottom)
//        .animation(.easeOut)
//        
//    }
//}
