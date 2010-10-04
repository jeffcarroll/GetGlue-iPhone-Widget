//
//  ExampleAppDelegate.h
//  Example
//
//  Created by Dominick D'Aniello on 10/4/10.
//  Copyright AdaptiveBlue 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ExampleViewController;

@interface ExampleAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    ExampleViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ExampleViewController *viewController;

@end

