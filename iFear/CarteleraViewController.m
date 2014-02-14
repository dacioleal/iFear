//
//  CarteleraViewController.m
//  iFear
//
//  Created by Dacio Leal Rodriguez on 13/01/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import "CarteleraViewController.h"
#import "PageContentViewController.h"
#import "Pelicula.h"

@interface CarteleraViewController ()
{
    NSMutableArray *moviesList; // Array con la lista de películas
    
    int _numberOfPages;  // Número de páginas
    
    int _moviesPerPage;  // Número de películas por página
    
    NSMutableArray *pages;  // Array que almacena los pageData de todas las páginas
    
    NSMutableArray *pageData; // Almacena los datos una página, las objetos Pelicula de esa página
    
    NSArray *viewControllersArray;
}

@end

@implementation CarteleraViewController

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
    
    
    
    
    self.carteleraPageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"carteleraPageViewController"];
    
    [self addChildViewController: self.carteleraPageViewController];
    
    
    
    
    
    
    moviesList = [[NSMutableArray alloc] init];
    
    
    //////////////////////////////////////////////////////////////////////////////////////////
    
    // Aquí debe ir la llamada a la base de datos para traer las películas
    // Creamos dos objetos película ficticios y lo añadimos al array 'moviesList'
    
    ///////////////////////////////////////////////////////////////////////////////////////////
    
    Pelicula *movie = [[Pelicula alloc] initConParametros:1
                                        tituloDePelicula:@"Carrie"
                                tituloOriginalDePelicula:@"Carrie"
                                        anioDeLaPelicula:2013
                                      duracionDePelicula:90
                                          paisDePelicula:@"USA"
                                      directorDePelicula:@"Dacio"
                                         guionDePelicula:@"Dac"
                                        musicaDePelicula:@"Leal"
                                  fotografiaDeLaPelicula:@"RRR"
                                     repartoDeLaPelicula:@"TTT"
                                  productoraDeLaPelicula:@"Warner"
                                         webDeLaPelicula:@"www"
                                    sinopsisDeLaPelicula:@"Una chica zombie"
                                     portadaDeLaPelicula:@"www.carrie.com"];
    
    Pelicula *movie2 = [[Pelicula alloc] initConParametros:2
                                         tituloDePelicula:@"Resident Evil"
                                 tituloOriginalDePelicula:@"Resident Evil"
                                         anioDeLaPelicula:2010
                                       duracionDePelicula:120
                                           paisDePelicula:@"USA"
                                       directorDePelicula:@"Steven"
                                          guionDePelicula:@"Ralph"
                                         musicaDePelicula:@"Scott"
                                   fotografiaDeLaPelicula:@"DDD"
                                      repartoDeLaPelicula:@"HHH"
                                   productoraDeLaPelicula:@"TRI Pictures"
                                          webDeLaPelicula:@"www"
                                     sinopsisDeLaPelicula:@"Zombies a matar"
                                      portadaDeLaPelicula:@"www.residentevil.com"];
    
    [moviesList addObject:movie];
    [moviesList addObject:movie2];
    [moviesList addObject:movie2];
    [moviesList addObject:movie];
    [moviesList addObject:movie];
    [moviesList addObject:movie2];
    [moviesList addObject:movie2];
    [moviesList addObject:movie];
    [moviesList addObject:movie2];
    [moviesList addObject:movie];
    [moviesList addObject:movie];
    
    
    /////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    // Se establece el número de películas por página y se calcula el número de páginas
    
    _moviesPerPage = 3;
    
    _numberOfPages = ( moviesList.count % _moviesPerPage == 0 ) ? (moviesList.count / _moviesPerPage) : ( moviesList.count / _moviesPerPage + 1);
    
    
    
    [self setMoviesForAllPages];

    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIPageViewControllerDataSource methods

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    PageContentViewController * pageContenViewController = (PageContentViewController *) viewController;
    
    NSUInteger index = [viewControllersArray indexOfObject:pageContenViewController];
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    index--;
    
    return [self viewControllerAtIndex:index];
    
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    PageContentViewController * pageContenViewController = (PageContentViewController *) viewController;
    
    NSUInteger index = [viewControllersArray indexOfObject:pageContenViewController];
    
    if ((index == viewControllersArray.count - 1) || (index == NSNotFound)) {
        return nil;
    }
    
    index++;
    
    return [self viewControllerAtIndex:index];
    
}

#pragma mark - UIPageViewControllerDelegate methods






#pragma mark - Personalized methods

- (PageContentViewController *) viewControllerAtIndex: (NSUInteger) index
{
    PageContentViewController *pageContentViewController = (PageContentViewController *)[viewControllersArray objectAtIndex:index];
    
    return pageContentViewController;
}


// Devuelve un array con las peliculas para una pagina determinada

-(NSArray *) getMoviesForPage:(NSUInteger) index {
    
    NSArray *data = [pages objectAtIndex:index];
    
    return data;
    
}

// Se crean las paginas con sus peliculas

-(void) setMoviesForAllPages
{
    int moviesPerPageForLoop = _moviesPerPage;
    
    pages = [[NSMutableArray alloc] init];
    pageData = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < _numberOfPages; i++)
    {
        if (( moviesList.count % _moviesPerPage != 0 ) && (i == _numberOfPages - 1)) {
            
            moviesPerPageForLoop = moviesList.count % _moviesPerPage;     //Si es la ultima pagina el numero de peliculas en la pagina es el resto
        }
        
        for (int j = 0; j < moviesPerPageForLoop; j++) {
            
            Pelicula *movie = [ moviesList objectAtIndex:i+j ];
            
            [pageData addObject:movie];
            
        }
        
        [pages addObject:pageData];
        
        pageData = [[NSMutableArray alloc] init];
    }
    
}


@end
