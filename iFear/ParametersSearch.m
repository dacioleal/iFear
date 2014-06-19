//
//  ParametersSearch.m
//  iFear
//
//  Created by José Alberto Martín Falcón on 10/06/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import "ParametersSearch.h"
#import "Pelicula.h"

@implementation ParametersSearch
{
    NSMutableArray *movies;
    NSMutableDictionary *parameters;
}


- (NSMutableArray *) movies
{
    if (!movies) {
        movies = [[NSMutableArray alloc] init];
    }
    return movies;
}

- (NSArray *) searchByParameters: (NSMutableDictionary *) param
{
    movies = [[NSMutableArray alloc] init];
    parameters = param;
    [parameters setObject:@"searchByMovieParameter"  forKey:@"function"];
    NSLog(@"%@",parameters);
    [self retrieveData];
    return movies;
}

- (void) displayAlertView: (NSString *) title andMessage: (NSString *) message
{
    //UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Downloading Error" message:@"Push button to retry" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

- (void) retrieveData {
    
    
    //NSDictionary *parameters = [[NSDictionary alloc] initWithObjectsAndKeys:@"getTodasPeliculas", @"f",nil];
    
    //NSString  * url = @"http://localhost/EjemploConexionBD/peticion.php?XDEBUG_SESSION_START=netbeans-xdebug";
   NSString * url = @"http://ifear.esy.es/EjemploConexionBD/peticion.php";
    [self setConnectionWithParameters:parameters toUrl:url];
    
}

- (NSString *)createStringWithParameters: (NSDictionary *) param
{
    
    NSArray *keys = [param allKeys];
    
    NSMutableString* mutableStr = [[NSMutableString alloc] initWithString:@""];
    
    NSString *retorno;
    NSString * parametro;
    
    for (int i = 0; i < keys.count; i++) {
        
        if (i != 0){
            [mutableStr appendString:@"&"];
        }
        
        NSString * key = [keys objectAtIndex:i];
        [mutableStr appendString:key];
        [mutableStr appendString:@"="];
        
        
        NSObject * object = [parameters objectForKey:key];
        
        // Para saber si el objeto es de tipo string o de tipo número
        if ([object isKindOfClass:[NSString class]]) {
            parametro  = (NSString * ) object;
        }else{
            
            NSNumber * number = [parameters objectForKey:key];
            int intValue = [number intValue];
            
            parametro = [NSString stringWithFormat:@"%i",intValue];
        }
        
        [mutableStr appendString:parametro];
        
    }
    
    retorno = [NSString stringWithString:mutableStr];
    
    NSLog(@"%@",retorno);
    return retorno;
}

// Método que realiza la petición para obtener el listado de peliculas

- (void) setConnectionWithParameters: (NSDictionary *)param toUrl: (NSString *) serverUrl
{
    
    NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    
    configuration.timeoutIntervalForRequest = 10.0;
    configuration.timeoutIntervalForResource = 10.0;
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    
    NSURL * url = [NSURL URLWithString:serverUrl];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString * strParametros = [self createStringWithParameters:param];
    
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[strParametros dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask * dataTask = [defaultSession dataTaskWithRequest:urlRequest];
    
    [dataTask resume];
    
}


#pragma mark - NSURLSessionDataDelegate


- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    
    // Se parsea el JSON
    NSDictionary *respuestaDictionario = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    // Se recupera si ha tenido
    BOOL exito = [[respuestaDictionario objectForKey:@"exito"] boolValue];
    
    if (exito) {
        // Se recupera la parte de JSON de la película
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
                [self displayAlertView:@"Resultado de la búsqueda" andMessage:@"La búsqueda no ha obtenido resultados, por favor inténtelo con otros parámetros"];
                
            });
            //            [self retrieveData];
            
        }
        
    } else {
        
        NSLog(@"Error %@",[error userInfo]);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self displayAlertView:@"Downloading Error" andMessage:@"Push button to retry"];
        });
    }
}

#pragma mark - AlertView Delegate method

- (void) alertViewCancel:(UIAlertView *)alertView {
    
    [self retrieveData];
}




@end

