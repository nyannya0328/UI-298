//
//  ContentView.swift
//  Shared
//
//  Created by nyannyan0328 on 2021/09/04.
//

import SwiftUI

struct ContentView: View {
    
    @State var posts : [Post] = [
    
        Post(userImage: "p1"),
        Post(userImage: "p2"),
        Post(userImage: "p3"),
        Post(userImage: "p4"),
        Post(userImage: "p5"),
        Post(userImage: "p6"),
    
    ]
    

    
  
    
    var body: some View {
        
        NavigationView{
            
            
            ScrollView(.vertical, showsIndicators: false) {
                
                
                VStack(alignment: .leading, spacing: 15) {
                    
                    ForEach(posts){post in
                        
                        VStack(alignment: .leading, spacing: 15) {
                            
                            GeometryReader{proxy in
                                
                                
                                Image(post.userImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .cornerRadius(15)
                                
                                
                            }
                            .frame(height: 300)
                            .cornerRadius(15)
                            .overlay(
                            
                                heartLike(isTapped: $posts[getIndex(post: post)].isLiked, taps: 2)
                            )
                            
                            
                            Button {
                                posts[getIndex(post: post)].isLiked.toggle()
                            } label: {
                                
                                Image(systemName:post.isLiked ? "suit.heart.fill" : "suit.heart")
                                    .font(.title2)
                                    .foregroundColor(post.isLiked ? .red : .gray)
                                
                                
                            }

                            
                        }
                        
                        
                        
                    }
                    
                    
                }
                .padding()
                
                
            }
            .navigationTitle("Heart Animation")
            
            
            
        }
        
        
        
    }
    
        func getIndex(post : Post)->Int{
    
            let index = posts.firstIndex { currentIndex in
    
                return post.id == currentIndex.id
    
            } ?? 0
    
            return index
    
    
        }
        
        
      
      
   
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
    
    struct heartLike : View{
        
        @Binding var isTapped : Bool
        @State var startAnimation : Bool = false
        @State var bgAnimation : Bool = false
        @State var restBG : Bool = false
        @State var frameWorkAnimation : Bool = false
        @State var isEnded : Bool = false
        @State var tapCompleted : Bool = false
        
        var taps : Int = 2
        
        
        
        var body: some View{
            
            Image(systemName: restBG ? "suit.heart.fill" : "suit.heart")
                .font(.system(size: 50))
                .foregroundColor( restBG ? .red : .gray)
                .frame(maxWidth: .infinity, maxHeight:.infinity)
                .scaleEffect(startAnimation  && !restBG  ? 0 : 1)
                .opacity(startAnimation && !isEnded ? 1 : 0)
               
                .background(
                
                    ZStack{
                        
                        CustomShape(radi: restBG ? 30 : 0)
                            .fill(Color.purple)
                            .clipShape(Circle())
                            .frame(width: 50, height: 50)
                            .scaleEffect(bgAnimation ? 2.3 : 0)
                        
                        
                        ZStack{
                            
                            
                            let colors : [Color] = [.red,.green,.orange,.purple,.blue,.pink]
                            
                            
                            ForEach(1...6,id:\.self){index in
                                
                                
                                Circle()
                                    .fill(colors.randomElement()!)
                                    .frame(width: 15, height: 15)
                                    .offset(x: frameWorkAnimation ? 80 : 40)
                                    .rotationEffect(.init(degrees: Double(index * 60)))
                            }
                            
                            ForEach(1...6,id:\.self){index in
                                
                                
                                Circle()
                                    .fill(colors.randomElement()!)
                                    .frame(width: 8, height: 8)
                                    .offset(x: frameWorkAnimation ? 65 : 24)
                                    .rotationEffect(.init(degrees: Double(index * 60)))
                                    .rotationEffect(.degrees(-45))
                            }
                            
                        }
                        .opacity(restBG ? 1 : 0)
                        .opacity(isEnded ? 0 : 1)
                        
                        
                    }
                
                )
            
                .onTapGesture(count:taps) {
                    
                    if tapCompleted{
                        
                        updateFields(value: false)
                        return
                        
                    }
                    
                    if startAnimation{
                        
                        return
                    }
                    
                    isTapped  = true
                    
                    withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)){
                        
                        
                        startAnimation = true
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                        
                        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)){
                            
                            
                            bgAnimation = true
                        }
                    
                    
                    
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.6, blendDuration: 0.6)){
                            
                            
                            restBG = true
                        }
                        
                        withAnimation(.spring()){
                            
                            frameWorkAnimation = true
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                            
                         
                            
                            withAnimation(.easeOut){
                                
                                isEnded = true
                                
                                
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                
                                
                                tapCompleted = true
                                
                            }
                            
                            
                            
                        }
                        
                        
                        
                        
                        
                        
                    }
                    
                    }
                    
                    
                    
                }
                .onChange(of: isTapped) { newValue in
                    
                    if isTapped && !startAnimation{
                        
                        updateFields(value: true)
                    }
                    if !isTapped{
                        
                        updateFields(value: false)
                    }
                    
                }
            
            
        }
        
        func updateFields(value : Bool){
            
            startAnimation = value
            isEnded = value
            tapCompleted = value
            restBG = value
            frameWorkAnimation = value
            bgAnimation = value
            isTapped = value
            
            
        }
        }
    

struct CustomShape : Shape{
    
    var radi : CGFloat
    
    var animatableData:CGFloat{
        
        get{radi}
        set{radi = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        
        return Path{path in
            
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            
            let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
            path.move(to: center)
            
            path.addArc(center: center, radius: radi, startAngle: .zero, endAngle: .init(degrees: 360) ,clockwise: false)
            
            
            
        }
        
    }
}
