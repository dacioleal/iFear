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

@property (strong, nonatomic) Pelicula * movie;

- (IBAction)backPushButton:(UIButton *)sender;

@end
