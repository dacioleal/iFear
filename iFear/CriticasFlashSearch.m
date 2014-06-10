//
//  CriticasFlashSearch.m
//  iFear
//
//  Created by Dacio Leal Rodriguez on 10/06/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import "CriticasFlashSearch.h"
#import "CriticaFlash.h"

@interface CriticasFlashSearch ()
{
    NSMutableArray *criticasFlash;
    NSDictionary *parameters;
}

@end

@implementation CriticasFlashSearch

- (NSMutableArray *) criticasFlash
{
    if (!criticasFlash) {
        criticasFlash = [[NSMutableArray alloc] init];
    }
    return criticasFlash;
}

- (NSArray *) searchWithParameters: (NSDictionary *) param
{
    criticasFlash = [[NSMutableArray alloc] init];
    parameters = param;
    [self retrieveData];
    return criticasFlash;
    
}

- (void) displayAlertView
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error de conexión con el servidor" message:@"Pulsa para reintentar" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alertView show];
}

- (void) retrieveData {
    
    NSString * direccion = @"http://ifear.esy.es/EjemploConexionBD/peticion.php";
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
    
    NSString *usuario;
    NSString *contenido;
    NSString *fecha;
    
    for (NSDictionary * fila in retorno) {
        
        usuario = (NSString *) [fila objectForKey:@"id_usuario"];
        contenido = (NSString *) [fila objectForKey:@"contenido"];
        fecha = (NSString *) [fila objectForKey:@"fecha"];
        CriticaFlash *critica = [[CriticaFlash alloc] initWithParameters:usuario andContenido:contenido andFecha:fecha];
        [criticasFlash addObject:critica];
        
    }
    
}




// Al finalizar

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error
{
    if(error == nil)
    {
        //NSLog(@"Criticas Flash: %@", criticasFlash);
        
        if (criticasFlash.count != 0) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
                [defaultCenter postNotificationName:@"CriticasFlashFinished" object:self];
            });
            
            
        } else {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
                [defaultCenter postNotificationName:@"CriticasFlashEmpty" object:self];
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
