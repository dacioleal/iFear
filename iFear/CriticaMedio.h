//
//  CriticaMedio.h
//  iFear
//
//  Created by Dacio Leal Rodriguez on 04/06/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CriticaMedio : NSObject

@property (nonatomic, strong) NSString *autor;
@property (nonatomic, strong) NSString *medio;
@property (nonatomic, strong) NSString *contenido;

- (id) initWithParameters: (NSString *)autor andMedio: (NSString *)medio andContenido: (NSString *)contenido;

@end
