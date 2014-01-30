//
//  MainViewController.h
//  iFear
//
//  Created by Dacio Leal Rodriguez on 30/01/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *homeButton;
@property (weak, nonatomic) IBOutlet UIButton *buscarButton;
@property (weak, nonatomic) IBOutlet UIButton *carteleraButton;
@property (weak, nonatomic) IBOutlet UIButton *actividadButton;
@property (weak, nonatomic) IBOutlet UIButton *mentesButton;

- (IBAction)menuPushButton:(id)sender;
- (IBAction)homePushButton:(id)sender;
- (IBAction)buscarPushButton:(id)sender;
- (IBAction)carteleraPushButton:(id)sender;
- (IBAction)actividadPushButton:(id)sender;
- (IBAction)mentesPushButton:(id)sender;

@end
