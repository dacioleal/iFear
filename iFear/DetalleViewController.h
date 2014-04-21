//
//  DetalleViewController.h
//  iFear
//
//  Created by Dacio Leal Rodriguez on 12/03/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pelicula.h"

@interface DetalleViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *movieImageView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIScrollView *trailersScrollView;
@property (weak, nonatomic) IBOutlet UIView *sectionButtonsView;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;

@property (strong, nonatomic) Pelicula * movie;

- (IBAction)backPushButton:(UIButton *)sender;
- (IBAction)descriptionPushButton:(UIButton *)sender;
- (IBAction)trailersPushButton:(UIButton *)sender;

@end
