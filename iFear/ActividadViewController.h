//
//  ActividadViewController.h
//  iFear
//
//  Created by Dacio Leal Rodriguez on 30/01/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActividadViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *actividadWebView;
- (IBAction)backPushButton:(UIButton *)sender;
@end
