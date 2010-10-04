//
//  GluePopup.h
//
//  Created by Dominick D'Aniello on 9/20/10.
//  Copyright 2010 AdaptiveBlue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "GetGlueWidgetView.h"

@interface GluePopup : UIView <UIWebViewDelegate> {
	UIWebView* webview;
	UIButton* closeBtn;
	UIActivityIndicatorView* loadingSpinner;
	GetGlueWidgetView* widget;
}

@property(nonatomic,assign) GetGlueWidgetView* widget;

- (void)showCheckinScreenWithParams: (NSString*) params;
- (void)setSizeForOrientation: (BOOL) animate;

@end
