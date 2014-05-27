//
//  QueEsViewController.m
//  iFear
//
//  Created by Dacio Leal Rodriguez on 26/05/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import "QueEsViewController.h"
#import "MainViewController.h"

@interface QueEsViewController ()
{
    
}

@end

@implementation QueEsViewController

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
    MainViewController *mainViewController = (MainViewController *) self.parentViewController;
    [mainViewController unSelectIcons];
    
    [self configureHeaderTextView];
    
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

- (void) configureHeaderTextView
{
    NSString *headerString = @"Bienvenido a iFear, la morada de los aficionados al cine de terror. Pulsa en los iconos de abajo para obtener información sobre las funciones de la aplicación. La navegación principal se realiza mediante el botón de menú        en la esquina superior derecha.";
    UIColor *textColor = [[UIColor alloc] initWithRed:0.96 green:0.85 blue:0.42 alpha:1.0];
    UIFont *font = [UIFont fontWithName:@"Futura-Light" size:18.0];
    NSAttributedString *headerAttributedString = [[NSAttributedString alloc] initWithString:headerString attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
    
    _headerTextView.attributedText = headerAttributedString;
    _headerTextView.textAlignment = NSTextAlignmentCenter;
    
}



@end
















