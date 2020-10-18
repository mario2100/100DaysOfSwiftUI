//
//  FlowerShapeView.swift
//  Drawing
//
//  Created by Hector Villasano on 10/18/20.
//

import SwiftUI

fileprivate struct FlowerShape: Shape {
    // How much to move this petal away from the center
    var petalOffset: Double = -20
    
    // How wide to make each petal
    var petalWidth: Double = 100
    
    func path(in rect: CGRect) -> Path {
        // The path that will hold all petals
        var path = Path()
        
        // Count from 0 up to pi * 2, moving up pi / 8 each time
        for number in stride(from: 0, to: CGFloat.pi * 2, by: CGFloat.pi / 8) {
            // rotate the petal by the current value of our loop
            let rotation = CGAffineTransform(rotationAngle: number)
            
            // move the petal to be at the center of our view
            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2))
            
            // create a path for this petal using our properties plus a fixed Y and height
            let originalPetal = Path(ellipseIn: CGRect(x: CGFloat(petalOffset), y: 0, width: CGFloat(petalWidth), height: rect.width / 2))
            
            // apply our rotation/position transformation to the petal
            let rotatedPetal = originalPetal.applying(position)
            
            // add it to our main path
            path.addPath(rotatedPetal)
        }
        
        // now send the main path back
        return path
    }
}

struct FlowerShapeView: View {
    @State private var petalOffSet = -20.0
    @State private var petalWidth = 100.0
    
    var body: some View {
        VStack {
            FlowerShape(petalOffset: petalOffSet, petalWidth: petalWidth)
                //                .stroke(Color.green, lineWidth: 0.5)
                .fill(Color.yellow, style: FillStyle(eoFill: true))
            
            Text("Offset")
            Slider(value: $petalOffSet, in: -40...40)
                .padding([.horizontal, .bottom])
            
            Text("Width")
            Slider(value: $petalWidth, in: 10...100)
                .padding([.horizontal])
        }
    }
}

struct FlowerShapeView_Previews: PreviewProvider {
    static var previews: some View {
        FlowerShapeView()
    }
}
