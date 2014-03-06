//
//  CarteleraViewController.h
//  iFear
//
//  Created by Dacio Leal Rodriguez on 13/01/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarteleraViewController : UIViewController <UIPageViewControllerDelegate, UIPageViewControllerDataSource, NSURLSessionDelegate, NSURLConnectionDataDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) UIPageViewController *carteleraPageViewController;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *loadingLabel;

@end
