//
//  CriticaFlash.h
//  iFear
//
//  Created by Dacio Leal Rodriguez on 10/06/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CriticaFlash : NSObject

@property (nonatomic, strong) NSString *usuario;
@property (nonatomic, strong) NSString *contenido;
@property (nonatomic, strong) NSString *fecha;

- (id) initWithParameters: (NSString *)usuario andContenido: (NSString *)contenido andFecha: (NSString *)fecha;
@end
