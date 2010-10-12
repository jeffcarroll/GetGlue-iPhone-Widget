/*
 Copyright 2010 AdaptiveBlue Inc.
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 
 ---
 
 Some of this code is based on http://github.com/facebook/facebook-iphone-sdk/blob/master/src/FBDialog.m by Facebook
 
*/

#import "GetGlueWidget.h"

@implementation GluePopup

@synthesize widget;

- (id) init {
	CGRect rect = CGRectMake(3, 23, 314, 454);
	self = [super initWithFrame: rect];
	if (self != nil) {
		self.backgroundColor = [UIColor clearColor];
		[self setClipsToBounds:YES];
		webview = [[[UIWebView alloc] initWithFrame:CGRectMake(10, 47, rect.size.width-20, rect.size.height-72)] autorelease];
		webview.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
		webview.delegate = self;
		[self addSubview:webview];
		
		loadingSpinner = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] autorelease];
		[self addSubview:loadingSpinner];
		
		closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
		[closeBtn setImage:[UIImage imageNamed:@"GetGlueWidget.bundle/getglue_close.png"] forState:UIControlStateNormal];
		closeBtn.frame = CGRectMake(rect.size.width-35, 21, 14, 14);
		[closeBtn addTarget:self action:@selector(closePopup:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:closeBtn];
		
		[self setSizeForOrientation:NO];
	}
	return self;
}


-(void) dealloc {
    [super dealloc];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
	
	// window
	CGContextSaveGState(context);
		CGContextSetShadow(context, CGSizeMake(0, 0), 20);
		CGContextSetRGBFillColor(context, 0.87f, 0.87f, 0.87f, 1.0f);
		
		CGRect drawrect = CGRectInset(rect, 10, 10);
		
		CGFloat radius = 10.0;	
		CGFloat minx = CGRectGetMinX(drawrect), midx = CGRectGetMidX(drawrect), maxx = CGRectGetMaxX(drawrect);
		CGFloat miny = CGRectGetMinY(drawrect), midy = CGRectGetMidY(drawrect), maxy = CGRectGetMaxY(drawrect);	
		CGContextMoveToPoint(context, minx, midy);
		CGContextAddArcToPoint(context, minx, miny, midx, miny, radius);
		CGContextAddArcToPoint(context, maxx, miny, maxx, midy, radius);
		CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
		CGContextAddArcToPoint(context, minx, maxy, minx, midy, radius);
		CGContextClosePath(context);
		CGContextDrawPath(context, kCGPathFill);
	CGContextRestoreGState(context);
	
	// logo
	CGContextSaveGState(context);
		[[UIImage imageNamed:@"GetGlueWidget.bundle/getglue_logo.png"] drawInRect: CGRectMake(20, 19, 72, 18)];
	CGContextRestoreGState(context);
	
	CGContextSaveGState(context);
		CGContextSetLineWidth(context, 1);
	
		// Top lines
		CGContextSetRGBStrokeColor(context, 0.68f,0.68f,0.68f,1.0f);
		CGContextMoveToPoint(context, minx, miny+35.5);
		CGContextAddLineToPoint(context, maxx, miny+35.5);
		CGContextStrokePath(context);
		CGContextMoveToPoint(context, minx, maxy-14.5);
		CGContextAddLineToPoint(context, maxx, maxy-14.5);
		CGContextStrokePath(context);
	
		// Bottom lines
		CGContextSetRGBStrokeColor(context, 1.0f,1.0f,1.0f,1.0f);		
		CGContextMoveToPoint(context, minx, miny+36.5);
		CGContextAddLineToPoint(context, maxx, miny+36.5);
		CGContextStrokePath(context);
		CGContextMoveToPoint(context, minx, maxy-13.5);
		CGContextAddLineToPoint(context, maxx, maxy-13.5);
		CGContextStrokePath(context);
	CGContextRestoreGState(context);
	
}

- (IBAction) closePopup:(id) sender {
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.3];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(cleanup)];
	self.alpha = 0;
	[UIView commitAnimations];
}

- (void)cleanup {
	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"UIDeviceOrientationDidChangeNotification" object:nil];
	[self removeFromSuperview];
}


- (CGAffineTransform)transformForOrientation {
	UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
	if (orientation == UIInterfaceOrientationLandscapeLeft) {
		return CGAffineTransformMakeRotation(M_PI*1.5);
	} else if (orientation == UIInterfaceOrientationLandscapeRight) {
		return CGAffineTransformMakeRotation(M_PI/2);
	} else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
		return CGAffineTransformMakeRotation(-M_PI);
	} else {
		return CGAffineTransformIdentity;
	}
}

- (void)setSizeForOrientation: (BOOL) animate {
	UIDeviceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
	
	CGRect screenFrame = [UIScreen mainScreen].applicationFrame;
	CGPoint center = CGPointMake(
								 screenFrame.origin.x + ceil(screenFrame.size.width/2),
								 screenFrame.origin.y + ceil(screenFrame.size.height/2));
	
	if (animate) {
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:[UIApplication sharedApplication].statusBarOrientationAnimationDuration];
	}
	
	self.transform = [self transformForOrientation];
	CGRect newSize;
	if (UIInterfaceOrientationIsLandscape(orientation)) {
		newSize = CGRectMake(3, 23, 300, 314);
		webview.frame = CGRectMake(10, 47, newSize.size.width-6, newSize.size.height-86);
		loadingSpinner.center = CGPointMake(center.x, center.y-80);
	} else {
		newSize = CGRectMake(3, 23, 314, 454);
		webview.frame = CGRectMake(10, 47, newSize.size.width-20, newSize.size.height-72);
		loadingSpinner.center = CGPointMake(center.x, center.y-25);
	}
	self.frame = newSize;
	self.center = center;
	
	if (animate) {
		[UIView commitAnimations];
	}
	[self setNeedsDisplay];
	
}

- (void)orientationDidChange:(void*)object {
	[self setSizeForOrientation:YES];
}

- (void)phase2 {
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.15];
	self.transform = [self transformForOrientation];
	[UIView commitAnimations];
}

-(void)showCheckinScreenWithParams: (NSString*) params {
	UIWindow* window = [UIApplication sharedApplication].keyWindow;
	if (!window) {
		window = [[UIApplication sharedApplication].windows objectAtIndex:0];
	}
	[window addSubview:self];
	
	
	self.transform = CGAffineTransformScale([self transformForOrientation], 0.001, 0.001);
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.2];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(phase2)];
	self.transform = CGAffineTransformScale([self transformForOrientation], 1.1, 1.1);
	[UIView commitAnimations];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(orientationDidChange:)
												 name:@"UIDeviceOrientationDidChangeNotification" object:nil];
	
	[loadingSpinner startAnimating];
	[webview setHidden:YES];
	[webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: [NSString stringWithFormat: @"http://%@/widget/checkin?style=mobile&app=mobileWidget_%@&%@",GETGLUE_POPUP_HOST, GETGLUE_WIDGET_VERSION, params]]]];	
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	
	[loadingSpinner stopAnimating];
	[webview setHidden:NO];
}

- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
	NSURL *url = request.URL;
	NSString *urlString = url.absoluteString;
	if ([urlString hasPrefix:@"getglue://userDidCheckin"]) {
		NSString *params = url.query;
		[self.widget didPerformCheckinForUser:params]; 	
		return NO;
	} if ([urlString rangeOfString:@"getglue.com/widget/"].location == NSNotFound && 
		  [urlString rangeOfString:@"getglue.com/signup/"].location == NSNotFound && 
		  [urlString rangeOfString:@"getglue.com/verifyService/"].location == NSNotFound && 
		  [urlString rangeOfString:@"facebook.com/"].location == NSNotFound && 
		  [urlString rangeOfString:@"twitter.com/"].location == NSNotFound ) {
		BOOL launchInSafari = true;
		if([self.widget.delegate respondsToSelector:@selector(widget:shouldLaunchURL:)]) {
			launchInSafari = [self.widget.delegate widget:self.widget shouldLaunchURL:url];
		}
		if(launchInSafari){
			[[UIApplication sharedApplication] openURL:url];
		}
		return NO;
	} else {
		return YES;
	}
}

@end
