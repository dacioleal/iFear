//
//  ModalMentesOscurasViewController.m
//  iFear
//
//  Created by José Alberto Martín Falcón on 23/08/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import "ModalMentesOscurasViewController.h"

@interface ModalMentesOscurasViewController ()

@end

@implementation ModalMentesOscurasViewController

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
    
    self.modalPresentationStyle = UIModalPresentationCustom;
    
    // Se establece un color negro semi-transparene a la vista principal
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.6f];
    
    // Animación
    UIInterpolatingMotionEffect* m1 =
    [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x"
                                                    type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    m1.maximumRelativeValue = @10.0;
    m1.minimumRelativeValue = @-10.0;
    UIInterpolatingMotionEffect* m2 =
    [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y"
                                                    type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    m2.maximumRelativeValue = @10.0;
    m2.minimumRelativeValue = @-10.0;
    UIMotionEffectGroup* g = [UIMotionEffectGroup new];
    g.motionEffects = @[m1,m2];
    NSLog(@"ENTRA");
    [self.popupView addMotionEffect:g];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




// Método para mostrar el alert.
- (void) showProfile: (id) sender
{
    
    UIViewController * auxVc = (UIViewController *) sender;
    
    [auxVc presentViewController:self animated:YES completion:nil];
}

- (IBAction)pushReturnButton:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:Nil];
}

@end
