//
//  ViewController.m
//  JavascriptToNestedWebViews
//
//  Created by James Border on 6/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
-(void)callJavascriptFunctionInAllWebViews;
@end

@implementation ViewController

static const NSUInteger kNumViews		= 3;

-(void)callJavascriptFunctionInAllWebViews {

	if ([[scrollView subviews] count] > 0) {

		for (UIWebView *subWebView in [scrollView subviews]) {

			if ([subWebView respondsToSelector:@selector(stringByEvaluatingJavaScriptFromString:)]) {

				[subWebView stringByEvaluatingJavaScriptFromString:@"call_alert();"];

			}

		}
		
	}
	
}

- (void)viewDidLoad {

    [super viewDidLoad];

	scrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];

	CGFloat wvWidth = scrollView.frame.size.width;
	CGFloat wvHeight = scrollView.frame.size.height;

	[scrollView setScrollEnabled:YES];
	[scrollView setClipsToBounds:YES];
	[scrollView setDirectionalLockEnabled:YES];
	[scrollView setShowsVerticalScrollIndicator:YES];
	[scrollView setShowsHorizontalScrollIndicator:YES];
	[scrollView setPagingEnabled:YES];
	[scrollView setDelegate:self];
	[scrollView setContentSize:CGSizeMake((kNumViews * wvWidth), wvHeight)];	
	[scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
	
	for (int i = 0; i <= (kNumViews - 1); i++) {

		float viewX = i * wvWidth;

		UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(viewX, 0, wvWidth, wvHeight)];
		[webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"target" ofType:@"htm"]isDirectory:NO]]];

		[scrollView addSubview:webView];

	}
	
	[self.view addSubview:scrollView];

	//////////////
	
	UIButton *bttn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[bttn setFrame:CGRectMake(10, 400, 300, 40)];
	[bttn setTitle:@"Call Javascript" forState:UIControlStateNormal];
	[bttn addTarget:self action:@selector(callJavascriptFunctionInAllWebViews) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:bttn];

}

- (void)viewDidUnload {

    [super viewDidUnload];
	scrollView = nil;
	
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
