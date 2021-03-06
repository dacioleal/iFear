//
//  BusquedaViewController.m
//  iFear
//
//  Created by José Alberto Martín Falcón on 01/05/14.
//  Copyright (c) 2014 José Alberto Martín Falcón. All rights reserved.
//

#import "BusquedaViewController.h"
#import "SubGenreSearch.h"
#import "SensationsSearch.h"
#import "ParametersSearch.h"
#import "ResultadosBusquedaViewController.h"
#import "Pelicula.h"
#import "ResultadosBusquedaViewController.h"
#import "IfearAlertView.h"

@interface BusquedaViewController ()
{
    // Array para los resultados de búsqueda tanto por subgenero como por sensaciones
    NSArray * resultMovies;
    
    // Array en donde estarán que subgeneros se han seleccionado
    NSMutableArray *sub_genre_list;
    
    // Diccionario donde se almacenarán los valores elegidos para la búsqueda por sensaciones
    NSMutableDictionary *sensationsValues;
    
    // Diccionario donde se almacenarán el parámetro de búsqueda por párametro
    NSMutableDictionary *movieParameterSearch;
    
    // Clase que permite la búsqueda por subgenero
    SubGenreSearch * subGenreSearch;
    
    // Clase que permite la búsqueda por sensaciones
    SensationsSearch * sensationSearch;
    
    // Clase que permite la búsqueda por parametro de pelicula (Título, Director, Reparto)
    ParametersSearch * parameterSearch;
    
    // ViewController que está mostrándose en estos momentos
    UIViewController * onScreenViewController;
    
    // Viewcontrollers de tipo de búsqueda
    BusquedaSubGeneroViewController * busquedaSubGenereVC;
    BusquedaSensacionesViewController * busquedaSensacionesVC;
    
    // Booleano para controlar si ha pulsado sobre la caja de texto
    Boolean pushInTextSearchField;
    
    // AlertView
    IfearAlertView * alert;
}

@end

@implementation BusquedaViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

#pragma mark - ViewController -
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _container.layer.opacity = 0.9;
    
    // Se obtiene el container de la búsqueda por subgenero
    busquedaSubGenereVC = [self.storyboard instantiateViewControllerWithIdentifier:@"busquedaSubGeneroViewController"];
    busquedaSubGenereVC.delegate = self;
    
    // Se obtiene el container de la búsqueda por sensaciones
    busquedaSensacionesVC = [self.storyboard instantiateViewControllerWithIdentifier:@"busquedaSensacionesViewController"];
    busquedaSensacionesVC.delegate = self;
    
    
    // Se inicializan las clases encargadas de la conexión y búsqueda con el servidor
    subGenreSearch = [[SubGenreSearch alloc] init];
    [subGenreSearch setAssociateVC:self];
    sensationSearch = [[SensationsSearch alloc] init];
    [sensationSearch setAssociateVC:self];
    parameterSearch = [[ParametersSearch alloc]init];
    [parameterSearch setAssociateVC:self];
    
    // Variables auxiliares para los distintos parámetros de búsqueda
    sub_genre_list = [[NSMutableArray alloc] init];
    sensationsValues = [[NSMutableDictionary alloc] init];
    movieParameterSearch = [[NSMutableDictionary alloc] init];
    
    // Añadimos este ViewController (self) como observador para recibir las notificaciones de que se han terminado de descargar los datos
    // y de que se pulsa sobre la portada de una película para ir a la pantalla de detalle.
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(goToResultViewController) name:@"dataFinished" object:subGenreSearch];
    [defaultCenter addObserver:self selector:@selector(goToResultViewController) name:@"dataFinished" object:sensationSearch];
    [defaultCenter addObserver:self selector:@selector(goToResultViewController) name:@"dataFinished" object:parameterSearch];
    
    // Se establecen las imagenes a los estados del botón
    [self setImageForAllButtons];
    
    // Se establece seleccionado la opción de búsqueda por subgenero
    self.buscarSubGenButton.selected = YES;
    [self displayContentViewController:busquedaSubGenereVC];
    
    // Se inicializa a falso el haber pulsado en el edit text para buscar algo
    pushInTextSearchField = false;
    self.textFieldSearch.delegate = self;
    
    // Se inicializa el parámetro a título para el caso de que el usuario busque por título, al estar la opción por defecto de título puesto es la que se manda.
    [movieParameterSearch setObject:@"titulo" forKey:@"parametro"];
    
    // Se inicializa el alert
    alert = [IfearAlertView new];
    
    // Se oculta el icono de carga
    [self showLoadingView:NO];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - IBAction

// Método que se usa cuando se pulsa el botón buscar
- (IBAction)pushBuscarButton:(id)sender {
    
    // Se pregunta que botón de tipo búsqueda está seleccionado para saber que búsqueda está realizando
    
    // BÚSQUEDA POR CAJA DE TEXTO
    if (pushInTextSearchField) {
        // Se obtiene que ha introducido el usuario
        NSString * busqueda = [self.textFieldSearch.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        // Comprueba que no esté vacio para realizar la búsqueda
        if (! [busqueda isEqualToString:@""]) {
            // Se comprueba que view de búsqueda está activa para seleccionar un botón u otro
            if ([onScreenViewController.title isEqualToString:@"BusquedaSubgenero"]) {
                [self.buscarSubGenButton setSelected:true];
            }else{
                [self.buscarSensacionesButton setSelected:true];
            }
            
            // Se realiza la búsqueda
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [self searchByMovieParameter];
            });
        }else{
            [alert showAlert:self withMessage:@"No ha escrito ningún valor para la búsqueda"];
        }
        // BÚSQUEDA POR SUBGENERO
    }else if ([self.buscarSubGenButton isSelected]) {
        // Se comprueba que efectivamente el usuario ha seleccionaro por lo menos un subgenero
        if (sub_genre_list.count > 0) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [self searchBySubGenere];
            });
        }else{
            [alert showAlert:self withMessage:@"No ha seleccionado ningún género para la búsqueda"];
        }
        // BÚSQUEDA POR SENSACIONES
    }else{
        // Se controla si se ha seleccionado algo
        // TODO preguntar si esto irá así o hay que seleccionar algo verdaderamente
        if ([sensationsValues count] > 0) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                [self searchBySensations];
            });
        }else{
            [alert showAlert:self withMessage:@"No ha seleccionado ninguna sensación"];
        }
        
    }
}

// Cambia el estado de los botones de elección del tipo de búsqueda SI/NO
- (IBAction)setStateSwitchs:(id)sender
{
   
    // SUBGENERO
    if ([sender tag] == 0) {
        /*
         * Esto se hace para saber si está en la misma pantalla y ha pulsado sobre el mismo botón.
         * Es decir, Imaginemos que está seleccionado buscar por subgenero y el botón está en SI, en el
         * caso de que vuelva a pulsar el mismo botón que no ocurra nada
         */
        if (! [self.buscarSubGenButton isSelected]) {
            // Resetea la búsqueda por caja de texto
            [self resetTextField];
            
            // Si se viene de la vista de sensaciones se cambia a subgenero
            if ([onScreenViewController.title isEqualToString:@"BusquedaSensaciones"]) {
                self.buscarSubGenButton.selected = !self.buscarSubGenButton.selected;
                self.buscarSensacionesButton.selected = !self.buscarSubGenButton.selected;
                // Se cambia el tipo de búsqueda en el container.
                [self cycleFromViewController:onScreenViewController toViewController:busquedaSubGenereVC];
                
                // Se activan los sliders para el caso de que estuviesen desactivados
                [busquedaSensacionesVC enableAllSliders:true];
                // Se resetean los slider de sensaciones para que no queden guardados
                [busquedaSensacionesVC resetSliders];
                //[sensationsValues removeAllObjects];
                
            }else{
                // Activa los botones de subgeneros
                [busquedaSubGenereVC enabledAllButtons:true];
                // Activa el botón de búsqueda por subgenero a SI
                [self.buscarSubGenButton setSelected:true];
            }
            
        }
        // SENSACIONES
    }else{
        
        if (! [self.buscarSensacionesButton isSelected]) {
            [self resetTextField];
            // Si se viene de la vista de búsqueda por subgenero se cambia a sensaciones
            if ([onScreenViewController.title isEqualToString:@"BusquedaSubgenero"]) {
                self.buscarSensacionesButton.selected = !self.buscarSensacionesButton.selected;
                self.buscarSubGenButton.selected = !self.buscarSensacionesButton.selected;
                
                // Se cambia el tipo de búsqueda en el container.
                [self cycleFromViewController:onScreenViewController toViewController:busquedaSensacionesVC];
                
                
                // Se activan todos los botones para el caso de que estuviesen desactivados
                [busquedaSubGenereVC enabledAllButtons:true];
                // Se resetea los subgeneros para que no queden marcados ni guardados
                [busquedaSubGenereVC selectAllButtons:false];
                [sub_genre_list removeAllObjects];
            }else{
                [self.buscarSensacionesButton setSelected:true];
                [busquedaSensacionesVC enableAllSliders:true];
                [busquedaSensacionesVC resetSliders];
                
                [busquedaSubGenereVC enabledAllButtons:true];
                // Desactiva los botones seleccionados
                [busquedaSubGenereVC selectAllButtons:false];
                // Elimina todo objeto de subgenero para la búsqueda
                [sub_genre_list removeAllObjects];
            }
            
        }
    }
}


// Método que muestra el popover
- (IBAction)showPopover:(id)sender
{
    if (self.popoverContent == nil) {
        
        self.popoverContent = [self.storyboard instantiateViewControllerWithIdentifier:@"PopoverSelectorBusqueda"];
        self.popoverContent.delegate = self;
    }
    
    // Configura el popover
    self.selectorPopover = [[UIPopoverController alloc] initWithContentViewController:self.popoverContent];
    self.selectorPopover.popoverContentSize = CGSizeMake(159., 81.);
    self.selectorPopover.backgroundColor = [UIColor colorWithRed:(43/255.0) green:(43/255.0) blue:(22/255.0) alpha:1] ;
    self.selectorPopover.delegate = self;
    
    // Set the sender to a UIButton.
    UIButton *tappedButton = (UIButton *)sender;
    [self.selectorPopover presentPopoverFromRect:tappedButton.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}




#pragma mark - Métodos propios -

- (void) showLoadingView: (BOOL) shown
{
    if (shown) {
        self.loadingView.hidden = NO;
        [self.activityIndicator startAnimating];
    }else{
        self.loadingView.hidden = YES;
        [self.activityIndicator stopAnimating];
    }
}

// Método para establecer las imagenes según el estado del Botón
-(void)setImageForAllButtons
{
    // Botones SWICHT SI/NO
    [self.buscarSensacionesButton setImage:[UIImage imageNamed:@"switch_SI_132x72.png"] forState:UIControlStateSelected];
    [self.buscarSensacionesButton setImage:[UIImage imageNamed:@"switch_NO_132x72.png"] forState:UIControlStateNormal];
    
    [self.buscarSubGenButton setImage:[UIImage imageNamed:@"switch_SI_132x72.png"] forState:UIControlStateSelected];
    [self.buscarSubGenButton setImage:[UIImage imageNamed:@"switch_NO_132x72.png"] forState:UIControlStateNormal];
    
}
// Método que convierte un array en un objeto NSData
- (NSData *) getParamsArray
{
    NSMutableString *bodyStr = [NSMutableString string];
    for (NSString *subgenre in sub_genre_list) {
        [bodyStr appendFormat:@"function=buscaPorSubgenero&subgenres[]=%@&",[subgenre stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    
    NSData *body = [bodyStr dataUsingEncoding:NSUTF8StringEncoding];
    return body;
}

// Método para obtener los resultados
- (void) searchBySubGenere
{
    // Se obtiene el resultado de la búsqueda
    resultMovies = [subGenreSearch searchBySubGenre:[self getParamsArray]];
}

- (void) searchBySensations
{
    // Se obtiene el resultado de la búsqueda
    resultMovies = [sensationSearch searchBySensations:sensationsValues];
}

- (void) searchByMovieParameter
{
    // Se obtiene el texto
    NSString * busqueda = self.textFieldSearch.text;
    // Se establece el parámetro
    [movieParameterSearch setObject:busqueda forKey:@"busqueda"];
    // Resultado de la búsqueda
    resultMovies = [parameterSearch searchByParameters:movieParameterSearch];
    // Necesario hacer esto en el hilo principal ya que son cambios en la interfaz gráfica
    dispatch_async(dispatch_get_main_queue(), ^{
        
        // TODO Necesario conocer que subvista está cargada para activar el botón en cuestión
        if ([onScreenViewController.title isEqualToString:@"BusquedaSubgenero"]) {
            [self.buscarSubGenButton setSelected:true];
            // Activa todos los botones de la parte de subgeneros
            [busquedaSubGenereVC enabledAllButtons:true];
        }else{
            [self.buscarSensacionesButton setSelected:true];
            [busquedaSensacionesVC enableAllSliders:true];
        }
        
        // Desactiva todo lo relativo a la búsqueda por la caja de texto
        pushInTextSearchField = false;
        self.textFieldSearch.text = @"";
        
    });
    // En el caso de que el resultado de la búsqueda sea vacio se le quita el focus a la caja de texto
    if (resultMovies.count == 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // Quita el focus del textField
            [self.textFieldSearch resignFirstResponder];
        });
        
    }
    
}

// Método utilizado para ir a la pantalla de Resultados de búsqueda
-(void) goToResultViewController
{
    [self performSegueWithIdentifier:@"goToResultSearchView" sender:self];
    //[sensationsValues removeAllObjects];
    [busquedaSubGenereVC selectAllButtons:false];
    [sub_genre_list removeAllObjects];
    [busquedaSensacionesVC resetSliders];
}


- (void) resetTextField
{
    
    self.textFieldSearch.text = @"";
    pushInTextSearchField = false;
    // Quita el focus del textField
    [self.textFieldSearch resignFirstResponder];
}
# pragma mark - Popover Delegate -

- (void) setSearchSelector: (NSString *) selector imgButtonSelected:(UIImage*) imgButton;
{
    
    if([self selectorPopover]){
        [[self selectorPopover] dismissPopoverAnimated:YES];
        self.selectorPopover = nil;
    }
    [movieParameterSearch setObject:selector forKey:@"parametro"];
    [[self popoverSelectedOption] setImage:imgButton forState:UIControlStateNormal];
}

#pragma  mark - Container display methods

- (void) displayContentViewController: (UIViewController *) contentViewController
{
    [self addChildViewController:contentViewController];
    contentViewController.view.frame = CGRectMake(0, 0, _container.frame.size.width, _container.frame.size.height);
    [_container addSubview:contentViewController.view];
    [contentViewController didMoveToParentViewController:self];
    
    onScreenViewController = contentViewController;
}

- (void) hideContentViewController: (UIViewController *) contentViewController
{
    [contentViewController willMoveToParentViewController:nil];
    [contentViewController.view removeFromSuperview];
    [contentViewController removeFromParentViewController];
}

- (void) cycleFromViewController: (UIViewController*) oldViewController toViewController: (UIViewController*) newViewController
{
    
    [oldViewController willMoveToParentViewController:nil];
    [self addChildViewController:newViewController];
    
    newViewController.view.frame = CGRectMake(0, 0, _container.frame.size.width, self.view.frame.size.height);
    
    [self transitionFromViewController: oldViewController toViewController: newViewController duration: 0.25 options:0
                            animations:^{
                                
                            }
                            completion:^(BOOL finished) {
                                [oldViewController removeFromParentViewController];
                                [newViewController didMoveToParentViewController:self];
                            }];
    onScreenViewController = newViewController;
    
}

- (void) specialTransitionFromViewController: (UIViewController*) oldViewController toViewController: (UIViewController*) newViewController
{
    
    [oldViewController willMoveToParentViewController:nil];
    [self addChildViewController:newViewController];
    
    newViewController.view.frame = _container.frame;
    newViewController.view.alpha = 0;
    
    [self transitionFromViewController: oldViewController toViewController: newViewController duration: 1.0 options:0
                            animations:^{
                                
                                newViewController.view.alpha = 1.0;
                                oldViewController.view.alpha = 0.5;
                                
                                CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
                                
                                scaleAnimation.fromValue = [NSNumber numberWithFloat:0];
                                scaleAnimation.toValue = [NSNumber numberWithFloat:1.0];
                                scaleAnimation.duration = 0.7;
                                
                                [newViewController.view.layer addAnimation:scaleAnimation forKey:@"scale"];
                                
                                
                            }
                            completion:^(BOOL finished) {
                                [oldViewController removeFromParentViewController];
                                [newViewController didMoveToParentViewController:self];
                            }];
    onScreenViewController = newViewController;
    
}


#pragma mark - BusquedaSubGeneroDelegate -
- (void) getSelectedSubGenre: (NSMutableArray *) subgenres
{
    sub_genre_list = subgenres;
}

#pragma mark - BusquedaSensacionesDelegate -
- (void) getSensationsValues:(NSMutableDictionary *)categoriesValues
{
    sensationsValues = categoriesValues;
}

#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    // Booleano que servirá para marcar si se tiene que buscar por la caja de texto
    pushInTextSearchField = true;
    
    // Se establecen a NO los botones switch de búsqueda por subgénero o sensaciones
    [self.buscarSubGenButton setSelected:false];
    [self.buscarSensacionesButton setSelected:false];
    
    // Según sea la pantalla se desactivan unos controles u otros
    if ([onScreenViewController.title isEqualToString:@"BusquedaSubgenero"]) {
        [busquedaSubGenereVC enabledAllButtons:FALSE];
        [busquedaSubGenereVC selectAllButtons:FALSE];
    }else{
        [busquedaSensacionesVC enableAllSliders:FALSE];
        [busquedaSensacionesVC resetSliders];
    }
    
    return true;
}

#pragma mark - Segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"goToResultSearchView"])
    {
        ResultadosBusquedaViewController * resultadoBusquedaVC = [segue destinationViewController];
        resultadoBusquedaVC.resultSearchList = resultMovies;
        
    }
}

@end
