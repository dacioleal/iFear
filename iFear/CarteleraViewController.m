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
    
    NSMutableArray *imagesList; // Array con las imágenes de las películas
    
    int _numberOfPages;  // Número de páginas
    
    int _moviesPerPage;  // Número de películas por página
    
    NSMutableArray *pages;  // Array que almacena los pageData de todas las páginas
    
    NSMutableArray *pageData; // Almacena los datos de una página, las objetos Pelicula de esa página
    
    Pelicula *movieForSegue;
    
    
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
    imagesList = [[NSMutableArray alloc] init];
    
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
    
    
    // Añadimos este ViewController (self) como observador para recibir las notificaciones de que se han terminado de descargar los datos
    // y de que se pulsa sobre la portada de una película para ir a la pantalla de detalle.
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(configurePageContentViewController) name:@"dataDownloaded" object:self];
    [defaultCenter addObserver:self selector:@selector(goToMovieDetail:) name:@"goToMovieDetail" object:nil];
    
    // Llamamos al método para la petición de los datos de las películas.
    [self retrieveData];
    
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

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    
    PageContentViewController * currentPageContentViewController = [pageViewController.viewControllers objectAtIndex:0];
    
    if (completed) {
       
        self.pageControl.currentPage = currentPageContentViewController.index;    // Se actualiza el pageControl para marcar la página actual
    }
    
}


#pragma mark - Personalized methods


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
        if (( moviesList.count % _moviesPerPage != 0 ) && (i == _numberOfPages - 1)) {
            
            moviesPerPageForLoop = moviesList.count % _moviesPerPage;     //Si es la última página el número de películas en la página es el resto de la división
        }
        
        for (int j = 0; j <  moviesPerPageForLoop; j++) {
            
            Pelicula *movie = [ moviesList objectAtIndex: i*_moviesPerPage+j];
            
            [pageData addObject:movie];
            
        }
        
        [pages addObject:pageData];
        
        pageData = [[NSMutableArray alloc] init];
    }
    
}


- (void) displayAlertView
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Downloading Error" message:@"Push button to retry" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alertView show];
}


- (void) retrieveData {
    
    _loadingLabel.text = @"Cargando datos";
    
    NSDictionary *parameters = [[NSDictionary alloc] initWithObjectsAndKeys:
                                @"getTodasPeliculas", @"f",nil];
    NSString * direccion = @"http://ifear.esy.es/EjemploConexionBD/peticion.php";
    [self setConnectionWithParameters:parameters toUrl:direccion];
    
}


/*
 Método para crear el string con los parámetros pasados mediante un diccionario.
 El formato del Diccionario es valorDelParametro/NombreParametro
 */
- (NSString *)createStringWithParameters: (NSDictionary *)parameters
{
    
    NSArray *keys = [parameters allKeys];
    
    NSMutableString* mutableStr = [[NSMutableString alloc] initWithString:@""];
    
    NSString *retorno;
    
    for (int i = 0; i < keys.count; i++) {
        
        if (i != 0){
            [mutableStr appendString:@"&"];
        }
        
        NSString * key = [keys objectAtIndex:i];
        [mutableStr appendString:key];
        [mutableStr appendString:@"="];
        
        NSString * parametro = [parameters objectForKey:key];
        [mutableStr appendString:parametro];
        
    }
    
    retorno = [NSString stringWithString:mutableStr];
    
    return retorno;
}




// Método que realiza la petición para obtener el listado de peliculas

- (void) setConnectionWithParameters: (NSDictionary *)parameters toUrl: (NSString *) serverUrl
{
    
    NSURLSessionConfiguration * configuracionConexion = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    
    configuracionConexion.timeoutIntervalForRequest = 10.0;
    configuracionConexion.timeoutIntervalForResource = 10.0;
    
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: configuracionConexion delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL * url = [NSURL URLWithString:serverUrl];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString * strParametros = [self createStringWithParameters:parameters];
    
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[strParametros dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask * dataTask = [defaultSession dataTaskWithRequest:urlRequest];
    
    [dataTask resume];
    
}




#pragma mark - NSURLSessionDataDelegate


// Al recibir los datos
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    
    NSDictionary *respuestaDictionario = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
   
    NSArray * retorno = (NSArray *)[respuestaDictionario objectForKey:@"retorno"];
    
    
    Pelicula * pelicula;
    NSString * titulo, * titulo_original, * pais, * director,* guion,* musica,* fotografia,* reparto,* productora,* web,* sinopsis,* portada;
    int idPelicula,anio,duracion;
    
    for (NSDictionary * fila in retorno) {
        
        titulo = [fila objectForKey:@"titulo"];
        titulo_original = [fila objectForKey:@"titulo_original"];
        pais = [fila objectForKey:@"pais"];
        director = [fila objectForKey:@"director"];
        guion = [fila objectForKey:@"guion"];
        musica = [fila objectForKey:@"musica"];
        fotografia = [fila objectForKey:@"fotografia"];
        reparto = [fila objectForKey:@"reparto"];
        productora = [fila objectForKey:@"productora"];
        web = [fila objectForKey:@"web"];
        sinopsis = [fila objectForKey:@"sinopsis"];
        portada = [fila objectForKey:@"portada"];
        anio = [[fila objectForKey:@"anio"] intValue];
        duracion = [[fila objectForKey:@"duracion"] intValue];
        idPelicula = [[fila objectForKey:@"id"] intValue];
        
       
        pelicula = [[Pelicula alloc] initConParametros:idPelicula
                                      tituloDePelicula:titulo
                              tituloOriginalDePelicula:titulo_original
                                      anioDeLaPelicula:anio
                                    duracionDePelicula:duracion
                                        paisDePelicula:pais
                                    directorDePelicula:director
                                       guionDePelicula:guion
                                      musicaDePelicula:musica
                                fotografiaDeLaPelicula:fotografia
                                   repartoDeLaPelicula:reparto
                                productoraDeLaPelicula:productora
                                       webDeLaPelicula:web
                                  sinopsisDeLaPelicula:sinopsis
                                   portadaDeLaPelicula:portada];
        
        NSMutableString *strUrlImagen = [[NSMutableString alloc] initWithString:@"http://ifear.esy.es/ifearphp/"];
        [strUrlImagen appendString:portada];
        pelicula.urlImagen = [NSURL URLWithString:strUrlImagen];
        
        [moviesList addObject:pelicula];
        
    }
    
}




// Al finalizar

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error
{
    if(error == nil)
    {
        //NSLog(@"Éxito al bajar");
        
        if (moviesList.count != 0) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"dataDownloaded" object:self];
            
            [self retrieveImages];   // Una vez obtenidas todas las películas e insertadas en el array de películas movieList descargamos las imágenes
            
        } else {
            
            [self retrieveData];
            
        }
        
    } else {
        
        NSLog(@"Error %@",[error userInfo]);
        [self displayAlertView];
    }
}


- (void) retrieveImages
{
    _loadingLabel.text = @"Cargando imágenes";
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        for (Pelicula *movie in moviesList) {
            movie.imagen = [UIImage imageWithData:[NSData dataWithContentsOfURL:movie.urlImagen]];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"imagesSetFinished" object:self];
        [_activityIndicator stopAnimating];
        _loadingView.hidden = YES;
        
    });
    
}



- (void) configurePageContentViewController
{
    
    if (moviesList.count) {
        
        // Se establece el número de películas por página y se calcula el número de páginas
        
        _moviesPerPage = 3;
        
        _numberOfPages = ( moviesList.count % _moviesPerPage == 0 ) ? (moviesList.count / _moviesPerPage) : ( moviesList.count / _moviesPerPage + 1);
        
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





#pragma mark - AlertView Delegate method

- (void) alertViewCancel:(UIAlertView *)alertView {
    
    [self retrieveData];
}



@end
