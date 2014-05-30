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
    
     // Inserción de la imagen del botón MENÚ dentro del texto
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.image = [UIImage imageNamed:@"icono_menu.png"];
    attachment.bounds = CGRectMake(0, -10, 30.0, 30.0);
    NSAttributedString *attachmentAttributedString = [NSAttributedString attributedStringWithAttachment:attachment];
    
    // Configuración del texto del contenido de la descripción
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
        
        
        // Inserción de la imagen de la barra de menú dentro del texto
        NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
        attachment.image = [UIImage imageNamed:@"ejemplo_menu_966x564.png"];
        attachment.bounds = CGRectMake(0, 50, 483.0, 282.0);
        NSAttributedString *attachmentAttributedString = [NSAttributedString attributedStringWithAttachment:attachment];
        
        // Configuración del texto del contenido de la descripción
        NSString *descriptionString = @"Este es nuestro botón de MENÚ, desde donde podrás acceder a todas las secciones de iFear. Lo encontrarás en la esquina superior derecha y, al pulsarlo, se desplegarán todas las opciones. Fácil, ¿no?\n\n\n";
        UIColor *textColor = [[UIColor alloc] initWithRed:0.78 green:0.78 blue:0.78 alpha:1.0];
        UIFont *font = [UIFont fontWithName:@"Futura-Book" size:18.0];
        NSMutableAttributedString *descriptionAttributedString = [[NSMutableAttributedString alloc] initWithString:descriptionString attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
        
        [descriptionAttributedString appendAttributedString:attachmentAttributedString];
        
        // Cambio del atributo de color para las partes del texto en amarillo
        textColor = [[UIColor alloc] initWithRed:0.89 green:0.65 blue:0.08 alpha:1.0];
        NSRange range;
        range.location = 25;
        range.length = 4;
        [descriptionAttributedString addAttribute:NSForegroundColorAttributeName value:textColor range:range];
        range.location = 187;
        range.length = 11;
        [descriptionAttributedString addAttribute:NSForegroundColorAttributeName value:textColor range:range];
        
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
        
        
        // Configuración del texto del contenido de la descripción
        NSString *descriptionString = @"Este es el botón BUSCAR: un clásico. Sin embargo en iFear tienes nuevas formas de hacerlo. No sólo puedes hacer búsquedas por título, director o reparto, sino que también puedes realizar búsquedas específicas por subgénero (hay 26 diferentes: exorcismos, zombies, sectas, vampiros, casas encantadas...) o por sensaciones.\n\n¿QUÉ ES ESO DE BUSCAR POR SENSACIONES?\nEn iFear puedes valorar cada película mediante 4 parámetros principales: Terror, Gore, Humor y Calidad, con valores que van del 0 al 100%. Tu valoración se sumará a la de todos los usuarios y creará un valor medio para cada película. Así podrás realizar búsquedas de títulos que, por ejemplo, tengan una puntuación de más del 50% en Terror, más del 65% en Calidad General, más del 35% en Gore ¡o todo a la vez!";
        UIColor *textColor = [[UIColor alloc] initWithRed:0.78 green:0.78 blue:0.78 alpha:1.0];
        UIFont *font = [UIFont fontWithName:@"Futura-Book" size:18.0];
        NSMutableAttributedString *descriptionAttributedString = [[NSMutableAttributedString alloc] initWithString:descriptionString attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
        
        // Cambio del atributo de color para las partes del texto en amarillo
        textColor = [[UIColor alloc] initWithRed:0.89 green:0.65 blue:0.08 alpha:1.0];
        NSRange range;
        range.location = 17;
        range.length = 6;
        [descriptionAttributedString addAttribute:NSForegroundColorAttributeName value:textColor range:range];
        range.location = 209;
        range.length = 13;
        [descriptionAttributedString addAttribute:NSForegroundColorAttributeName value:textColor range:range];
        range.location = 322;
        range.length = 39;
        [descriptionAttributedString addAttribute:NSForegroundColorAttributeName value:textColor range:range];
        range.location = 435;
        range.length = 6;
        [descriptionAttributedString addAttribute:NSForegroundColorAttributeName value:textColor range:range];
        range.location = 443;
        range.length = 4;
        [descriptionAttributedString addAttribute:NSForegroundColorAttributeName value:textColor range:range];
        range.location = 449;
        range.length = 5;
        [descriptionAttributedString addAttribute:NSForegroundColorAttributeName value:textColor range:range];
        range.location = 457;
        range.length = 7;
        [descriptionAttributedString addAttribute:NSForegroundColorAttributeName value:textColor range:range];
        range.location = 755;
        range.length = 17;
        [descriptionAttributedString addAttribute:NSForegroundColorAttributeName value:textColor range:range];
        
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
        
        // Configuración del texto del contenido de la descripción
        NSString *descriptionString = @"En esta sección puedes consultar las películas que hay actualmente en los cines, además de conocer los próximos estrenos del año. Podrás acceder a su ficha completa y ver los trailers disponibles en cada momento. Y como hay muchos títulos que se publican sin pasar por las salas, también te incluimos las películas editadas en formato DVD y BLU-Ray, desde lo más comercial a lo más underground.\n\n\n";
        UIColor *textColor = [[UIColor alloc] initWithRed:0.78 green:0.78 blue:0.78 alpha:1.0];
        UIFont *font = [UIFont fontWithName:@"Futura-Book" size:18.0];
        NSMutableAttributedString *descriptionAttributedString = [[NSMutableAttributedString alloc] initWithString:descriptionString attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
        
        //Cambio del atributo de color para las partes del texto en amarillo
        textColor = [[UIColor alloc] initWithRed:0.89 green:0.65 blue:0.08 alpha:1.0];
        NSRange range;
        range.location = 103;
        range.length = 17;
        [descriptionAttributedString addAttribute:NSForegroundColorAttributeName value:textColor range:range];
        range.location = 335;
        range.length = 3;
        [descriptionAttributedString addAttribute:NSForegroundColorAttributeName value:textColor range:range];
        range.location = 341;
        range.length = 7;
        [descriptionAttributedString addAttribute:NSForegroundColorAttributeName value:textColor range:range];
        
        [descriptionAttributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@"   "]];
        
        // Inserción de las imágenes de los logos CINE y DVD dentro del TextView
        NSTextAttachment *attachmentLogoCine = [[NSTextAttachment alloc] init];
        attachmentLogoCine.image = [UIImage imageNamed:@"icono_cine_304x224.png"];
        attachmentLogoCine.bounds = CGRectMake(0, 0, 152.0, 112.0);
        NSAttributedString *attachmentAttributedString = [NSAttributedString attributedStringWithAttachment:attachmentLogoCine];
        [descriptionAttributedString appendAttributedString:attachmentAttributedString];
        
        [descriptionAttributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@"                        "]];
        
        NSTextAttachment *attachmentLogoDVD = [[NSTextAttachment alloc] init];
        attachmentLogoDVD.image = [UIImage imageNamed:@"icono_dvd_366x260.png"];
        attachmentLogoDVD.bounds = CGRectMake(0, -8, 183.0, 130.0);
        attachmentAttributedString = [NSAttributedString attributedStringWithAttachment:attachmentLogoDVD];
        [descriptionAttributedString appendAttributedString:attachmentAttributedString];
        
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
        
        // Configuración del texto del contenido de la descripción
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
        
        // Configuración del texto del contenido de la descripción
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
        
        // Configuración del texto del contenido de la descripción
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
    //Configuración del texto que aparece en la cabecera de la pantalla
    NSString *headerString = [[NSString alloc] initWithString:string];
    UIColor *textColor = [[UIColor alloc] initWithRed:0.84 green:0.1 blue:0.01 alpha:1.0];
    UIFont *font = [UIFont fontWithName:@"Impact" size:64.0];
    NSAttributedString *headerAttributedString = [[NSAttributedString alloc] initWithString:headerString attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
    _headerTextView.attributedText = headerAttributedString;
    _headerTextView.textAlignment = NSTextAlignmentCenter;
}
- (void) buttonsUnselected
{
    // Quitamos la selección de todos los botones, se utiliza cuando pulsamos de nuevo un botón que ya estaba activado para desactivarlo
    _menuButton.selected = NO;
    _busquedaButton.selected = NO;
    _carteleraButton.selected = NO;
    _mentesButton.selected = NO;
    _actividadButton.selected = NO;
    _optionsButton.selected = NO;
    
}
@end
















