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
     _contentView.hidden = YES;
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.image = [UIImage imageNamed:@"icono_menu.png"];
    attachment.bounds = CGRectMake(0, -10, 30.0, 30.0);
    
    NSAttributedString *attachmentAttributedString = [NSAttributedString attributedStringWithAttachment:attachment];
    
    NSString *headerString = @"Bienvenido a iFear, la morada de los aficionados al cine de terror. Pulsa en los iconos de abajo para obtener información sobre las funciones de la aplicación. La navegación principal se realiza mediante el botón de menú          en la esquina superior derecha.";
    UIColor *textColor = [[UIColor alloc] initWithRed:0.96 green:0.85 blue:0.42 alpha:1.0];
    UIFont *font = [UIFont fontWithName:@"Futura-Light" size:18.0];
    NSMutableAttributedString *headerAttributedString = [[NSMutableAttributedString alloc] initWithString:headerString attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
    
    [headerAttributedString replaceCharactersInRange:NSMakeRange(222, 6) withAttributedString:attachmentAttributedString];
    
    _headerTextView.attributedText = headerAttributedString;
    _headerTextView.textAlignment = NSTextAlignmentCenter;
    
}



- (IBAction)menuPushButton:(UIButton *)sender {
    
    if (!_menuButton.selected) {
        
        [self headerTextView:@"MENÚ"];
        [self buttonsUnselected];
        _menuButton.selected = YES;
        
        
        // Texto del contenido de la descripción
        NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
        attachment.image = [UIImage imageNamed:@"ejemplo_menu_966x564.png"];
        attachment.bounds = CGRectMake(0, 50, 483.0, 282.0);
        
        NSAttributedString *attachmentAttributedString = [NSAttributedString attributedStringWithAttachment:attachment];
        
        NSString *descriptionString = @"Este es nuestro botón de MENÚ, desde donde podrás acceder a todas las secciones de iFear. Lo encontrarás siempre en la esquina superior derecha y, al pulsarlo, se desplegarán todas las opciones. Fácil, ¿no?\n\n\n";
        UIColor *textColor = [[UIColor alloc] initWithRed:0.78 green:0.78 blue:0.78 alpha:1.0];
        UIFont *font = [UIFont fontWithName:@"Futura-Book" size:18.0];
        NSMutableAttributedString *descriptionAttributedString = [[NSMutableAttributedString alloc] initWithString:descriptionString attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
        
        [descriptionAttributedString appendAttributedString:attachmentAttributedString];
        
        _descriptionTextView.attributedText = descriptionAttributedString;
        
        _contentView.hidden = NO;

        
    } else {
        [self buttonsUnselected];
        [self configureHeaderTextView];
    }
    
    
}

- (IBAction)busquedaPushButton:(UIButton *)sender {
    
    if (!_busquedaButton.selected) {
        
        [self headerTextView:@"BUSCAR PELÍCULA"];
        [self buttonsUnselected];
        _busquedaButton.selected = YES;
        
        
        // Texto del contenido de la descripción
        
        NSString *descriptionString = @"Este es el botón Buscar: un clásico. Sin embargo en iFear tienes nuevas formas de hacerlo. No sólo puedes hacer búsquedas por título, director o reparto, sino que también puedes realizar búsquedas específicas por subgénero (hay 26 diferentes: exorcismos, zombies, sectas, vampiros, casas encantadas...) o por sensaciones.\n\n¿QUÉ ES ESO DE BUSCAR POR SENSACIONES?\nEn iFear puedes valorar cada película";
        UIColor *textColor = [[UIColor alloc] initWithRed:0.78 green:0.78 blue:0.78 alpha:1.0];
        UIFont *font = [UIFont fontWithName:@"Futura-Book" size:18.0];
        NSMutableAttributedString *descriptionAttributedString = [[NSMutableAttributedString alloc] initWithString:descriptionString attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
        
        
        _descriptionTextView.attributedText = descriptionAttributedString;
        
        _contentView.hidden = NO;
        
        
    } else {
        [self buttonsUnselected];
        [self configureHeaderTextView];
    }

}

- (IBAction)carteleraPushButton:(UIButton *)sender {
    
    
    if (!_carteleraButton.selected) {
        
        [self headerTextView:@"CARTELERA"];
        [self buttonsUnselected];
        _carteleraButton.selected = YES;
        
        
        // Texto del contenido de la descripción
        
        NSString *descriptionString = @"";
        UIColor *textColor = [[UIColor alloc] initWithRed:0.78 green:0.78 blue:0.78 alpha:1.0];
        UIFont *font = [UIFont fontWithName:@"Futura-Book" size:18.0];
        NSMutableAttributedString *descriptionAttributedString = [[NSMutableAttributedString alloc] initWithString:descriptionString attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
        
        
        _descriptionTextView.attributedText = descriptionAttributedString;
        
        _contentView.hidden = NO;
        
        
    } else {
        [self buttonsUnselected];
        [self configureHeaderTextView];
    }

}

- (IBAction)mentesPushButton:(UIButton *)sender {
    
    
    
    if (!_mentesButton.selected) {
        
        [self headerTextView:@"MENTES OSCURAS"];
        [self buttonsUnselected];
        _mentesButton.selected = YES;
        
        
        // Texto del contenido de la descripción
        
        NSString *descriptionString = @"";
        UIColor *textColor = [[UIColor alloc] initWithRed:0.78 green:0.78 blue:0.78 alpha:1.0];
        UIFont *font = [UIFont fontWithName:@"Futura-Book" size:18.0];
        NSMutableAttributedString *descriptionAttributedString = [[NSMutableAttributedString alloc] initWithString:descriptionString attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
        
        
        _descriptionTextView.attributedText = descriptionAttributedString;
        
        _contentView.hidden = NO;
        
        
    } else {
        [self buttonsUnselected];
        [self configureHeaderTextView];
    }

}

- (IBAction)actividadPushButton:(UIButton *)sender {
    
    
    if (!_actividadButton.selected) {
        
        [self headerTextView:@"ACTIVIDAD ZOMBIE"];
        [self buttonsUnselected];
        _actividadButton.selected = YES;
        
        
        // Texto del contenido de la descripción
        
        NSString *descriptionString = @"";
        UIColor *textColor = [[UIColor alloc] initWithRed:0.78 green:0.78 blue:0.78 alpha:1.0];
        UIFont *font = [UIFont fontWithName:@"Futura-Book" size:18.0];
        NSMutableAttributedString *descriptionAttributedString = [[NSMutableAttributedString alloc] initWithString:descriptionString attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
        
        
        _descriptionTextView.attributedText = descriptionAttributedString;
        
        _contentView.hidden = NO;
        
        
    } else {
        [self buttonsUnselected];
        [self configureHeaderTextView];
    }
}

- (IBAction)optionsPushButton:(UIButton *)sender {
    
    if (!_optionsButton.selected) {
        
        [self headerTextView:@"OPCIONES"];
        [self buttonsUnselected];
        _optionsButton.selected = YES;
        
        
        // Texto del contenido de la descripción
        
        NSString *descriptionString = @"";
        UIColor *textColor = [[UIColor alloc] initWithRed:0.78 green:0.78 blue:0.78 alpha:1.0];
        UIFont *font = [UIFont fontWithName:@"Futura-Book" size:18.0];
        NSMutableAttributedString *descriptionAttributedString = [[NSMutableAttributedString alloc] initWithString:descriptionString attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
        
        
        _descriptionTextView.attributedText = descriptionAttributedString;
        
        _contentView.hidden = NO;
        
        
    } else {
        [self buttonsUnselected];
        [self configureHeaderTextView];
    }

}

- (void) headerTextView: (NSString *) string
{
    NSString *headerString = [[NSString alloc] initWithString:string];
    UIColor *textColor = [[UIColor alloc] initWithRed:0.84 green:0.1 blue:0.01 alpha:1.0];
    UIFont *font = [UIFont fontWithName:@"Impact" size:64.0];
    NSAttributedString *headerAttributedString = [[NSAttributedString alloc] initWithString:headerString attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
    _headerTextView.attributedText = headerAttributedString;
    _headerTextView.textAlignment = NSTextAlignmentCenter;
}
- (void) buttonsUnselected
{
    _menuButton.selected = NO;
    _busquedaButton.selected = NO;
    _carteleraButton.selected = NO;
    _mentesButton.selected = NO;
    _actividadButton.selected = NO;
    _optionsButton.selected = NO;
    
}
@end
















