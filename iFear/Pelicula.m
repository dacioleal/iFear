//
//  Pelicula.m
//  ConexionConServidor
//
//  Created by José Alberto Martín Falcón on 31/01/14.
//  Copyright (c) 2014 MiCasa. All rights reserved.
//

#import "Pelicula.h"

@implementation Pelicula

#pragma mark - Atributos
@synthesize idPelicula = _idPelicula;
@synthesize titulo = _titulo;
@synthesize titulo_original = _titulo_original;
@synthesize anio = _anio;
@synthesize duracion = _duracion;
@synthesize pais = _pais;
@synthesize director = _director;
@synthesize guion = _guion;
@synthesize musica = _musica;
@synthesize fotografia = _fotografia;
@synthesize reparto = _reparto;
@synthesize productora = _productora;
@synthesize web = _web;
@synthesize sinopsis = _sinopsis;
@synthesize portada = _portada;
@synthesize cartelera = _cartelera;
@synthesize estreno = _estreno;
@synthesize fechaEstreno = _fechaEstreno;


#pragma mark - Inicializador con parámetros
- (id)initConParametros:(int)idDePelicula
       tituloDePelicula:(NSString *)titulo
tituloOriginalDePelicula:(NSString *)titulo_original
       anioDeLaPelicula:(int)anio
     duracionDePelicula:(int)duracion
         paisDePelicula:(NSString *)pais
     directorDePelicula:(NSString *)director
        guionDePelicula:(NSString *)guion
       musicaDePelicula:(NSString *)musica
 fotografiaDeLaPelicula:(NSString *)fotografia
    repartoDeLaPelicula:(NSString *)reparto
 productoraDeLaPelicula:(NSString *)productora
        webDeLaPelicula:(NSString *)web
   sinopsisDeLaPelicula:(NSString *)sinopsis
    portadaDeLaPelicula:(NSString *)portada
  carteleraDeLaPelicula:(NSString *) cartelera
    estrenoDeLaPelicula:(NSString *) estreno
fechaEstrenoDeLaPelicula:(NSString *) fechaEstreno
{
    //Se llama al init de la superclase
    self = [super init];
    
    //Si todo va bien
    if(self){
        [self setIdPelicula:idDePelicula];
        [self setTitulo:titulo];
        [self setTitulo_original:titulo_original];
        [self setAnio:anio];
        [self setDuracion:duracion];
        [self setPais:pais];
        [self setDirector:director];
        [self setGuion:guion];
        [self setMusica:musica];
        [self setFotografia:fotografia];
        [self setReparto:reparto];
        [self setProductora:productora];
        [self setWeb:web];
        [self setSinopsis:sinopsis];
        [self setPortada:portada];
        [self setCartelera:cartelera];
        [self setEstreno:estreno];
        [self setFechaEstreno:fechaEstreno];
    }
    return self;
}
 

- (NSArray *) titlesArrayToMakeDescriptionSheet
{
    NSArray *array = @[@"",@"Año: ", @"País: ", @"Director: ", @"Sinopsis: ", @"Guión: ", @"Reparto: ", @"Música: ", @"Fotografía: ", @"Productora: ", @"Web: "];
    return array;
}

- (NSArray *) stringsArrayToMakeDescriptionSheet
{
    NSString * anio = [NSString stringWithFormat:@"%d", _anio];
    NSArray *array = @[_titulo, anio, _pais, _director, _sinopsis, _guion, _reparto, _musica, _fotografia, _productora, _web];
    
    return array;
}


@end
















