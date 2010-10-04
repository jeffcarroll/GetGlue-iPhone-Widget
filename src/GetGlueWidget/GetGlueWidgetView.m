//
//  GetGlueWidgetView.m
//
//  Created by Dominick D'Aniello on 9/17/10.
//  Copyright 2010 AdaptiveBlue. All rights reserved.
//

#import "GetGlueWidget.h"

@implementation GetGlueWidgetView

@synthesize delegate, objectKey;

- (id) initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self != nil) {
		[self doPostInit];
	}
	return self;
}

-(void) doPostInit {
	self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, 64, 74);
	webview = [[[UIWebView alloc] initWithFrame:self.bounds] autorelease];
	webview.delegate = self;
	webview.opaque = NO;
	webview.backgroundColor = [UIColor clearColor];
	[self addSubview:webview];
}

-(id)initWithCoder:(NSCoder*)coder 
{
	[super initWithCoder: coder];
	[self doPostInit];
	return self;
}

-(void)setObjectKey: (NSString*) newObjectKey {    
	if (objectKey != newObjectKey) {
		[objectKey release];
		objectKey = [newObjectKey copy];
		[webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: [NSString stringWithFormat: @"http://%@/html/checkinMobile.html?objectId=%@#iphone", GETGLUE_WIDGET_HOST, objectKey]]]];	
	}
}

- (void)didPerformCheckinForUser:(NSString*)username  {
	[webview stringByEvaluatingJavaScriptFromString:@"getglue.updateCount(1,true)"]; 
	if([self.delegate respondsToSelector:@selector(widget:didPerformCheckinForUser:)]) {
		[self.delegate widget:self didPerformCheckinForUser:username];
	}
}

- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
	NSURL *url = request.URL;
	NSString *urlString = url.absoluteString;
	if ([urlString hasPrefix:@"getglue://newCount"]) {
		NSString *params = url.query;
		if([self.delegate respondsToSelector:@selector(widget:didRecieveNewCheckinCount:)]) {
			[self.delegate widget:self didRecieveNewCheckinCount:[params intValue]];
		}
		return NO;
	} if ([urlString hasPrefix:@"getglue://checkin"]) {
		NSString *params = url.query;
		
		GluePopup* popup = [[[GluePopup alloc] init] autorelease];
		popup.widget = self.self;
		[popup showCheckinScreenWithParams:params];
		return NO;
	}
	return YES;
}

@end
