//
//  CriticaFlash.m
//  iFear
//
//  Created by Dacio Leal Rodriguez on 10/06/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import "CriticaFlash.h"

@implementation CriticaFlash

- (id) initWithParameters: (NSString *)usuario andContenido:(NSString *)contenido andFecha:(NSString *)fecha
{
    self = [super init];
    if (self) {
        _usuario = usuario;
        _contenido = contenido;
        _fecha = fecha;
    }
    
    return self;
}
@end
