//
//  CriticaUsuarioViewController.m
//  iFear
//
//  Created by Dacio Leal Rodriguez on 11/06/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import "CriticaUsuarioViewController.h"

@interface CriticaUsuarioViewController ()

@end

@implementation CriticaUsuarioViewController

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
    
    self.view.backgroundColor = [[UIColor alloc] initWithRed:239.0/255.0 green:210.0/255.0 blue:213.0/255.0 alpha:1.0];
    _descriptionTextView.backgroundColor = [[UIColor alloc] initWithRed:239.0/255.0 green:210.0/255.0 blue:213.0/255.0 alpha:1.0];
    
    NSString *usuario = _criticaUsuario.usuario;
    NSString *titulo = _criticaUsuario.titulo;
    NSString *fecha  = _criticaUsuario.fecha;
    NSString *contenido = _criticaUsuario.contenido;
    
    UIColor *textColor = [[UIColor alloc] initWithRed:0.28 green:0.02 blue:0.02 alpha:1.0];
    UIFont *font = [UIFont fontWithName:@"Futura-Light" size:18.0];
    NSAttributedString *userAttributedString = [[NSAttributedString alloc] initWithString:usuario attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
    _userLabel.attributedText = userAttributedString;
    
    font = [UIFont fontWithName:@"Futura-Medium" size:18.0];
    NSAttributedString *titleAttributedString = [[NSAttributedString alloc] initWithString:titulo attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
    _titleLabel.attributedText = titleAttributedString;
    
    textColor = [[UIColor alloc] initWithRed:0.28 green:0.02 blue:0.02 alpha:1.0];
    font = [UIFont fontWithName:@"Futura-Light" size:18.0];
    NSAttributedString *contenidoAttributedString = [[NSAttributedString alloc] initWithString:contenido attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
    _descriptionTextView.attributedText = contenidoAttributedString;
    
    textColor = [[UIColor alloc] initWithRed:0.28 green:0.02 blue:0.02 alpha:1.0];
    font = [UIFont fontWithName:@"Futura-Light" size:18.0];
    NSAttributedString *dateAttributedString = [[NSAttributedString alloc] initWithString:fecha attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
    _dateLabel.attributedText = dateAttributedString;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
