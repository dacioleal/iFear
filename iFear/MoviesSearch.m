//
//  MoviesSearch.m
//  iFear
//
//  Created by Dacio Leal Rodriguez on 28/03/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import "MoviesSearch.h"
#import "Pelicula.h"

@interface MoviesSearch ()
{
    NSMutableArray *movies;
    NSDictionary *parameters;
}

@end

@implementation MoviesSearch

- (NSMutableArray *) movies
{
    if (!movies) {
        movies = [[NSMutableArray alloc] init];
    }
    return movies;
}

- (NSArray *) searchWithParameters: (NSDictionary *) param
{
    movies = [[NSMutableArray alloc] init];
    parameters = param;
    [self retrieveData];
    return movies;
    
}

- (void) displayAlertView
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error de conexión con el servidor" message:@"Pulsa para reintentar" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alertView show];
}

- (void) retrieveData {
    
    
    //NSDictionary *parameters = [[NSDictionary alloc] initWithObjectsAndKeys:@"getTodasPeliculas", @"function",nil];
    
    NSString * direccion = @"http://ifear.esy.es/EjemploConexionBD/peticion.php";
    //NSString * direccion = @"http://ifear.es/EjemploConexionBD/peticion.php";
    //NSString * direccion = @"http://haroben.byethost31.com/EjemploConexionBD/peticion.php";
    //NSString * direccion = @"http://localhost/EjemploConexionBD/peticion.php";
    [self setConnectionWithParameters:parameters toUrl:direccion];
    
}

- (NSString *)createStringWithParameters: (NSDictionary *) param
{
    
    NSArray *keys = [param allKeys];
    
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
    
    NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    NSArray * retorno = (NSArray *)[responseDictionary objectForKey:@"retorno"];
    
    
    Pelicula * pelicula;
    NSString * titulo, * titulo_original, * pais, * director,* guion,* musica,* fotografia,* reparto,* productora,* web,* sinopsis,* portada, *cartelera, *estreno, *fechaEstreno;
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
        
        NSMutableString *strUrlImagen = [[NSMutableString alloc] initWithString:@"http://ifear.esy.es/ifearphp/"];
        //NSMutableString *strUrlImagen = [[NSMutableString alloc] initWithString:@"http://haroben.byethost31.com/ifearphp/"];
        //NSMutableString *strUrlImagen = [[NSMutableString alloc] initWithString:@"http://localhost/ifearphp/"];
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
        //NSLog(@"Éxito al bajar");
        
        if (movies.count != 0) {
            
            // Una vez obtenidas todas las películas e insertadas en el array de películas movieList descargamos las imágenes
            for (Pelicula *movie in movies) {
                movie.imagen = [UIImage imageWithData:[NSData dataWithContentsOfURL:movie.urlImagen]];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
                [defaultCenter postNotificationName:@"dataFinished" object:self];
            });
            
        }
        
    } else {
        
        NSLog(@"Error %@",[error userInfo]);
       
        dispatch_async(dispatch_get_main_queue(), ^{
            
             [self displayAlertView];
        });
    }
}

#pragma mark - AlertView Delegate method

- (void) alertViewCancel:(UIAlertView *)alertView {
    
    [self retrieveData];
}




@end
