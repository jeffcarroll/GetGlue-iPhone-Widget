//
//  ExampleViewController.m
//  Example
//
//  Created by Dominick D'Aniello on 10/4/10.
//  Copyright AdaptiveBlue 2010. All rights reserved.
//

#import "ExampleViewController.h"

@implementation ExampleViewController

@synthesize gg;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	gg.objectKey = @"tv_shows/weeds";
	
	GetGlueWidgetView* gg2 = [[[GetGlueWidgetView alloc] initWithFrame:CGRectMake(20, 110, 64, 74)] autorelease];
	gg2.objectKey = @"tv_shows/true_blood";
	[self.view addSubview:gg2];
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
