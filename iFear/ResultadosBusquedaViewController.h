//
//  ResultadosBusquedaViewController.h
//  iFear
//
//  Created by José Alberto Martín Falcón on 11/05/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultadosBusquedaViewController : UIViewController <UIPageViewControllerDelegate, UIPageViewControllerDataSource>
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) NSArray * resultMovies;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic) UIPageViewController *carteleraPageViewController;
@end
