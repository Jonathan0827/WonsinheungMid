//
//  Settings.swift
//  YourSchool
//
//  Created by 임준협 on 2023/03/01.
//

import SwiftUI
struct infoView: View {
    @State var viewLoaded = false
    @State var secondViewLoaded = false

    let height = UIScreen.main.bounds.height
    var body: some View{
        VStack{
            
                if viewLoaded{
                    Spacer()
                    Image(systemName: "graduationcap.fill")
                        .resizable()
                        .frame(width: 200, height: 200)
                        .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.5)))
                    Text("원신흥중학교")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.5).delay(0.5)))
                    Spacer()
                        


                    //                    Text("⠼")
                    //                        .font(.custom("AppleSymbols", size: 36))
                    
                    
                }
            if secondViewLoaded {
                ScrollView{
                    HStack{
                        Text("이 앱은")
                        Link("Jonathan0827", destination: URL(string: "https://github.com/Jonathan0827")!)
                        Text("이 제작한 앱입니다")
                    }
                    
                    .font(.title3)
                    
                }
                .ignoresSafeArea()
                .frame(height: height*2/5)

                .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.5)))
            }
//                Spacer()
        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                withAnimation { viewLoaded.toggle() }
            })
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                withAnimation { secondViewLoaded.toggle() }
            })
        }
    }
}
struct SettingsView: View {
    @AppStorage("alwaysLight") var alwaysLight = false

    @Binding var isFirstLaunching: Bool
    @Binding var userName: String
    @Binding var goReset: Bool
    @AppStorage("rainBar") var rainBar: Bool = true
    @Binding var rnum: Int
    var num = Int.random(in: 0...5)
    @Binding var colors: [Color]
    @State var showInfo = false
    var body: some View {
        VStack{
            Form {
//                Section{
                    
//                }
                Section{
                    Button(action: {LightMode()}, label: {
                        HStack{
                            Image(systemName: "lightbulb")
                            Text("Always Light Mode \(LightModeStat())")
                        }
                    })
                    
                    Button(action: {cBar()}, label: {
                        HStack{
                            Image(systemName: "\(cBarStat()[0])")
                            Text("RainBar \(cBarStat()[1])")
                        }
                    })
                    
                    Button(action: {showInfo = true}, label: {
                        HStack{
                            Image(systemName: "info")
                            Text("  이 앱에 대하여")
                        }
                    })
                }
                Section{
                    Button(action: {isFirstLaunching = true;userName = "";goReset = false}, label: {
                        HStack{
                            Image(systemName: "gear.badge.xmark")
                            Text("  초기화")
                        }
                        .foregroundColor(.red)
                    })
                }
            }
        }
        .sheet(isPresented: $showInfo) {
            infoView()
        }
    }
    func cBar() {
        rainBar.toggle()
        print(rainBar)
        if rainBar {
            rnum = num
        } else {
            rnum = 0
        }
    }
    func cBarStat() -> [String] {
        var cStat: [String] = []
        if rainBar {
            cStat.append("light.min")

            cStat.append("비활성화")
        } else {
            cStat.append("light.max")

            cStat.append("활성화")
        }
        return cStat
    }
    func LightMode() {
        withAnimation{
            alwaysLight.toggle()
        }
        print(alwaysLight)
    }
    func LightModeStat() -> String {
        var lStat: String = ""
        if alwaysLight {
            lStat = ("비활성화")
        } else {
            lStat = ("활성화")
        }
        return lStat
    }
}
