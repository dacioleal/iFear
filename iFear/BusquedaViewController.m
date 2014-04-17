//
//  BusquedaViewController.m
//  iFear
//
//  Created by Dacio Leal Rodriguez on 30/01/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import "BusquedaViewController.h"

@interface BusquedaViewController ()
{
    // Array para los subgeneros
    NSMutableArray * sub_Genre_List;
}

@end

@implementation BusquedaViewController

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
    
    // Se inicializa el Array de los subgeneros
    sub_Genre_List = [[NSMutableArray alloc] init];
    
    // Se establecen las imagenes a los estados del botón
    [self setImageForAllButtons];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


# pragma mark - IBAction

- (IBAction)pushBuscarButton:(id)sender {
    NSString  * url = @"http://localhost/EjemploConexionBD/peticion.php?XDEBUG_SESSION_START=netbeans-xdebug";
    [self setConnectionWithParameters: url];
}
- (IBAction)pushCategoriesButton:(id)sender {
    
    // Aquí se cambia el estado del botón presionado
    [self setStateCategoriesButton:sender];
    
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

- (IBAction)setStateSwitchs:(id)sender
{
    if ([sender tag] == 0) {
        self.buscarSubGenButton.selected = !self.buscarSubGenButton.selected;
    }else{
        self.buscarSensacionesButton.selected = !self.buscarSensacionesButton.selected;
    }
    
    
}

- (IBAction)showPopover:(id)sender
{
    if (self.popoverContent == nil) {
        self.popoverContent = [self.storyboard instantiateViewControllerWithIdentifier:@"PopoverSelectorBusqueda"];
        self.popoverContent.delegate = self;
    }
    
    
    if (self.selectorPopover == nil) {
        // Configura el popover
        self.selectorPopover = [[UIPopoverController alloc] initWithContentViewController:self.popoverContent];
        self.selectorPopover.popoverContentSize = CGSizeMake(200., 150.);
        self.selectorPopover.delegate = self;
        
        // Set the sender to a UIButton.
        UIButton *tappedButton = (UIButton *)sender;
        [self.selectorPopover presentPopoverFromRect:tappedButton.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        
    } else {
        //The color picker popover is showing. Hide it.
        [self.selectorPopover dismissPopoverAnimated:YES];
        self.selectorPopover = nil;
    }
}

#pragma mark - NSURLSessionDownloadDelegate -
// Donde primero entra al realizar la petición
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler
{
    
    // Para que la tarea continue normalmente.
    completionHandler(NSURLSessionResponseAllow);
}



// Al recibir los datos
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    
    NSDictionary *respuestaDictionario = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    
    NSArray * retorno = (NSArray *)[respuestaDictionario objectForKey:@"retorno"];
    
    
}




// Al finalizar

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error
{
    if(error == nil)
    {
        NSLog(@"Éxito al bajar");
        
        
        
    } else {
        
    }
}


#pragma mark - Métodos propios -



// Método para establecer las imagenes según el estado del Botón
-(void)setImageForAllButtons
{
    // Botones SWICHT SI/NO
    [self.buscarSensacionesButton setImage:[UIImage imageNamed:@"switch_SI_132x72.png"] forState:UIControlStateSelected];
    [self.buscarSensacionesButton setImage:[UIImage imageNamed:@"switch_NO_132x72.png"] forState:UIControlStateNormal];
    
    [self.buscarSubGenButton setImage:[UIImage imageNamed:@"switch_SI_132x72.png"] forState:UIControlStateSelected];
    [self.buscarSubGenButton setImage:[UIImage imageNamed:@"switch_NO_132x72.png"] forState:UIControlStateNormal];
    
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

// Método que busca un subgenero en el array y según esté lo añade o lo elimina
- (void) searchInArray: (NSString *) subgenre
{
    if (![sub_Genre_List containsObject:subgenre]) {
        [sub_Genre_List addObject:subgenre];
    }else{
        [sub_Genre_List removeObject:subgenre];
    }
}

// Método para establecer la conexión con el servidor
- (void) setConnectionWithParameters: (NSString *) serverUrl
{
    NSURLSessionConfiguration * configuracionConexion = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSData *body = [self getParamsArray];
    
    configuracionConexion.timeoutIntervalForRequest = 10.0;
    configuracionConexion.timeoutIntervalForResource = 10.0;
    
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: configuracionConexion delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL * url = [NSURL URLWithString:serverUrl];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:body];
    
    NSURLSessionDataTask * dataTask = [defaultSession dataTaskWithRequest:urlRequest];
    
    [dataTask resume];
    
}

- (NSData *) getParamsArray
{
    NSMutableString *bodyStr = [NSMutableString string];
    for (NSString *subgenre in sub_Genre_List) {
        [bodyStr appendFormat:@"function=buscaPorSubgenero&subgenres[]=%@&",[subgenre stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    
    NSData *body = [bodyStr dataUsingEncoding:NSUTF8StringEncoding];
    return body;
}

- (void) setStateCategoriesButton:(id)sender
{
    
    UIButton * btnAux = (UIButton *) sender;
    
    NSLog(@"%@", [btnAux restorationIdentifier]);
    
    btnAux.selected = !btnAux.selected;
}


# pragma mark - Popover Delegate -

- (void)setSearchSelector:(NSString *)selector
{
    if([self selectorPopover]){
        [[self selectorPopover] dismissPopoverAnimated:YES];
        self.selectorPopover = nil;
    }
    
    NSLog(@"%@",selector);
}


@end
