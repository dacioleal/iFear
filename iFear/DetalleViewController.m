//
//  DetalleViewController.m
//  iFear
//
//  Created by Dacio Leal Rodriguez on 12/03/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import "DetalleViewController.h"
#import "Pelicula.h"

@interface DetalleViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *movieImageView;


- (IBAction)imageTap:(UITapGestureRecognizer *)sender;

@end

@implementation DetalleViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    _movieImageView.image = _movie.imagen;
   
    
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)backPushButton:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)imageTap:(UITapGestureRecognizer *)sender {
    
        CGRect initialBounds = CGRectMake(0, 0, 180, 258);
        CGRect finalBounds = CGRectMake(0, 0, 396,  516);
    
        CGPoint initialCenter = CGPointMake(121, 187);
        CGPoint finalCenter = CGPointMake(512, 384);
    
    if ((_movieImageView.center.x == initialCenter.x) && (_movieImageView.center.y == initialCenter.y)) {
        [UIView animateWithDuration:0.3 animations:^{
            _movieImageView.center = finalCenter;
            _movieImageView.bounds = finalBounds;
            
        }];
    } else if ((_movieImageView.center.x == finalCenter.x) && (_movieImageView.center.y == finalCenter.y)) {
    
        [UIView animateWithDuration:0.3 animations:^{
            _movieImageView.center = initialCenter;
            _movieImageView.bounds = initialBounds;
        }];
    }
    
}


@end

























