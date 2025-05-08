import SwiftUI

// 탭 제스처 (React의 onClick과 유사)
// React: <button onClick={() => handleClick()}>
struct TapGestureExample: View {
    @State private var tapCount = 0
    @State private var isTapped = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Tap Count: \(tapCount)")
                .font(.headline)
            
            Circle()
                .fill(isTapped ? Color.red : Color.blue)
                .frame(width: 100, height: 100)
                .onTapGesture {
                    tapCount += 1
                    withAnimation(.easeInOut(duration: 0.1)) {
                        isTapped = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        withAnimation(.easeInOut(duration: 0.1)) {
                            isTapped = false
                        }
                    }
                }
        }
        .padding()
    }
}

// 드래그 제스처 (React의 onDrag와 유사)
// React: <div onDragStart={handleDragStart} onDrag={handleDrag} onDragEnd={handleDragEnd}>
struct DragGestureExample: View {
    @State private var position = CGSize.zero
    @State private var isDragging = false
    
    var body: some View {
        VStack {
            Text("Drag the card")
                .font(.headline)
            
            RoundedRectangle(cornerRadius: 10)
                .fill(isDragging ? Color.purple : Color.blue)
                .frame(width: 200, height: 100)
                .offset(position)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            position = gesture.translation
                            isDragging = true
                        }
                        .onEnded { gesture in
                            withAnimation(.spring()) {
                                position = .zero
                                isDragging = false
                            }
                        }
                )
        }
        .padding()
    }
}

// 롱 프레스 제스처 (React의 onLongPress와 유사)
// React: <div onMouseDown={handleMouseDown} onMouseUp={handleMouseUp}>
struct LongPressGestureExample: View {
    @State private var isPressed = false
    @State private var progress: CGFloat = 0
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Long Press to Fill")
                .font(.headline)
            
            ZStack {
                Circle()
                    .stroke(Color.gray, lineWidth: 4)
                    .frame(width: 100, height: 100)
                
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(Color.blue, lineWidth: 4)
                    .frame(width: 100, height: 100)
                    .rotationEffect(.degrees(-90))
                
                Text("\(Int(progress * 100))%")
                    .font(.headline)
            }
            .gesture(
                LongPressGesture(minimumDuration: 0.1)
                    .onEnded { _ in
                        withAnimation(.linear(duration: 2)) {
                            progress = 1.0
                        }
                    }
            )
        }
        .padding()
    }
}

// 핀치 제스처 (React의 onWheel과 유사)
// React: <div onWheel={handleWheel}>
struct PinchGestureExample: View {
    @State private var scale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0
    
    var body: some View {
        VStack {
            Text("Pinch to Zoom")
                .font(.headline)
            
            Image(systemName: "photo")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .scaleEffect(scale)
                .gesture(
                    MagnificationGesture()
                        .onChanged { value in
                            let delta = value / lastScale
                            lastScale = value
                            scale = min(max(scale * delta, 0.5), 3.0)
                        }
                        .onEnded { _ in
                            lastScale = 1.0
                        }
                )
        }
        .padding()
    }
}

// 동시 제스처 (React의 이벤트 조합과 유사)
// React: <div onMouseDown={handleMouseDown} onTouchStart={handleTouchStart}>
struct SimultaneousGestureExample: View {
    @State private var position = CGSize.zero
    @State private var scale: CGFloat = 1.0
    
    var body: some View {
        VStack {
            Text("Drag and Pinch")
                .font(.headline)
            
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.blue)
                .frame(width: 200, height: 200)
                .offset(position)
                .scaleEffect(scale)
                .gesture(
                    SimultaneousGesture(
                        DragGesture()
                            .onChanged { gesture in
                                position = gesture.translation
                            }
                            .onEnded { _ in
                                withAnimation(.spring()) {
                                    position = .zero
                                }
                            },
                        MagnificationGesture()
                            .onChanged { value in
                                scale = value
                            }
                            .onEnded { _ in
                                withAnimation(.spring()) {
                                    scale = 1.0
                                }
                            }
                    )
                )
        }
        .padding()
    }
}

// 커스텀 제스처 (React의 커스텀 훅과 유사)
// React: const useCustomGesture = () => { ... }
struct CustomGestureExample: View {
    @State private var rotation: Double = 0
    @State private var isRotating = false
    
    var body: some View {
        VStack {
            Text("Rotate the square")
                .font(.headline)
            
            Rectangle()
                .fill(isRotating ? Color.orange : Color.blue)
                .frame(width: 100, height: 100)
                .rotationEffect(.degrees(rotation))
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { gesture in
                            let center = CGPoint(x: 100, y: 100)
                            let start = CGPoint(x: center.x + 50, y: center.y)
                            let current = gesture.location
                            
                            let startAngle = atan2(start.y - center.y, start.x - center.x)
                            let currentAngle = atan2(current.y - center.y, current.x - center.x)
                            
                            rotation = Double((currentAngle - startAngle) * 180 / .pi)
                            isRotating = true
                        }
                        .onEnded { _ in
                            withAnimation(.spring()) {
                                rotation = 0
                                isRotating = false
                            }
                        }
                )
        }
        .padding()
    }
}

// 프리뷰
struct Gestures_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TapGestureExample()
            DragGestureExample()
            LongPressGestureExample()
            PinchGestureExample()
            SimultaneousGestureExample()
            CustomGestureExample()
        }
    }
} 