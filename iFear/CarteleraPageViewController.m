//
//  CarteleraPageViewController.m
//  iFear
//
//  Created by José Alberto Martín Falcón on 02/02/14.
//  Copyright (c) 2014. All rights reserved.
//

#import "CarteleraPageViewController.h"
#import "Pelicula.h"

@interface CarteleraPageViewController ()
{
    // Para almacenar las peliculas
    NSMutableArray * listaPeliculas;
    int contador;
    NSMutableArray *pagesViewControllers;
}

@end

@implementation CarteleraPageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Se esconde el indicador de carga
    self.indicadorDeCargo.hidden = TRUE;
    listaPeliculas = [[NSMutableArray alloc] init];
    contador = 0;
    
   
//    for (int i=0; i<5; i++) {
//        UIViewController *viewController = [[UIViewController alloc] init];
//        [pagesViewControllers addObject:viewController];
//    }
    
}

- (void) viewWillAppear:(BOOL)animated
{
    UIViewController *rojoViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"rojoViewController"];
    UIViewController *azulViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"azulViewController"];
    
    [pagesViewControllers addObject:rojoViewController];
    [pagesViewControllers addObject:azulViewController];
    [self setViewControllers:pagesViewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    NSLog(@"%@", self.viewControllers);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Métodos propios

// Método que realiza la petición para obtener el listado de peliculas
-(void) realizaPeticion: (NSDictionary *)parametros direccionURL: (NSString *) direccionUrl
{
    // En este caso se pone una configuración por defecto. Hay varios tipos de configuracion
    NSURLSessionConfiguration * configuracionConexion = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    // Tiempo de espera
    configuracionConexion.timeoutIntervalForRequest = 10.0;
    configuracionConexion.timeoutIntervalForResource = 10.0;
    
    // Conexión
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: configuracionConexion delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    
    // URL
    NSURL * url = [NSURL URLWithString:direccionUrl];
    
    // Petición URL
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    // Parámetros
    NSString * strParametros = [self creaStringConParametros:parametros];
    
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
    
    
    
    for (int i = 0; i < listaPeliculas.count; i ++) {
        NSMutableString *strUrlImagen = [[NSMutableString alloc] initWithString:@"http://ifear.esy.es/"];
        NSString * urlImagenPelicula = [[listaPeliculas objectAtIndex:i] portada];
        
        [strUrlImagen appendString:urlImagenPelicula];
        NSURL * url = [NSURL URLWithString:[NSString stringWithString:strUrlImagen]];
        
        NSURLSessionDownloadTask * downloadTask =[ defaultSession downloadTaskWithURL:url];
        [downloadTask resume];
        
    }
    
    
    //ESTO ES OTRA FORMA DE HACERLO, pero no se cual es mejor, es una de la cosas que tengo que preguntar a Mario o Luis.
    
//    for (int i = 0; i < listaPeliculas.count; i ++) {
//        NSMutableString *strUrlImagen = [[NSMutableString alloc] initWithString:@"http://ifear.esy.es/"];
//        NSString * urlImagenPelicula = [[listaPeliculas objectAtIndex:i] portada];
//        
//        [strUrlImagen appendString:urlImagenPelicula];
//        NSURL * url = [NSURL URLWithString:[NSString stringWithString:strUrlImagen]];
//        
//        dispatch_queue_t q = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
//        dispatch_async(q, ^{
//            /* Fetch the image from the server... */
//            NSData *data = [NSData dataWithContentsOfURL:url];
//            UIImage *img = [[UIImage alloc] initWithData:data];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                /* This is the main thread again, where we set the tableView's image to
//                 be what we just fetched. */
//                if (contador == 0) {
//                    self.imagenUno.image = img;
//                }else if (contador == 1){
//                    self.imagenDos.image = img;
//                }else if (contador == 2){
//                    self.imagenTres.image = img;
//                }else if (contador == 3){
//                    self.imagenCuatro.image = img;
//                }else if (contador == 4){
//                    self.imagenCinco.image = img;
//                }
//                contador++;
//            });
//        });
//        
////    }
}



/*
    Método para crear el string con los parámetros pasados mediante un diccionario.
    El formato del Diccionario es valorDelParametro/NombreParametro
 */
- (NSString *)creaStringConParametros: (NSDictionary *)parametros
{
    // Se obtienen todas las claves que vengan en los parametros
    NSArray *keys = [parametros allKeys];
    
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
            NSString * parametro = [parametros objectForKey:key];
            [mutableStr appendString:parametro];
        
    }
    
    // Se convierte a String
    retorno = [NSString stringWithString:mutableStr];
    NSLog(@"%@",retorno);

    return retorno;
}


#pragma mark - NSURLSessionDataDelegate

// Donde primero entra al realizar la petición
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler
{
    NSLog(@"Entra en primera instancia en didReceiveResponse");
    
    // Se activa el indicador de carga
    self.indicadorDeCargo.hidden = NO;
    [self.indicadorDeCargo startAnimating];
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
        
        [listaPeliculas addObject:pelicula];
        
    }
    
    NSLog(@"%@",listaPeliculas);
    
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
    else
        NSLog(@"Error %@",[error userInfo]);
    
    // Se para el indicador
    [self.indicadorDeCargo stopAnimating];
    self.indicadorDeCargo.hidden = TRUE;
}



#pragma mark - NSURLSessionDownloadDelegate
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    // Se obtiene la imagen
    UIImage *imagenDescargada = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
    dispatch_async(dispatch_get_main_queue(), ^{
        
        // Esto esta hecho a huevo para ver si funcionaba el poner en imagenes. Es por probar
        if (contador == 0) {
                             self.imagenUno.image = imagenDescargada;
                           }else if (contador == 1){
                               self.imagenDos.image = imagenDescargada;
                           }else if (contador == 2){
                               self.imagenTres.image = imagenDescargada;
                            }else if (contador == 3){
                                self.imagenCuatro.image = imagenDescargada;
                            }else if (contador == 4){
                                self.imagenCinco.image = imagenDescargada;
                            }
                            contador++;
        
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

#pragma mark - UIPageViewControllerDataSource methods

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    
}

#pragma mark - UIPageViewControllerDelegate methods



#pragma mark - IBAction
- (IBAction)pulsarObtenDatos:(id)sender {
    // Parametros
    NSDictionary *parametros = [[NSDictionary alloc] initWithObjectsAndKeys:
                         @"getTodasPeliculas", @"f",nil];
    NSString * direccion = @"http://ifear.esy.es/EjemploConexionBD/peticion.php";
    [self realizaPeticion:parametros direccionURL:direccion];
}
@end
