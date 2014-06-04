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
#import "ResultadosBusquedaViewController.h"
#import "Pelicula.h"

@interface BusquedaViewController ()
{
    // Array para los resultados de búsqueda tanto por subgenero como por sensaciones
    NSArray * resultMovies;
    
    // Array en donde estarán que subgeneros se han seleccionado
    NSMutableArray *sub_genre_list;
    
    // Diccionario donde se almacenarán los valores elegidos para la búsqueda por sensaciones
    NSMutableDictionary *sensationsValues;
    
    // Clase que permite la búsqueda por subgenero
    SubGenreSearch * subGenreSearch;
    
    // Clase que permite la búsqueda por sensaciones
    SensationsSearch * sensationSearch;
    
    // ViewController que está mostrándose en estos momentos
    UIViewController * onScreenViewController;
    
    // Viewcontrollers de tipo de búsqueda
    BusquedaSubGeneroViewController * busquedaSubGenereVC;
    BusquedaSensacionesViewController * busquedaSensacionesVC;
    
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
    
    // Se obtiene el container de la búsqueda por subgenero
    busquedaSubGenereVC = [self.storyboard instantiateViewControllerWithIdentifier:@"busquedaSubGeneroViewController"];
    busquedaSubGenereVC.delegate = self;
    
    // Se obtiene el container de la búsqueda por sensaciones
    busquedaSensacionesVC = [self.storyboard instantiateViewControllerWithIdentifier:@"busquedaSensacionesViewController"];
    busquedaSensacionesVC.delegate = self;
    
    
    // Se inicializan las clases encargadas de la conexión y búsqueda con el servidor
    subGenreSearch = [[SubGenreSearch alloc] init];
    sensationSearch = [[SensationsSearch alloc] init];
    
    sub_genre_list = [[NSMutableArray alloc] init];
    sensationsValues = [[NSMutableDictionary alloc] init];
    
    // Añadimos este ViewController (self) como observador para recibir las notificaciones de que se han terminado de descargar los datos
    // y de que se pulsa sobre la portada de una película para ir a la pantalla de detalle.
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    //[defaultCenter addObserver:self selector:@selector(goToResultViewController) name:@"dataFinished" object:subGenreSearch];
    //[defaultCenter addObserver:self selector:@selector(goToResultViewController) name:@"dataFinished" object:sensationSearch];
        
    // Se establecen las imagenes a los estados del botón
    [self setImageForAllButtons];
    
    // Se establece seleccionado la opción de búsqueda por subgenero
    self.buscarSubGenButton.selected = YES;
    [self displayContentViewController:busquedaSubGenereVC];
        
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
    if ([self.buscarSubGenButton isSelected]) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self searchBySubGenere];
        });
        
    }else{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self searchBySensations];
        });
    }
}

// Cambia el estado de los botones de elección del tipo de búsqueda SI/NO
- (IBAction)setStateSwitchs:(id)sender
{
    if ([sender tag] == 0) {
        /*
         * Esto se hace para saber si está en la misma pantalla y ha pulsado sobre el mismo botón.
         * Es decir, Imaginemos que está seleccionado buscar por subgenero y el botón está en SI, en el
         * caso de que vuelva a pulsar el mismo botón que no ocurra nada
         */
        if (! [self.buscarSubGenButton isSelected]) {
            self.buscarSubGenButton.selected = !self.buscarSubGenButton.selected;
            self.buscarSensacionesButton.selected = !self.buscarSubGenButton.selected;
            // Se cambia el tipo de búsqueda en el container.
            [self cycleFromViewController:onScreenViewController toViewController:busquedaSubGenereVC];
                    }
        
    }else{
        if (! [self.buscarSensacionesButton isSelected]) {
            self.buscarSensacionesButton.selected = !self.buscarSensacionesButton.selected;
            self.buscarSubGenButton.selected = !self.buscarSensacionesButton.selected;
            // Se cambia el tipo de búsqueda en el container.
            [self cycleFromViewController:onScreenViewController toViewController:busquedaSensacionesVC];
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
    
    if (self.selectorPopover == nil) {
        // Configura el popover
        self.selectorPopover = [[UIPopoverController alloc] initWithContentViewController:self.popoverContent];
        self.selectorPopover.popoverContentSize = CGSizeMake(159., 81.);
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




#pragma mark - Métodos propios -

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
    NSLog(@"%@",bodyStr);
    return body;
}

// Método para obtener los resultados
- (void) searchBySubGenere
{
    resultMovies = [subGenreSearch searchBySubGenre:[self getParamsArray]];
}

- (void) searchBySensations
{
    resultMovies = [sensationSearch searchBySensations:sensationsValues];
}

// Método utilizado para ir a la pantalla de Resultados de búsqueda
-(void) goToResultViewController
{
    [self performSegueWithIdentifier:@"Associate" sender:self];
}

# pragma mark - Popover Delegate -

- (void) setSearchSelector: (NSString *) selector imgButtonSelected:(UIImage*) imgButton;
{
    if([self selectorPopover]){
        [[self selectorPopover] dismissPopoverAnimated:YES];
        self.selectorPopover = nil;
    }
    
    [[self popoverSelectedOption] setImage:imgButton forState:UIControlStateNormal];
    NSLog(@"%@",selector);
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"Associate"])
    {
        ResultadosBusquedaViewController * resultadoBusquedaVC = [segue destinationViewController];
        resultadoBusquedaVC.resultMovies = resultMovies;
        
    }
}



@end
