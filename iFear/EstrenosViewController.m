//
//  EstrenosViewController.m
//  iFear
//
//  Created by Dacio Leal Rodriguez on 24/03/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import "EstrenosViewController.h"

@interface EstrenosViewController () {
    
    BOOL estrenosViewisHidden;
}
- (IBAction)titleTap:(UITapGestureRecognizer *)sender;

@end

@implementation EstrenosViewController

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
    estrenosViewisHidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)slideOnePushButton:(UIButton *)sender {
    
    if (estrenosViewisHidden == YES) {
        estrenosViewisHidden = NO;
        [sender setImage:[UIImage imageNamed:@"triangulo_abajo_96x42.png"] forState:UIControlStateNormal];
        [_slideButtonTwo setImage:[UIImage imageNamed:@"triangulo_abajo_96x42.png"] forState:UIControlStateNormal];
        
    } else if (estrenosViewisHidden == NO) {
        estrenosViewisHidden = YES;
        [sender setImage:[UIImage imageNamed:@"triangulo_arriba_96x42.png"] forState:UIControlStateNormal];
        [_slideButtonTwo setImage:[UIImage imageNamed:@"triangulo_arriba_96x42.png"] forState:UIControlStateNormal];
    }
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter postNotificationName:@"showEstrenosView" object:self];
    
}

- (IBAction)slideTwoPushButton:(UIButton *)sender {
    
    
    if (estrenosViewisHidden == YES) {
        estrenosViewisHidden = NO;
        [sender setImage:[UIImage imageNamed:@"triangulo_abajo_96x42.png"] forState:UIControlStateNormal];
        [_slideButtonOne setImage:[UIImage imageNamed:@"triangulo_abajo_96x42.png"] forState:UIControlStateNormal];
        
    } else if (estrenosViewisHidden == NO) {
        estrenosViewisHidden = YES;
        [sender setImage:[UIImage imageNamed:@"triangulo_arriba_96x42.png"] forState:UIControlStateNormal];
        [_slideButtonOne setImage:[UIImage imageNamed:@"triangulo_arriba_96x42.png"] forState:UIControlStateNormal];
    }
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter postNotificationName:@"showEstrenosView" object:self];
    
}

- (IBAction)titleTap:(UITapGestureRecognizer *)sender {
    
    
    if (estrenosViewisHidden == YES) {
        estrenosViewisHidden = NO;
        [_slideButtonOne setImage:[UIImage imageNamed:@"triangulo_abajo_96x42.png"] forState:UIControlStateNormal];
        [_slideButtonTwo setImage:[UIImage imageNamed:@"triangulo_abajo_96x42.png"] forState:UIControlStateNormal];
        
    } else if (estrenosViewisHidden == NO) {
        estrenosViewisHidden = YES;
        [_slideButtonOne setImage:[UIImage imageNamed:@"triangulo_arriba_96x42.png"] forState:UIControlStateNormal];
        [_slideButtonTwo setImage:[UIImage imageNamed:@"triangulo_arriba_96x42.png"] forState:UIControlStateNormal];
    }
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter postNotificationName:@"showEstrenosView" object:self];
    
    
}
@end
















