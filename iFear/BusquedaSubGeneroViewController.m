//
//  BusquedaSubGeneroViewController.m
//  iFear
//
//  Created by José Alberto Martín Falcón on 20/04/14.
//  Copyright (c) 2014 José Alberto Martín Falcón. All rights reserved.
//

#import "BusquedaSubGeneroViewController.h"

@interface BusquedaSubGeneroViewController ()
{
    // Array para los subgeneros
    NSMutableArray * sub_Genre_List;
    int buttonsSelected;
}

@end

@implementation BusquedaSubGeneroViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Se inicializa el array
    sub_Genre_List = [[NSMutableArray alloc] init];
    
    // Se establecen las imagenes según el estado del botón
    [self setImageForAllButtons];
    buttonsSelected = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


# pragma mark - IBAction
- (IBAction)pushCategoriesButton:(id)sender {
    
    // Aquí se cambia el estado del botón presionado
    [self setStateCategoriesButton:sender];
    
    
    // Se utiliza la llamada al método delegado para ir sabiendo que elementos se están añadiendo
    [[self delegate] getSelectedSubGenre:sub_Genre_List];
}


#pragma mark - Métodos propios -
// Método que busca un subgenero en el array y según esté lo añade o lo elimina
- (void) searchInArray: (NSString *) subgenre
{
    if (![sub_Genre_List containsObject:subgenre]) {
        [sub_Genre_List addObject:subgenre];
    }else{
        [sub_Genre_List removeObject:subgenre];
    }
}

- (void) manageSubGenreArray:(id) sender
{
    // SWITCH QUE MANEJA QUE BOTÓN SE HA PULSADO
    switch ([sender tag]) {
            
            // Animación
        case 1:
            [self searchInArray:ANIMACION];
            break;
            
            // Catástrofes
        case 2:
            [self searchInArray:CATASTROFE];
            break;
            
            // Cortometraje
        case 3:
            [self searchInArray:CORTOMETRAJE];
            break;
            
            // Exorcismos
        case 4:
            [self searchInArray:EXORCISMO];
            break;
            
            // J-Horror
        case 5:
            [self searchInArray:JHORROR];
            break;
            
            // Monstruos
        case 6:
            [self searchInArray:MONSTRUOS];
            break;
            
            // Asesinos en serie
        case 7:
            [self searchInArray:ASESINOSSERIE];
            break;
            
            // Ciencia-ficción
        case 8:
            [self searchInArray:SCIFI];
            break;
            
            // Documental
        case 9:
            [self searchInArray:DOCUMENTAL];
            break;
            
            // Falso documental
        case 10:
            [self searchInArray:FAKE];
            break;
            
            // Licántropos
        case 11:
            [self searchInArray:LICANTROPOS];
            break;
            
            // Sectas
        case 12:
            [self searchInArray:SECTAS];
            break;
            
            // Vampiros
        case 13:
            [self searchInArray:VAMPIROS];
            break;
            
            // Basada en hechos reales
        case 14:
            [self searchInArray:HECHOSREALES];
            break;
            
            // Comedia//Parodia
        case 15:
            [self searchInArray:COMEDIA];
            break;
            
            // Enfermedades
        case 16:
            [self searchInArray:ENFERMEDADES];
            break;
            
            // Fantasmas
        case 17:
            [self searchInArray:FANTASMAS];
            break;
            
            // Manicomios
        case 18:
            [self searchInArray:MANICOMIOS];
            break;
            
            // Secuela//Precuela
        case 19:
            [self searchInArray:SECUELA];
            break;
            
            // Zombies
        case 20:
            [self searchInArray:ZOMBIES];
            break;
            
            // Brujería
        case 21:
            [self searchInArray:BRUJERIA];
            break;
            
            // Casas encantadas
        case 22:
            [self searchInArray:CASASENCANTADAS];
            break;
            
            // Extraterrestres
        case 23:
            [self searchInArray:EXTRATERRESTRES];
            break;
            
            // Giallo
        case 24:
            [self searchInArray:GIALLO];
            break;
            
            // Metraje encontrado
        case 25:
            [self searchInArray:METRAJE];
            break;
            
            // Serie TV
        case 26:
            [self searchInArray:SERIETV];
            break;
    }
    
}

// Método para establecer si está seleccionado o no un botón
//- (void) setStateCategoriesButton:(id)sender
//{
//    NSLog(@" Cuando comprueba: %i",buttonsSelected);
//
//    UIButton * btnAux = (UIButton *) sender;
//
//    if (buttonsSelected <= 3) {
//
//        if (buttonsSelected == 3) {
//            if (btnAux.selected) {
//                btnAux.selected = false;
//                buttonsSelected--;
//                [self manageSubGenreArray:sender];
//
//            }else{
//                [self showMessage];
//            }
//        }else{
//            btnAux.selected = !btnAux.selected;
//            if (btnAux.selected) {
//                buttonsSelected++;
//                [self manageSubGenreArray:sender];
//            }else{
//                buttonsSelected--;
//                [self manageSubGenreArray:sender];
//
//            }
//        }
//    }

- (void) setStateCategoriesButton:(id)sender
{
    UIButton * btnAux = (UIButton *) sender;
    
    if (sub_Genre_List.count <= 3) {
        
        if (sub_Genre_List.count == 3) {
            if (btnAux.selected) {
                btnAux.selected = false;
                [self manageSubGenreArray:sender];
            }else{
                [self showMessage];
            }
        }else{
            btnAux.selected = !btnAux.selected;
            [self manageSubGenreArray:sender];
            
        }
    }
    
    
    
}

// Método para establecer las imagenes según el estado del Botón
-(void)setImageForAllButtons
{
    // Botones de subgeneros
    [self.animacionButton setImage:[UIImage imageNamed:@"boton_animacion_ON_465x127.png"] forState:UIControlStateSelected];
    [self.animacionButton setImage:[UIImage imageNamed:@"boton_animacion_465x127.png"] forState:UIControlStateNormal];
    
    [self.catastrofeButton setImage:[UIImage imageNamed:@"boton_catastrofe_ON_465x127.png"] forState:UIControlStateSelected];
    [self.catastrofeButton setImage:[UIImage imageNamed:@"boton_catastrofe_465x127.png"] forState:UIControlStateNormal];
    
    [self.cortometrajeButton setImage:[UIImage imageNamed:@"boton_cortomet_ON_465x127.png"] forState:UIControlStateSelected];
    [self.cortometrajeButton setImage:[UIImage imageNamed:@"boton_cortomet_465x127.png"] forState:UIControlStateNormal];
    
    [self.exorcismosButton setImage:[UIImage imageNamed:@"boton_exorcismos_ON_465x127.png"] forState:UIControlStateSelected];
    [self.exorcismosButton setImage:[UIImage imageNamed:@"boton_exorcismos_465x127.png"] forState:UIControlStateNormal];
    
    [self.jHorrorButton setImage:[UIImage imageNamed:@"boton_jhorror_ON_465x127.png"] forState:UIControlStateSelected];
    [self.jHorrorButton setImage:[UIImage imageNamed:@"boton_jhorror_465x127.png"] forState:UIControlStateNormal];
    
    [self.monstruosButton setImage:[UIImage imageNamed:@"boton_monstruos_ON_465x127.png"] forState:UIControlStateSelected];
    [self.monstruosButton setImage:[UIImage imageNamed:@"boton_monstruos_465x127.png"] forState:UIControlStateNormal];
    
    [self.asesinosSeriesButton setImage:[UIImage imageNamed:@"boton_asesinos_ON_465x127.png"] forState:UIControlStateSelected];
    [self.asesinosSeriesButton setImage:[UIImage imageNamed:@"boton_asesinos_465x127.png"] forState:UIControlStateNormal];
    
    [self.sciFyButton setImage:[UIImage imageNamed:@"boton_Ci_Fi_ON_465x127.png"] forState:UIControlStateSelected];
    [self.sciFyButton setImage:[UIImage imageNamed:@"boton_Ci_Fi_465x127.png"] forState:UIControlStateNormal];
    
    [self.documentalButton setImage:[UIImage imageNamed:@"boton_documental_ON_465x127.png"] forState:UIControlStateSelected];
    [self.documentalButton setImage:[UIImage imageNamed:@"boton_documental_465x127.png"] forState:UIControlStateNormal];
    
    [self.fakeButton setImage:[UIImage imageNamed:@"boton_fake_ON_465x127.png"] forState:UIControlStateSelected];
    [self.fakeButton setImage:[UIImage imageNamed:@"boton_fake_465x127.png"] forState:UIControlStateNormal];
    
    [self.licantropos setImage:[UIImage imageNamed:@"boton_licantropo_ON_465x127.png"] forState:UIControlStateSelected];
    [self.licantropos setImage:[UIImage imageNamed:@"boton_licantropo_465x127.png"] forState:UIControlStateNormal];
    
    [self.sectasButton setImage:[UIImage imageNamed:@"boton_sectas_ON_465x127.png"] forState:UIControlStateSelected];
    [self.sectasButton setImage:[UIImage imageNamed:@"boton_sectas_465x127.png"] forState:UIControlStateNormal];
    
    [self.vampirosButton setImage:[UIImage imageNamed:@"boton_vampiros_ON_465x127.png"] forState:UIControlStateSelected];
    [self.vampirosButton setImage:[UIImage imageNamed:@"boton_vampiros_465x127.png"] forState:UIControlStateNormal];
    
    [self.hechosRealesButton setImage:[UIImage imageNamed:@"boton_realidad_ON_465x127.png"] forState:UIControlStateSelected];
    [self.hechosRealesButton setImage:[UIImage imageNamed:@"boton_realidad_465x127.png"] forState:UIControlStateNormal];
    
    [self.comediaButton setImage:[UIImage imageNamed:@"boton_comedia_ON_465x127.png.png"] forState:UIControlStateSelected];
    [self.comediaButton setImage:[UIImage imageNamed:@"boton_comedia_465x127.png.png"] forState:UIControlStateNormal];
    
    [self.enfermedadesButton setImage:[UIImage imageNamed:@"boton_enfermedad_ON_465x127.png.png"] forState:UIControlStateSelected];
    [self.enfermedadesButton setImage:[UIImage imageNamed:@"boton_enfermedad_465x127.png.png"] forState:UIControlStateNormal];
    
    [self.fantasmasButton setImage:[UIImage imageNamed:@"boton_fantasmas_ON_465x127.png"] forState:UIControlStateSelected];
    [self.fantasmasButton setImage:[UIImage imageNamed:@"boton_fantasmas_465x127.png"] forState:UIControlStateNormal];
    
    [self.manicomiosButton setImage:[UIImage imageNamed:@"boton_manicomio_ON_465x127.png"] forState:UIControlStateSelected];
    [self.manicomiosButton setImage:[UIImage imageNamed:@"boton_manicomio_465x127.png"] forState:UIControlStateNormal];
    
    [self.secuelaButton setImage:[UIImage imageNamed:@"boton_secuela_ON_465x127.png"] forState:UIControlStateSelected];
    [self.secuelaButton setImage:[UIImage imageNamed:@"boton_secuela_465x127.png"] forState:UIControlStateNormal];
    
    [self.zombiesButton setImage:[UIImage imageNamed:@"boton_zombies_ON_465x127.png"] forState:UIControlStateSelected];
    [self.zombiesButton setImage:[UIImage imageNamed:@"boton_zombies_465x127.png"] forState:UIControlStateNormal];
    
    
    [self.brujeriaButton setImage:[UIImage imageNamed:@"boton_brujeria_ON_465x127.png.png"] forState:UIControlStateSelected];
    [self.brujeriaButton setImage:[UIImage imageNamed:@"boton_brujeria_465x127.png.png"] forState:UIControlStateNormal];
    
    [self.casasEncanButton setImage:[UIImage imageNamed:@"boton_casas_enc_ON_465x127.png.png"] forState:UIControlStateSelected];
    [self.casasEncanButton setImage:[UIImage imageNamed:@"boton_casas_enc_465x127.png.png"] forState:UIControlStateNormal];
    
    [self.extraterrestresButton setImage:[UIImage imageNamed:@"boton_extraterre_ON_465x127.png"] forState:UIControlStateSelected];
    [self.extraterrestresButton setImage:[UIImage imageNamed:@"boton_extraterre_465x127.png"] forState:UIControlStateNormal];
    
    [self.gialloButton setImage:[UIImage imageNamed:@"boton_giallo_ON_465x127.png"] forState:UIControlStateSelected];
    [self.gialloButton setImage:[UIImage imageNamed:@"boton_giallo_465x127.png"] forState:UIControlStateNormal];
    
    [self.metrajeEncontradoButton setImage:[UIImage imageNamed:@"boton_metraje_ON_465x127.png"] forState:UIControlStateSelected];
    [self.metrajeEncontradoButton setImage:[UIImage imageNamed:@"boton_metraje_465x127.png"] forState:UIControlStateNormal];
    
    [self.serieTvButton setImage:[UIImage imageNamed:@"boton_serie_ON_465x127.png"] forState:UIControlStateSelected];
    [self.serieTvButton setImage:[UIImage imageNamed:@"boton_serie_465x127.png"] forState:UIControlStateNormal];
}

- (void)showMessage {
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Búsqueda"
                                                      message:@"No se puede seleccionar más de tres géneros"
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    
    [message show];
}

- (void) enabledAllButtons: (Boolean) state
{
    for (UIButton * btn in self.listButons) {
        [btn setEnabled:state];
    }
}

- (void) selectAllButtons: (Boolean) state
{
    for (UIButton * btn in self.listButons) {
        [btn setSelected:state];
    }
}


@end
