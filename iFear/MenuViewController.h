//
//  MenuViewController.h
//  iFear
//
//  Created by Dacio Leal Rodriguez on 10/01/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController

- (IBAction)carteleraPushButton:(UIButton *)sender;
- (IBAction)buscarPushButton:(UIButton *)sender;
- (IBAction)mentesPushButton:(UIButton *)sender;
- (IBAction)queEsPushButton:(UIButton *)sender;
- (IBAction)opcionesPushButton:(UIButton *)sender;
- (IBAction)disparaPushButton:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIImageView *manImageView;
@property (weak, nonatomic) IBOutlet UIImageView *zombieImageView;

@end
