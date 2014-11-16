//
//  ALCWebView.m
//  alc-viewer
//
//  Created by 張阿部 on 2014/11/16.
//
//

#import "ALCWebView.h"

@implementation ALCWebView

- (void)keyDown:(NSEvent *)theEvent
{
  if (NSCommandKeyMask & theEvent.modifierFlags) {
    switch (theEvent.keyCode) {
      case 15:
        [self reload:self];
        break;
      case 33:
        [self goBack];
        break;
      case 30:
        [self goForward];
        break;
    }
  }
}

@end
