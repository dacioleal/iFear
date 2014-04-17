//
//  SubgenreSearch.m
//  iFear
//
//  Created by José Alberto Martín Falcón on 17/04/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import "SubgenreSearch.h"

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
    
    NSDictionary *respuestaDictionario = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    
    NSArray * retorno = (NSArray *)[respuestaDictionario objectForKey:@"retorno"];
    
    NSLog(@"%@",respuestaDictionario);
    
    
}


// Al finalizar

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error
{
    if(error == nil)
    {
        NSLog(@"Éxito al bajar");
        
        
        
    } else {
        
    }
}


@end
