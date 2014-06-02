//
//  QueEsViewController.h
//  iFear
//
//  Created by Dacio Leal Rodriguez on 26/05/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QueEsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *headerTextView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;

@property (weak, nonatomic) IBOutlet UIButton *menuButton;
@property (weak, nonatomic) IBOutlet UIButton *busquedaButton;
@property (weak, nonatomic) IBOutlet UIButton *carteleraButton;
@property (weak, nonatomic) IBOutlet UIButton *mentesButton;
@property (weak, nonatomic) IBOutlet UIButton *actividadButton;
@property (weak, nonatomic) IBOutlet UIButton *optionsButton;



- (IBAction)menuPushButton:(UIButton *)sender;
- (IBAction)busquedaPushButton:(UIButton *)sender;
- (IBAction)carteleraPushButton:(UIButton *)sender;
- (IBAction)mentesPushButton:(UIButton *)sender;
- (IBAction)actividadPushButton:(UIButton *)sender;
- (IBAction)optionsPushButton:(UIButton *)sender;
@end
