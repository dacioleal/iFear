//
//  CriticaMedio.m
//  iFear
//
//  Created by Dacio Leal Rodriguez on 04/06/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import "CriticaMedio.h"

@implementation CriticaMedio

- (id) initWithParameters: (NSString *)autor andMedio: (NSString *)medio andContenido: (NSString *)contenido
{
    self = [super init];
    if (self) {
        _autor = autor;
        _medio = medio;
        _contenido = contenido;
    }
    
    return self;
}
@end
