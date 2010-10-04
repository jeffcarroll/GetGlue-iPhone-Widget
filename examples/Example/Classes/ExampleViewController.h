//
//  ExampleViewController.h
//  Example
//
//  Created by Dominick D'Aniello on 10/4/10.
//  Copyright AdaptiveBlue 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetGlueWidget.h"

@interface ExampleViewController : UIViewController {
	GetGlueWidgetView* gg;
}

@property (nonatomic, retain) IBOutlet GetGlueWidgetView *gg;
@end

