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
