//
//  GetGlueWidgetView.h
//
//  Created by Dominick D'Aniello on 9/17/10.
//  Copyright 2010 AdaptiveBlue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol GetGlueWidgetDelegate;

@interface GetGlueWidgetView : UIView <UIWebViewDelegate> {
	id<GetGlueWidgetDelegate> delegate;
	UIWebView* webview;
	NSString* objectKey;
}

@property (nonatomic,assign) id<GetGlueWidgetDelegate> delegate;
@property (copy) NSString* objectKey;

// private
- (void) doPostInit;
- (void)didPerformCheckinForUser:(NSString*)username;

@end

@protocol GetGlueWidgetDelegate <NSObject>
@optional
- (BOOL)widget:(GetGlueWidgetView*) widget shouldLaunchURL:(NSURL*) url;
- (void)widget:(GetGlueWidgetView*) widget didRecieveNewCheckinCount:(int) newCount;
- (void)widget:(GetGlueWidgetView*) widget didPerformCheckinForUser: (NSString*) username;
@end
