//
//  PuntuacionUsuario.m
//  iFear
//
//  Created by Dacio Leal Rodriguez on 02/07/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import "PuntuacionUsuario.h"

@implementation PuntuacionUsuario


- (id) initWithParameters: (NSString *)usuario andPuntuacionTerror: (NSString *)puntuacionTerror andPuntuacionSangre: (NSString *)puntuacionSangre andPuntuacionHumor: (NSString *)puntuacionHumor andPuntuacionCalidad: (NSString *)puntuacionCalidad
{
    self = [super init];
    if (self) {
        _usuario = usuario;
        _puntuacionTerror = puntuacionTerror;
        _puntuacionSangre = puntuacionSangre;
        _puntuacionHumor = puntuacionHumor;
        _puntuacionCalidad = puntuacionCalidad;
    }
    
    return self;
    
}
@end
