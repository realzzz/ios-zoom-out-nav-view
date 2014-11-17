ios-zoom-out-nav-view
=====================

a view that supports zoom out when add subview


Effect:
![ScreenShot](https://raw.github.com/realzzz/ios-zoom-out-nav-view/master/sc.gif)


Usage:

1. Import zoomInOutNavView.h .m to your project

2. Make the parent view inherited from zoomInOutNavView instead of UIView.

3.Use 
  - (void) addSubview:(UIView *)view fromRect:(CGRect)origRect byScale:(CGFloat)scale
  to add sub view. 

  OrigRect is the rect on screen that is going to zoom out
  scale is the target scale size for parent view.
  
4. For parent view, use 
  - (void) zoomInBack:(CGRect)origRect byScale:(CGFloat)scale;
  to Zoom in back after subview is removed.  

  

Note: 
Work with ARC support.


License: MIT. 


