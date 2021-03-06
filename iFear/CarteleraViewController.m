//
//  CarteleraViewController.m
//  iFear
//
//  Created by Dacio Leal Rodriguez on 13/01/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import "CarteleraViewController.h"
#import "PageContentViewController.h"
#import "DetalleViewController.h"
#import "MoviesSearch.h"
#import "Pelicula.h"

@interface CarteleraViewController ()
{
    
    int _numberOfPages;  // Número de páginas
    
    int _moviesPerPage;  // Número de películas por página
    
    NSMutableArray *pages;  // Array que almacena los pageData de todas las páginas
    
    NSMutableArray *pageData; // Almacena los datos de una página, las objetos Pelicula de esa página
    
    Pelicula *movieForSegue;
    
    MoviesSearch *moviesSearch;
    
    MoviesSearch *estrenosSearch;
    
    CGPoint lastLocationForEstrenosView;
    
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
    
    _moviesList = [[NSArray alloc] init];
    _estrenosMoviesList = [[NSArray alloc] init];
    moviesSearch = [[MoviesSearch alloc] init];
    estrenosSearch = [[MoviesSearch alloc] init];

    _loadingView.layer.cornerRadius = 10.0;
    
    
    // Creamos e inicializamos el pageViewController para las páginas de las películas, establecemos sus delegados y datasource y lo añadimos a como
    // childviewcontroller
    self.carteleraPageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.carteleraPageViewController.delegate = self;
    self.carteleraPageViewController.dataSource = self;
    
    [self addChildViewController: self.carteleraPageViewController];
    
    
    // Establecemos la vista de carteleraPageViewController que va a manejar las páginas de las película
    self.carteleraPageViewController.view.bounds = _contentView.bounds;
    self.carteleraPageViewController.view.center = CGPointMake((_contentView.center.x - _contentView.frame.origin.x), (_contentView.center.y - _contentView.frame.origin.y) );
    
    // Añadimos la vista del pageViewController como subvista de la vista ContentView definida en el storyboard
    [self.contentView addSubview:self.carteleraPageViewController.view];
    
    
    // Ocultamos la vista de estrenos, cuando se termine la carga de las películas de estrenos la haremos visible
    _estrenosContentView.hidden = YES;
    
    
    // Añadimos este ViewController (self) como observador para recibir las notificaciones de que se han terminado de descargar los datos
    // y de que se pulsa sobre la portada de una película para ir a la pantalla de detalle.
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(configurePageContentViewController) name:@"dataFinished" object:moviesSearch];
    [defaultCenter addObserver:self selector:@selector(configureEstrenosViewController) name:@"dataFinished" object:estrenosSearch];
    [defaultCenter addObserver:self selector:@selector(goToMovieDetail:) name:@"goToMovieDetail" object:nil];
    
    
    // Llamamos al método para la petición de los datos de las películas.
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self retrieveData];
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self retrieveEstrenosData];
    });
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





#pragma mark - Personalized methods

- (void) retrieveData {
    
    _loadingLabel.text = @"Cargando";
    
    NSDictionary *parameters = [[NSDictionary alloc] initWithObjectsAndKeys:@"getPeliculasCartelera", @"function",nil];
    _moviesList = [moviesSearch searchWithParameters:parameters];
}

- (void) retrieveEstrenosData {
    
    NSDictionary *parameters = [[NSDictionary alloc] initWithObjectsAndKeys:@"getPeliculasEstreno", @"function",nil];
    _estrenosMoviesList = [estrenosSearch searchWithParameters:parameters];
    
}




- (void) goToMovieDetail: (NSNotification *) notification
{
    movieForSegue = (Pelicula *) [[notification userInfo] objectForKey:@"movie"];
    [self performSegueWithIdentifier:@"goToMovieDetail" sender:self];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqual: @"goToMovieDetail"])
    {
        if ([segue.destinationViewController respondsToSelector:@selector(setMovie:)]) {
            [segue.destinationViewController performSelector:@selector(setMovie:) withObject:movieForSegue];
        }
    }
}

- (void) showEstrenosView
{
    
    if ([self estrenosViewIsVisible] == NO) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _estrenosContentView.center = CGPointMake(_estrenosContentView.center.x, _estrenosContentView.center.y - (_estrenosContentView.frame.size.height - 63));
        } completion:nil];
       
        
    } else if ([self estrenosViewIsVisible] == YES) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _estrenosContentView.center = CGPointMake(_estrenosContentView.center.x, _estrenosContentView.center.y + (_estrenosContentView.frame.size.height - 63));
        } completion:nil];
       
    }
}

- (BOOL) estrenosViewIsVisible
{

    CGPoint centerForEstrenosViewVisible = CGPointMake(518, 437);
    if (_estrenosContentView.center.y == centerForEstrenosViewVisible.y ) {
        return YES;
    }
    return NO;
}


#pragma mark - Configure PageContentViewController

- (void) configurePageContentViewController
{
    
    [_activityIndicator stopAnimating];
    _loadingView.hidden = YES;
    
    if (_moviesList.count) {
        
        // Se establece el número de películas por página y se calcula el número de páginas
        
        _moviesPerPage = 3;
        
        _numberOfPages = ( _moviesList.count % _moviesPerPage == 0 ) ? (_moviesList.count / _moviesPerPage) : ( _moviesList.count / _moviesPerPage + 1);
        
        self.pageControl.numberOfPages = _numberOfPages;
        
        [self setMoviesForAllPages];
        
        
        PageContentViewController *pageContentViewController = [self viewControllerAtIndex:0];
        
        if ( pageContentViewController ) {
            NSArray *viewControllers = @[pageContentViewController];
            
            [self.carteleraPageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
            
        } else {
            
            [self retrieveData];
            
        }
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
        if (( _moviesList.count % _moviesPerPage != 0 ) && (i == _numberOfPages - 1)) {
            
            moviesPerPageForLoop = _moviesList.count % _moviesPerPage;     //Si es la última página el número de películas en la página es el resto de la división
        }
        
        for (int j = 0; j <  moviesPerPageForLoop; j++) {
            
            Pelicula *movie = [ _moviesList objectAtIndex: i*_moviesPerPage+j];
            
            [pageData addObject:movie];
            
        }
        
        [pages addObject:pageData];
        
        pageData = [[NSMutableArray alloc] init];
    }
    
}

#pragma mark - Configure EstrenosViewController

- (void) configureEstrenosViewController
{
    
    _estrenosViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"estrenosViewController"];
    _estrenosViewController.moviesList = _estrenosMoviesList;
    [self addChildViewController:_estrenosViewController];
    
    _estrenosViewController.view.bounds = _containerView.bounds;
    [_containerView addSubview:_estrenosViewController.view];
    
    CGPoint center = [_containerView convertPoint:_containerView.center fromView:_containerView.superview];
    _estrenosViewController.view.center = center;
    
    _estrenosContentView.center = CGPointMake(_estrenosContentView.center.x, _estrenosContentView.center.y + 63);
    _estrenosContentView.hidden = NO;
    
    [UIView animateWithDuration:0.3 animations:^{
        _estrenosContentView.center = CGPointMake(_estrenosContentView.center.x, _estrenosContentView.center.y - 63);
    }];
    
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

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    
    PageContentViewController * currentPageContentViewController = [pageViewController.viewControllers objectAtIndex:0];
    
    if (completed) {
        
        self.pageControl.currentPage = currentPageContentViewController.index;    // Se actualiza el pageControl para marcar la página actual
    }
    
}

#pragma mark - GestureRecognizers Action Methods

- (IBAction)tapEstrenosContentView:(UITapGestureRecognizer *)sender {
    
    [self showEstrenosView];
}

- (IBAction)panEstrenosContentView:(UIPanGestureRecognizer *)sender {
    
    CGPoint translation = [sender translationInView:_estrenosContentView];
    //CGPoint location = [sender locationInView:self.view];
    
    if (sender.state == UIGestureRecognizerStateChanged && (_estrenosContentView.center.y >= 437) && (_estrenosContentView.center.y <= 1036)) {
        
        _estrenosContentView.center = CGPointMake(lastLocationForEstrenosView.x, lastLocationForEstrenosView.y + translation.y);
    }
    
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        
        if ( translation.y > 0 ) {
            
            if (_estrenosContentView.center.y < 600) {
                
                [UIView animateWithDuration:0.3 animations:^{
                    _estrenosContentView.center = CGPointMake(lastLocationForEstrenosView.x, 437);
                }];
                
            } else {
                
                [UIView animateWithDuration:0.3 animations:^{
                    _estrenosContentView.center = CGPointMake(lastLocationForEstrenosView.x, 1036);
                }];
                
            }
            
            
        } else if ( translation.y < 0 ) {
            
            if (_estrenosContentView.center.y > 800) {
                
                [UIView animateWithDuration:0.3 animations:^{
                    _estrenosContentView.center = CGPointMake(lastLocationForEstrenosView.x, 1036);
                }];
                
            } else {
                
                [UIView animateWithDuration:0.3 animations:^{
                    _estrenosContentView.center = CGPointMake(lastLocationForEstrenosView.x, 437);
                }];
            }
            
        }
        
    }
    

}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    lastLocationForEstrenosView = _estrenosContentView.center;
    
    
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    NSEnumerator *enumerator = [touches objectEnumerator];
    id value;
    
    while (value = [enumerator nextObject]) {
        NSLog(@"X:%f Y:%f", [value locationInView:self.view].x, [value locationInView:self.view].y);
    }
}

@end



















