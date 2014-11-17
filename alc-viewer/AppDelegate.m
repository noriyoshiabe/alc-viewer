//
//  AppDelegate.m
//  alc-viewer
//
//  Created by 張阿部 on 2014/11/15.
//
//

#import "AppDelegate.h"
#import <WebKit/WebKit.h>

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet WebView *webView;
@end

@implementation AppDelegate

- (void)applicationWillFinishLaunching:(NSNotification *)aNotification
{
  [[NSAppleEventManager sharedAppleEventManager] setEventHandler:self andSelector:@selector(handleAppleEvent:withReplyEvent:) forEventClass:kInternetEventClass andEventID:kAEGetURL];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
}

- (void)applicationWillTerminate:(NSNotification *)aNotification
{
}

- (void)handleAppleEvent:(NSAppleEventDescriptor *)event withReplyEvent:(NSAppleEventDescriptor *)replyEvent
{
  NSString *urlString = [[event paramDescriptorForKeyword:keyDirectObject] stringValue];
  NSString *query = [urlString substringFromIndex:6];
  [self.webView setMainFrameURL:[NSString stringWithFormat:@"http://eow.alc.co.jp/search?q=%@", query]];
  [self.window orderFront:self];
}

@end
