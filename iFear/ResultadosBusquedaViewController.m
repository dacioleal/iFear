//
//  ResultadosBusquedaViewController.m
//  iFear
//
//  Created by José Alberto Martín Falcón on 11/05/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import "ResultadosBusquedaViewController.h"
#import "PageContentViewController.h"
#import "Pelicula.h"

@interface ResultadosBusquedaViewController ()
{
    int _numberOfPages;  // Número de páginas
    
    int _moviesPerPage;  // Número de películas por página
    
    NSMutableArray *pages;  // Array que almacena los pageData de todas las páginas
    
    NSMutableArray *pageData; // Almacena los datos de una página, las objetos Pelicula de esa página
}
@end

@implementation ResultadosBusquedaViewController

@synthesize resultMovies;

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
    // Creamos e inicializamos el pageViewController para las páginas de las películas, establecemos sus delegados y datasource y lo añadimos a como
    // childviewcontroller
    
    for (Pelicula * p  in resultMovies) {
        NSLog(@" wee rere %@",p.titulo);
    }
    self.carteleraPageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.carteleraPageViewController.delegate = self;
    self.carteleraPageViewController.dataSource = self;
    
    [self addChildViewController: self.carteleraPageViewController];
    
    
    // Establecemos la vista de carteleraPageViewController que va a manejar las páginas de las película
    self.carteleraPageViewController.view.bounds = _contentView.bounds;
    self.carteleraPageViewController.view.center = CGPointMake((_contentView.center.x - _contentView.frame.origin.x), (_contentView.center.y - _contentView.frame.origin.y) );
    
    // Añadimos la vista del pageViewController como subvista de la vista ContentView definida en el storyboard
    [self.contentView addSubview:self.carteleraPageViewController.view];
    [self configurePageContentViewController];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void) configurePageContentViewController
{
    
    //[_activityIndicator stopAnimating];
    //_loadingView.hidden = YES;
    
    if (resultMovies.count) {
        
        // Se establece el número de películas por página y se calcula el número de páginas
        
        _moviesPerPage = 3;
        
        _numberOfPages = ( resultMovies.count % _moviesPerPage == 0 ) ? (resultMovies.count / _moviesPerPage) : ( resultMovies.count / _moviesPerPage + 1);
        
        self.pageControl.numberOfPages = _numberOfPages;
        
        [self setMoviesForAllPages];
        
        
        PageContentViewController *pageContentViewController = [self viewControllerAtIndex:0];
        
        NSLog(@"%@",pageContentViewController);
        if ( pageContentViewController ) {
            NSArray *viewControllers = @[pageContentViewController];
            
            NSLog(@"%@",viewControllers);
            [self.carteleraPageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
        }
//        } else {
//            
//            [self retrieveData];
//            
//        }
    }
}

// Método que establece las películas para todas las páginas

-(void) setMoviesForAllPages
{
    int moviesPerPageForLoop = _moviesPerPage;
    
    pages = [[NSMutableArray alloc] init];
    pageData = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < _numberOfPages; i++)
    {
        if (( resultMovies.count % _moviesPerPage != 0 ) && (i == _numberOfPages - 1)) {
            
            moviesPerPageForLoop = resultMovies.count % _moviesPerPage;     //Si es la última página el número de películas en la página es el resto de la división
        }
        
        for (int j = 0; j <  moviesPerPageForLoop; j++) {
            
            Pelicula *movie = [ resultMovies objectAtIndex: i*_moviesPerPage+j];
            
            [pageData addObject:movie];
            
        }
        
        [pages addObject:pageData];
        
        pageData = [[NSMutableArray alloc] init];
    }
    
}


// Método que crea el ViewController necesario para mostrar la página con sus datos. El ViewController se crea bajo demanda.

- (PageContentViewController *) viewControllerAtIndex: (NSUInteger) index
{
    if ( ( _numberOfPages == 0 ) || (index >= _numberOfPages) ) {
        
        return nil;
    }
    
    NSArray *movies = [self getMoviesForPage:index];
    
    PageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"pageContentViewController"];
    [pageContentViewController setIndex:index];
    
    [pageContentViewController setNumberOfPages:_numberOfPages];
    if ( movies )
        [pageContentViewController setMoviesArray:movies];
    
    return pageContentViewController;
}


// Método que devuelve un array con las películas para una página determinada

-(NSArray *) getMoviesForPage:(NSUInteger) index {
    
    NSArray *data = [pages objectAtIndex:index];
    return data;
}


#pragma mark - UIPageViewControllerDataSource methods

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    PageContentViewController * pageContenViewController = (PageContentViewController *) viewController;
    
    NSUInteger index = pageContenViewController.index;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    
    return [self viewControllerAtIndex:index];
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    PageContentViewController * pageContenViewController = (PageContentViewController *) viewController;
    
    NSUInteger index = pageContenViewController.index;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if ( index == pages.count)
    {
        return nil;
    }
    
    NSLog(@"ENTRA 1");
    return [self viewControllerAtIndex:index];
    
}



#pragma mark - UIPageViewControllerDelegate methods

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    NSLog(@"ENTRA 2");
    PageContentViewController * currentPageContentViewController = [pageViewController.viewControllers objectAtIndex:0];
    
    if (completed) {
        
        self.pageControl.currentPage = currentPageContentViewController.index;    // Se actualiza el pageControl para marcar la página actual
    }
    
}




@end
