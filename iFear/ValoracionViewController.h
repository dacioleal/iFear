//
//  ValoracionViewController.h
//  iFear
//
//  Created by Dacio Leal Rodriguez on 26/08/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pelicula.h"

@interface ValoracionViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *movieImageView;
@property (nonatomic, strong) Pelicula *movie;
@property (nonatomic, strong) NSDictionary *scores;

- (IBAction)backPushButton:(UIButton *)sender;
@end
