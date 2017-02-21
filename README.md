# Standford CS193p Course Practice

## Lecture 4 Views

Drawing smily face, demonstrating drawing views and guesture recognition.

## Rename generic `ViewController` to specified `FaceViewController`

*good practice*

1. rename class name.

	`class ViewController: UIViewController` to `class FaceViewController: UIViewController`

2. rename swift file name.

	+ `Navigator` -> `Project Navigator`

	+ rename `ViewController.swift` to `FaceViewController.swift`

3. change storyboard ViewController identity

	+ `Utilities` -> `Identity inspector`

	+ set `Custom Class` -> `Class` to `FaceViewController`

## FaceView 

1. Create FaveView.swift

FaceView must subclass UIView, which is subclass from NSObject.

2. 新建UIView 控件 

+ 从`Uitlities` 中拖拽一个 `UIView` 到 `StoryBoard`

+ 将UIView 的identity 中的class 修改为 FaceView

2. 新建skull （脸轮廓线）UIBezierPath

### skull radius calculation has to be calculation property

Property can't be used until initalization completed.

+ `center`, `radius` *caution: must be inside its own coordination*

`M_PI` updated to `CGFloat.pi`, which can be briefly writen as `.pi`

+ set Color

+ strike

## gesture recognizer

Gesture recognizer added in faceView didSet property observer.

The proper time to add gesture recognizer is when the view didSet observer. It's in time and called once when the view outlet settled at runtime.
