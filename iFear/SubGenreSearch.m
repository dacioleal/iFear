//
//  SubgenreSearch.m
//  iFear
//
//  Created by José Alberto Martín Falcón on 17/04/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import "SubgenreSearch.h"
#import "Pelicula.h"

@interface SubGenreSearch ()
{
    NSMutableArray *movies;
    NSData * parameters;
}
@end

@implementation SubGenreSearch


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
    [self retrieveData];
    return movies;
}


- (void) retrieveData {
    NSString  * url = @"http://localhost/EjemploConexionBD/peticion.php?XDEBUG_SESSION_START=netbeans-xdebug";
    [self setConnectionWithParameters:parameters toUrl:url];
    
}

- (void) displayAlertView
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Downloading Error" message:@"Push button to retry" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alertView show];
}

// Método para establecer la conexión con el servidor
- (void) setConnectionWithParameters: (NSData *) params toUrl: (NSString *) serverUrl
{
    NSURLSessionConfiguration * configuracionConexion = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSData *body = params;
    NSLog(@"%@",params);
    
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
    
    NSDictionary *respuestaDictionario = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    NSLog(@"%@",respuestaDictionario);
    NSArray * retorno = (NSArray *)[respuestaDictionario objectForKey:@"retorno"];
 
    Pelicula * pelicula;
    NSString * titulo, * titulo_original, * pais, * director,* guion,* musica,* fotografia,* reparto,* productora,* web,* sinopsis,* portada;
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
        
        // Url de la imagen
        NSMutableString *strUrlImagen = [[NSMutableString alloc] initWithString:@"http://ifear.esy.es/ifearphp/"];
        [strUrlImagen appendString:portada];
        pelicula.urlImagen = [NSURL URLWithString:strUrlImagen];
        [movies addObject:pelicula];
        
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
            
            [self retrieveData];
            
        }
        
    } else {
        
        NSLog(@"Error %@",[error userInfo]);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self displayAlertView];
        });
    }
}


@end
