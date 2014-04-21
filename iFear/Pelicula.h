//
//  Pelicula.h
//  ConexionConServidor
//
//  Created by José Alberto Martín Falcón on 31/01/14.
//  Copyright (c) 2014 MiCasa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Pelicula : NSObject 


#pragma mark - Atributos

@property int idPelicula;
@property (strong, nonatomic) NSString * titulo;
@property (strong, nonatomic) NSString * titulo_original;
@property int anio;
@property int duracion;
@property (strong, nonatomic) NSString * pais;
@property (strong, nonatomic) NSString * director;
@property (strong, nonatomic) NSString * guion;
@property (strong, nonatomic) NSString * musica;
@property (strong, nonatomic) NSString * fotografia;
@property (strong, nonatomic) NSString * reparto;
@property (strong, nonatomic) NSString * productora;
@property (strong, nonatomic) NSString * web;
@property (strong, nonatomic) NSString * sinopsis;
@property (strong, nonatomic) NSString * portada;

@property (strong, nonatomic) UIImage * imagen;
@property (strong, nonatomic) NSURL * urlImagen;





#pragma  mark - Inicializador con parámetros

- (id)initConParametros:(int) idPelicula
         tituloDePelicula:(NSString *) titulo
 tituloOriginalDePelicula:(NSString *) titulo_original
           anioDeLaPelicula:(int) anio
       duracionDePelicula:(int) duracion
           paisDePelicula:(NSString *) pais
       directorDePelicula:(NSString *) director
          guionDePelicula:(NSString *) guion
       musicaDePelicula:(NSString *) musica
 fotografiaDeLaPelicula:(NSString *) fotografia
    repartoDeLaPelicula:(NSString *) reparto
 productoraDeLaPelicula:(NSString *) productora
        webDeLaPelicula:(NSString *) web
   sinopsisDeLaPelicula:(NSString *) sinopsis
    portadaDeLaPelicula:(NSString *) portada;

- (NSArray *) titlesArrayToMakeDescriptionSheet;

- (NSArray *) stringsArrayToMakeDescriptionSheet;



@end
