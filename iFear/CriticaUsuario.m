//
//  CriticaUsuario.m
//  iFear
//
//  Created by Dacio Leal Rodriguez on 11/06/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import "CriticaUsuario.h"

@implementation CriticaUsuario

- (id) initWithParameters: (NSString *)usuario andTitulo:(NSString *)titulo andContenido:(NSString *)contenido andFecha:(NSString *)fecha
{
    self = [super init];
    if (self) {
        _usuario = usuario;
        _titulo = titulo;
        _contenido = contenido;
        _fecha = fecha;
    }
    
    return self;
}
@end
