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
@property (weak) IBOutlet NSSearchField *searchField;
@property (weak) IBOutlet NSSearchFieldCell *searchFiledCell;
@end

@implementation AppDelegate

- (void)applicationWillFinishLaunching:(NSNotification *)aNotification
{
  [[NSAppleEventManager sharedAppleEventManager] setEventHandler:self andSelector:@selector(handleAppleEvent:withReplyEvent:) forEventClass:kInternetEventClass andEventID:kAEGetURL];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
  WebPreferences *webPreferences = [WebPreferences standardPreferences];
  [webPreferences setJavaScriptEnabled:NO];
  [self.webView setPreferences:webPreferences];
  
  [self.window setInitialFirstResponder:self.searchField];
  [self.searchFiledCell setSendsWholeSearchString:YES];
}

- (IBAction)searchAnswer:(id)sender
{
  NSString *query = [[self.searchField stringValue] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  if (0 < [query length]) {
    [self.webView setMainFrameURL:[NSString stringWithFormat:@"http://eow.alc.co.jp/search?q=%@", query]];
  }
}

- (void)applicationWillTerminate:(NSNotification *)aNotification
{
  // Insert code here to tear down your application
}

- (void)handleAppleEvent:(NSAppleEventDescriptor *)event withReplyEvent:(NSAppleEventDescriptor *)replyEvent
{
  NSString *urlString = [[event paramDescriptorForKeyword:keyDirectObject] stringValue];
  NSString *query = [urlString substringFromIndex:6];
  [self.webView setMainFrameURL:[NSString stringWithFormat:@"http://eow.alc.co.jp/search?q=%@", query]];
  [self.searchField setStringValue:[query stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
  [self.searchField becomeFirstResponder];
}

@end
