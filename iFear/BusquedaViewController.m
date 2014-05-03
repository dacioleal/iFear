//
//  BusquedaViewController.m
//  iFear
//
//  Created by Dacio Leal Rodriguez on 30/01/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import "BusquedaViewController.h"
#import "SubGenreSearch.h"

@interface BusquedaViewController ()
{
    // Array para los resultados de búsqueda
    NSArray * resultMovies;
    
    // Array en donde estarán que subgeneros se han seleccionado
    NSMutableArray *sub_genre_list;
    
    NSMutableDictionary *sensationsValues;
    
    // Clase que permite la búsqueda por subgenero
    SubGenreSearch * subGenreSearch;
    
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    busquedaSubGenereVC = [self.storyboard instantiateViewControllerWithIdentifier:@"busquedaSubGeneroViewController"];
    
    busquedaSubGenereVC.delegate = self;
    
    
    busquedaSensacionesVC = [self.storyboard instantiateViewControllerWithIdentifier:@"busquedaSensacionesViewController"];
    busquedaSensacionesVC.delegate = self;
    
    subGenreSearch = [[SubGenreSearch alloc] init];
    
    sub_genre_list = [[NSMutableArray alloc] init];
    
    sensationsValues = [[NSMutableDictionary alloc] init];
    
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

- (IBAction)pushBuscarButton:(id)sender {
    if ([self.buscarSubGenButton isSelected]) {
        [self searchBySubGenere];
    }else{

    }
    
}

- (IBAction)setStateSwitchs:(id)sender
{
    if ([sender tag] == 0) {
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


- (void) getSelectedSubGenre: (NSMutableArray *) subgenres
{
    NSLog(@"Subgere");
    sub_genre_list = subgenres;
}

- (void) getSensationsValues:(NSMutableDictionary *)categoriesValues
{
    NSLog(@"Sensations");
    sensationsValues = categoriesValues;
}

- (NSData *) getParamsArray
{
    NSMutableString *bodyStr = [NSMutableString string];
    for (NSString *subgenre in sub_genre_list) {
        [bodyStr appendFormat:@"function=buscaPorSubgenero&subgenres[]=%@&",[subgenre stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    
    NSData *body = [bodyStr dataUsingEncoding:NSUTF8StringEncoding];
    return body;
}

- (void) searchBySubGenere
{
    resultMovies = [subGenreSearch searchBySubGenre:[self getParamsArray]];
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

#pragma  mark - Container display methods

- (void) displayContentViewController: (UIViewController *) contentViewController
{
    [self addChildViewController:contentViewController];
    contentViewController.view.frame = CGRectMake(0, 0, _container.frame.size.width, self.view.frame.size.height);
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



@end
