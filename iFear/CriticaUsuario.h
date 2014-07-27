//
//  CriticaUsuario.h
//  iFear
//
//  Created by Dacio Leal Rodriguez on 11/06/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CriticaUsuario : NSObject

@property (nonatomic, strong) NSString *idUsuario;
@property (nonatomic, strong) NSString *usuario;
@property (nonatomic, strong) NSString *titulo;
@property (nonatomic, strong) NSString *contenido;
@property (nonatomic, strong) NSString *fecha;

- (id) initWithParameters: (NSString *)usuario andTitulo: (NSString *)titulo andContenido: (NSString *)contenido andFecha: (NSString *)fecha;
@end
