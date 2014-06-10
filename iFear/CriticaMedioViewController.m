//
//  CriticaMedioViewController.m
//  iFear
//
//  Created by Dacio Leal Rodriguez on 06/06/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import "CriticaMedioViewController.h"

@interface CriticaMedioViewController ()

@end

@implementation CriticaMedioViewController



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
    [self.navigationController.navigationBar setHidden:NO];
    self.navigationItem.title = nil;
    
    NSString *autor = _criticaMedio.autor;
    NSString *medio = _criticaMedio.medio;
    NSString *contenido = _criticaMedio.contenido;
    
    UIColor *textColor = [[UIColor alloc] initWithRed:0.76 green:0 blue:0.122 alpha:1.0];
    UIFont *font = [UIFont fontWithName:@"Futura-Medium" size:18.0];
    NSAttributedString *autorAttributedString = [[NSAttributedString alloc] initWithString:autor attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
    _autorLabel.attributedText = autorAttributedString;
    
    font = [UIFont fontWithName:@"Futura-CondensedMedium" size:18.0];
    NSAttributedString *medioAttributedString = [[NSAttributedString alloc] initWithString:medio attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
    _medioLabel.attributedText = medioAttributedString;
    
    
    textColor = [[UIColor alloc] initWithRed:0.84 green:0.84 blue:0.84 alpha:1.0];
    font = [UIFont fontWithName:@"Futura-Book" size:18.0];
    NSAttributedString *contenidoAttributedString = [[NSAttributedString alloc] initWithString:contenido attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
    _contenidoTextView.attributedText = contenidoAttributedString;
    
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

@end
