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
    
    
    // Parametros
    NSDictionary *parameters = [[NSDictionary alloc] initWithObjectsAndKeys:
                                @"getTodasPeliculas", @"f",nil];
    NSString * direccion = @"http://ifear.esy.es/EjemploConexionBD/peticion.php";
    [self setConnectionWithParameters:parameters toUrl:direccion];
    /////////////////////////////////////////////////////////////////////////////////////////////////////
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
            
            Pelicula *movie = [ moviesList objectAtIndex:i+j];
            
            [pageData addObject:movie];
            
        }
        
        [pages addObject:pageData];
        
        pageData = [[NSMutableArray alloc] init];
    }
    
}


/*
 Método para crear el string con los parámetros pasados mediante un diccionario.
 El formato del Diccionario es valorDelParametro/NombreParametro
 */
- (NSString *)createStringWithParameters: (NSDictionary *)parameters
{
    // Se obtienen todas las claves que vengan en los parametros
    NSArray *keys = [parameters allKeys];
    
    // String donde se irá concatenando los parametros
    NSMutableString* mutableStr = [[NSMutableString alloc] initWithString:@""];
    
    // Valor devuelto
    NSString *retorno;
    
    for (int i = 0; i < keys.count; i++) {
        // Esto es para filtrar que la primera vez no ponga el signo de  "&"
        if (i != 0){
            [mutableStr appendString:@"&"];
        }
        // Se obtienen los valores de cada parametro
        // Key
        NSString * key = [keys objectAtIndex:i];
        [mutableStr appendString:key];
        [mutableStr appendString:@"="];
        // Parámetro
        NSString * parametro = [parameters objectForKey:key];
        [mutableStr appendString:parametro];
        
    }
    
    // Se convierte a String
    retorno = [NSString stringWithString:mutableStr];
    
    return retorno;
}


// Método que realiza la petición para obtener el listado de peliculas
-(void) setConnectionWithParameters: (NSDictionary *)parameters toUrl: (NSString *) serverUrl
{
    // En este caso se pone una configuración por defecto. Hay varios tipos de configuracion
    NSURLSessionConfiguration * configuracionConexion = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    // Tiempo de espera
    configuracionConexion.timeoutIntervalForRequest = 10.0;
    configuracionConexion.timeoutIntervalForResource = 10.0;
    
    // Conexión
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: configuracionConexion delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    
    // URL
    NSURL * url = [NSURL URLWithString:serverUrl];
    
    // Petición URL
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    // Parámetros
    NSString * strParametros = [self createStringWithParameters:parameters];
    
    // Método de envío
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[strParametros dataUsingEncoding:NSUTF8StringEncoding]];
    
    // Controla la conexión
    NSURLSessionDataTask * dataTask = [defaultSession dataTaskWithRequest:urlRequest];
    
    // Inicia la conexión
    [dataTask resume];
    
}


// Método para obtener las fotografias
-(void) downloadFileWithProgress: (NSString *) strUrl
{
    
    NSURL * url = [NSURL URLWithString:strUrl];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate:self delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURLSessionDownloadTask * downloadTask =[ defaultSession downloadTaskWithURL:url];
    [downloadTask resume];
    

    
    for (int i = 0; i < moviesList.count; i ++) {
        NSMutableString *strUrlImagen = [[NSMutableString alloc] initWithString:@"http://ifear.esy.es/"];
        NSString * urlImagenPelicula = [[moviesList objectAtIndex:i] portada];
        
        [strUrlImagen appendString:urlImagenPelicula];
        
        NSURL * url = [NSURL URLWithString:[NSString stringWithString:strUrlImagen]];
        
        NSURLSessionDownloadTask * downloadTask =[ defaultSession downloadTaskWithURL:url];
        [downloadTask resume];
        
    }
}

#pragma mark - NSURLSessionDataDelegate

// Donde primero entra al realizar la petición
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler
{
    
    // Para que la tarea continue normalmente.
    completionHandler(NSURLSessionResponseAllow);
}



// Al recibir los datos
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    // Se obtiene la respuesta del servidor
    NSDictionary *respuestaDictionario = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    // Se trae todo lo que venga en retorno
    NSArray * retorno = (NSArray *)[respuestaDictionario objectForKey:@"retorno"];
    
    // Se va iterando sobre el array para obtener todas las peliculas
    Pelicula * pelicula;
    NSString * titulo, * titulo_original, * pais, * director,* guion,* musica,* fotografia,* reparto,* productora,* web,* sinopsis,* portada;
    int idPelicula,anio,duracion;
    for (NSDictionary * fila in retorno) {
        // Se obtienen los campos de cada película
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
        
        // Se crea el objeto pelicula
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
        
        NSLog(@"%@",pelicula.titulo);
        [moviesList addObject:pelicula];
        
    }
    
    
    // Se establece el número de películas por página y se calcula el número de páginas
    _moviesPerPage = 3;
    
    _numberOfPages = ( moviesList.count % _moviesPerPage == 0 ) ? (moviesList.count / _moviesPerPage) : ( moviesList.count / _moviesPerPage + 1);
    
    [self setMoviesForAllPages];
    
    
    [self downloadFileWithProgress:@""];
    
}




// Al finalizar
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error
{
    if(error == nil)
    {
        NSLog(@"Éxito al bajar");
       
    }
    else{
        NSLog(@"Error %@",[error userInfo]);
    }
}



#pragma mark - NSURLSessionDownloadDelegate
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    // Se obtiene la imagen
    //UIImage *imagenDescargada = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
    dispatch_async(dispatch_get_main_queue(), ^{
        
        // BLOQUE DONDE ACTUALIZAR LA UI
        
    });
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    // METODO NO IMPLEMENTADO DE MOMENTO
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes
{
    // METODO NO IMPLEMENTADO DE MOMENTO
}


@end
