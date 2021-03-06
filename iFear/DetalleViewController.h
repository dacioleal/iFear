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

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIImageView *movieImageView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIScrollView *trailersScrollView;
@property (weak, nonatomic) IBOutlet UIView *sectionButtonsView;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UIView *reviewsContainerView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentTitleLabel;
@property (weak, nonatomic) IBOutlet UIView *scoresView;
@property (weak, nonatomic) IBOutlet UIView *contentDarkSideView;

@property (weak, nonatomic) IBOutlet UILabel *terrorLabel;
@property (weak, nonatomic) IBOutlet UILabel *goreLabel;
@property (weak, nonatomic) IBOutlet UILabel *humorLabel;
@property (weak, nonatomic) IBOutlet UILabel *calidadLabel;
@property (weak, nonatomic) IBOutlet UILabel *puntuacionMediaLabel;

@property (strong, nonatomic) Pelicula * movie;

@property (weak, nonatomic) IBOutlet UIButton *descriptionButton;
@property (weak, nonatomic) IBOutlet UIButton *trailersButton;
@property (weak, nonatomic) IBOutlet UIButton *reviewsButton;
@property (weak, nonatomic) IBOutlet UIButton *darkSideButton;

@property (weak, nonatomic) IBOutlet UIButton *mediaButton;
@property (weak, nonatomic) IBOutlet UIButton *flashButton;
@property (weak, nonatomic) IBOutlet UIButton *usersButton;


- (IBAction)backPushButton:(UIButton *)sender;
- (IBAction)descriptionPushButton:(UIButton *)sender;
- (IBAction)trailersPushButton:(UIButton *)sender;
- (IBAction)reviewsPushButton:(UIButton *)sender;
- (IBAction)darkSidePushButton:(UIButton *)sender;
- (IBAction)rateMoviePushButton:(UIButton *)sender;
- (IBAction)mediaPushButton:(UIButton *)sender;
- (IBAction)flashPushButton:(UIButton *)sender;
- (IBAction)usersPushButton:(UIButton *)sender;

@end
