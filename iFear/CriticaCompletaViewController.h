//
//  CriticaCompletaViewController.h
//  iFear
//
//  Created by Dacio Leal Rodriguez on 16/09/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CriticaCompletaViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextView *reviewTextView;

- (IBAction)backPushButton:(UIButton *)sender;
- (IBAction)donePushButton:(UIButton *)sender;

@end
