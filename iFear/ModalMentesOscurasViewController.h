//
//  ModalMentesOscurasViewController.h
//  iFear
//
//  Created by José Alberto Martín Falcón on 23/08/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModalMentesOscurasViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *popupView;

- (void) showProfile: (id) sender;
- (IBAction)pushReturnButton:(id)sender;

@end
