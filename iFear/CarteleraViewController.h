//
//  CarteleraViewController.h
//  iFear
//
//  Created by Dacio Leal Rodriguez on 13/01/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EstrenosCollectionViewController.h"

@interface CarteleraViewController : UIViewController <UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *carteleraPageViewController;
@property (strong, nonatomic) EstrenosCollectionViewController *estrenosViewController;
@property (strong, nonatomic) NSArray *moviesList;
@property (strong, nonatomic) NSArray *estrenosMoviesList;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIView *loadingView;
@property (weak, nonatomic) IBOutlet UILabel *loadingLabel;

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *estrenosContentView;
@property (weak, nonatomic) IBOutlet UIView *containerView;

- (IBAction)tapEstrenosContentView:(UITapGestureRecognizer *)sender;

@end
