//
//  SubgenreSearch.m
//  iFear
//
//  Created by José Alberto Martín Falcón on 17/04/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import "SubgenreSearch.h"
#import "Pelicula.h"
#import "IfearAlertView.h"

@interface SubGenreSearch ()
{
    NSMutableArray *movies;
    NSData * parameters;
    IfearAlertView * alert;
    
}
@end

@implementation SubGenreSearch

@synthesize associateVC;


-(id)init{
    self = [super init];
    
    if (self) {
        alert = [IfearAlertView new];
    }
    return self;
}

- (NSMutableArray *) movies
{
    if (!movies) {
        movies = [[NSMutableArray alloc] init];
    }
    return movies;
}

- (NSArray *)searchBySubGenre:(NSData *)params
{
    movies = [[NSMutableArray alloc] init];
    parameters = params;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.associateVC showLoadingView:YES];
        
    });
    [self retrieveData];
    return movies;
}


- (void) retrieveData {
    //NSString  * url = @"http://localhost/EjemploConexionBD/peticion.php?XDEBUG_SESSION_START=netbeans-xdebug";
    NSString * url = @"http://ifear.esy.es/EjemploConexionBD/peticion.php";
    [self setConnectionWithParameters:parameters toUrl:url];
    
}

- (void) displayAlertView: (NSString *) title andMessage: (NSString *) message
{
    //UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Downloading Error" message:@"Push button to retry" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

// Método para establecer la conexión con el servidor
- (void) setConnectionWithParameters: (NSData *) params toUrl: (NSString *) serverUrl
{
    NSURLSessionConfiguration * configuracionConexion = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSData *body = params;
    
    configuracionConexion.timeoutIntervalForRequest = 10.0;
    configuracionConexion.timeoutIntervalForResource = 10.0;
    
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: configuracionConexion delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL * url = [NSURL URLWithString:serverUrl];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:body];
    
    NSURLSessionDataTask * dataTask = [defaultSession dataTaskWithRequest:urlRequest];
    
    [dataTask resume];
    
}

// Donde primero entra al realizar la petición
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler
{
    // Para que la tarea continue normalmente.
    completionHandler(NSURLSessionResponseAllow);
}

// Al recibir los datos
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    // Se parsea el JSON
    NSDictionary *respuestaDictionario = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    // Se recupera si ha tenido
    BOOL exito = [[respuestaDictionario objectForKey:@"exito"] boolValue];
    
    NSLog(@"%@",respuestaDictionario);
    
    if (exito) {
        // Se recupera la parte de JSON de la película
        NSArray * retorno = (NSArray *)[respuestaDictionario objectForKey:@"retorno"];
        Pelicula * pelicula;
        NSString * titulo, * titulo_original, * pais, * director,* guion,* musica,* fotografia,* reparto,* productora,* web,* sinopsis,* portada, *cartelera, *estreno, *fechaEstreno;
        int idPelicula,anio,duracion;
        
        // Se recorre el array retorno que es donde estarán las peliculas
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
            cartelera = [fila objectForKey:@"cartelera"];
            estreno = [fila objectForKey:@"estrenos"];
            fechaEstreno = [fila objectForKey:@"fecha_estreno"];
            
            
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
                                       portadaDeLaPelicula:portada
                                     carteleraDeLaPelicula:cartelera
                                       estrenoDeLaPelicula:estreno
                                  fechaEstrenoDeLaPelicula:fechaEstreno];
            
            // Url de la imagen
            NSMutableString *strUrlImagen = [[NSMutableString alloc] initWithString:@"http://ifear.esy.es/ifearphp/"];
            [strUrlImagen appendString:portada];
            pelicula.urlImagen = [NSURL URLWithString:strUrlImagen];
            [movies addObject:pelicula];
        }
        
    }
    
}


// Al finalizar

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error
{
    if(error == nil)
    {
        if (movies.count != 0) {
            
            // Una vez obtenidas todas las películas e insertadas en el array de películas movies descargamos las imágenes
            for (Pelicula *movie in movies) {
                movie.imagen = [UIImage imageWithData:[NSData dataWithContentsOfURL:movie.urlImagen]];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
                [defaultCenter postNotificationName:@"dataFinished" object:self];
            });
            
            
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [alert showAlert:associateVC withMessage:@"La búsqueda no ha obtenido resultados, por favor inténtelo con otros parámetros"];
                
            });
            //            [self retrieveData];
            
        }
        
    } else {
        
        NSLog(@"Error %@",[error userInfo]);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [alert showAlert:associateVC withMessage:@"Push button to retry"];
        });
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.associateVC showLoadingView:NO];
        
    });
}


@end
