//
//  ResultadosBusquedaViewController.h
//  iFear
//
//  Created by José Alberto Martín Falcón on 07/06/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultadosBusquedaViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

// Botón para volver a la pantalla de búsqueda
- (IBAction)pushBackButton:(id)sender;

// Tabla donde se mostrarán los resultados
@property (weak, nonatomic) IBOutlet UITableView *resultsTable;

@property (strong, nonatomic) NSArray * resultSearchList;

@end
