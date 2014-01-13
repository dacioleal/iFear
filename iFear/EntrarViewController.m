//
//  EntrarViewController.m
//  iFear
//
//  Created by Dacio Leal Rodriguez on 10/01/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import "EntrarViewController.h"


@interface EntrarViewController () {
    
    float initialOpacity;
    float finalOpacity;
}

@end

@implementation EntrarViewController


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
   
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidAppear:(BOOL)animated {
    
    
        // Animacion para bajar la opacidad del logo creando efecto de atenuacion
        initialOpacity = 1.0;
        finalOpacity = 0.4;
    
        CABasicAnimation *animacionUno = [CABasicAnimation animationWithKeyPath:@"opacity"];
        animacionUno.fromValue = [NSNumber numberWithFloat:initialOpacity];
        animacionUno.toValue = [NSNumber numberWithFloat:finalOpacity];
        animacionUno.duration = 2.2;
        animacionUno.delegate = self;
    
        [self.logoImageView.layer addAnimation:animacionUno forKey:@"parpadeo"];
    
}

- (void) animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    // Uso de un flag que alterna entre la animacion de atenuacion y la de vuelta a opacidad normal
     static BOOL repeticion;
    
    if (flag) {
        
        repeticion = !repeticion;
        float temp = finalOpacity;
        finalOpacity = initialOpacity;
        initialOpacity = temp;
        
        // Animacion de regreso del logo a opacidad normal
        
        CABasicAnimation *animacionDos = [CABasicAnimation animationWithKeyPath:@"opacity"];
        animacionDos.fromValue = [NSNumber numberWithFloat:initialOpacity];
        animacionDos.toValue = [NSNumber numberWithFloat:finalOpacity];
        animacionDos.duration = 2.2;
        animacionDos.delegate = self;
    
        [self.logoImageView.layer addAnimation:animacionDos forKey:@"parpadeo"];
    }
    
}



- (IBAction) entrarPushButton:(id)sender {
    

}

@end
