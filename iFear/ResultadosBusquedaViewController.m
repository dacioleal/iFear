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
        
        if ( pageContentViewController ) {
            NSArray *viewControllers = @[pageContentViewController];
            
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


@end
