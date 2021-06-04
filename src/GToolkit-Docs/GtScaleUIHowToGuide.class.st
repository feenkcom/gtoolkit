"
!How to scale the UI
Glamorous Toolkit respects the OS settings when it comes to the window scale factor on HiDPI screens. For example in OSX, if the resolution is set to ""scaled which looks like ==1680 × 1050=="" and the physical resolution of the screen is ==2880 × 1800== the scale factor of the UI is computed to be  ==2.0== which is reported to GT by the ==Winit== windowing library *https://github.com/rust-windowing/winit*.
!!User set scale factor
It is possible, however, to specify the extra ==zoom factor== which is when multiplied with the window scale factor gives the final UI scale factor. For example, executing the following script will automatically scale up all GT windows by ==1.5==:
${example:GtScaleUIHowToGuide>>#scaleToOneHalf}$
The default value is set to 1.0:
${example:GtScaleUIHowToGuide>>#scaleToDefault}$
"
Class {
	#name : #GtScaleUIHowToGuide,
	#superclass : #Object,
	#category : #'GToolkit-Docs'
}

{ #category : #'examples - scale' }
GtScaleUIHowToGuide >> scaleToDefault [
	<gtExample>
	<noTest>

	BlGlutinHostSpace zoomFactor: 1.0
]

{ #category : #'examples - scale' }
GtScaleUIHowToGuide >> scaleToOneHalf [
	<gtExample>
	<noTest>

	BlGlutinHostSpace zoomFactor: 1.5
]
