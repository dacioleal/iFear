//
//  PuntuacionUsuario.h
//  iFear
//
//  Created by Dacio Leal Rodriguez on 02/07/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PuntuacionUsuario : NSObject

@property (nonatomic, strong) NSString *usuario;
@property (nonatomic, strong) NSString *puntuacionTerror;
@property (nonatomic, strong) NSString *puntuacionSangre;
@property (nonatomic, strong) NSString *puntuacionHumor;
@property (nonatomic, strong) NSString *puntuacionCalidad;

- (id) initWithParameters: (NSString *)usuario andPuntuacionTerror: (NSString *)puntuacionTerror andPuntuacionSangre: (NSString *)puntuacionSangre andPuntuacionHumor: (NSString *)puntuacionHumor andPuntuacionCalidad: (NSString *)puntuacionCalidad;

@end
