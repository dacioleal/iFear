//
//  CriticaMedioViewController.h
//  iFear
//
//  Created by Dacio Leal Rodriguez on 06/06/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CriticaMedio.h"

@interface CriticaMedioViewController : UIViewController

@property (strong, nonatomic) CriticaMedio *criticaMedio;

@property (weak, nonatomic) IBOutlet UILabel *autorLabel;
@property (weak, nonatomic) IBOutlet UILabel *medioLabel;
@property (weak, nonatomic) IBOutlet UITextView *contenidoTextView;
@end
