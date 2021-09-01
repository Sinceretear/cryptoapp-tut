//
//  AnimationBootcamp.swift
//  Tutorial
//
//  Created by Hunter Walker on 8/24/21.
//

import SwiftUI

struct AnimationBootcamp: View {
    
    @State var isAnimated: Bool = false
    
    var body: some View {
        VStack {
            Button(action: {
                withAnimation(.default) {
                    isAnimated.toggle()
                }
            }, label: {
                Text("Button")
            })
            Spacer()
            RoundedRectangle(cornerRadius: isAnimated ? 50 : 25)
                .fill(isAnimated ? Color.red : Color.green)
                .frame(width: 100, height: 100)
                .offset(x: isAnimated ? 100 : 0)
            Spacer()
        }
    }
}

struct AnimationBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        AnimationBootcamp()
    }
}
