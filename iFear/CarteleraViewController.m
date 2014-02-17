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
    
    NSMutableArray *pageData; // Almacena los datos de una página, las objetos Pelicula de esa página
    
    
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
//    [moviesList addObject:movie];
//    [moviesList addObject:movie2];
//    [moviesList addObject:movie2];
//    [moviesList addObject:movie];
//    [moviesList addObject:movie2];
//    [moviesList addObject:movie];
//    [moviesList addObject:movie];
//    [moviesList addObject:movie2];
//    [moviesList addObject:movie2];
    
    
    /////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    // Se establece el número de películas por página y se calcula el número de páginas
    
    _moviesPerPage = 3;
    
    _numberOfPages = ( moviesList.count % _moviesPerPage == 0 ) ? (moviesList.count / _moviesPerPage) : ( moviesList.count / _moviesPerPage + 1);
    
    
    
    [self setMoviesForAllPages];
    
    
    
    self.carteleraPageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    
    PageContentViewController *pageContentViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[pageContentViewController];
    
    [self.carteleraPageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    self.carteleraPageViewController.delegate = self;
    self.carteleraPageViewController.dataSource = self;
    
    [self addChildViewController: self.carteleraPageViewController];
    
    
    
    self.carteleraPageViewController.view.frame = CGRectMake(0, 0, 618, 874);
    self.carteleraPageViewController.view.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame) + 10);
   
   
    [self.view addSubview:self.carteleraPageViewController.view];
    
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
    
    return [self viewControllerAtIndex:index];
    
}

#pragma mark - UIPageViewControllerDelegate methods






#pragma mark - Personalized methods


// Método que crea el ViewController necesario para mostrar la página con sus datos. El ViewController se crea bajo demanda.

- (PageContentViewController *) viewControllerAtIndex: (NSUInteger) index
{
    if ( ( pages.count == 0 ) || (index >= _numberOfPages) ) {
        
        return nil;
    }
    
    NSArray *movies = [self getMoviesForPage:index];
    
    
    PageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"pageContentViewController"];
    [pageContentViewController setIndex:index];
    [pageContentViewController setNumberOfPages:_numberOfPages];
    [pageContentViewController setMoviesArray:movies];
    
    return pageContentViewController;
}


// Método que devuelve el índice del ViewController

- (NSUInteger) indexOfViewController: (PageContentViewController *) viewController
{
    return viewController.index;
}


// Método que devuelve un array con las películas para una página determinada

-(NSArray *) getMoviesForPage:(NSUInteger) index {
    
    NSArray *data = [pages objectAtIndex:index];
    
    return data;
    
}


// Método que establece las películas para todas las páginas

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
