//
//  BusquedaViewController.h
//  iFear
//
//  Created by Dacio Leal Rodriguez on 30/01/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopoverSelectorBusquedaViewController.h"
#import "BusquedaSubGeneroViewController.h"
#import "BusquedaSensacionesViewController.h"

@interface BusquedaViewController : UIViewController <UIPopoverControllerDelegate, PopoverSelectorBusquedaDelegate, BusquedaSubGeneroDelegate, BusquedaSensacionesDelegate>

// Botón SWITCH de búsqueda
@property (weak, nonatomic) IBOutlet UIButton *buscarSensacionesButton;
@property (weak, nonatomic) IBOutlet UIButton *buscarSubGenButton;

// Método cuando se pulsa el botón de buscar
- (IBAction)pushBuscarButton:(id)sender;

// Popover
@property(strong, nonatomic) UIPopoverController * selectorPopover;
// Contenido del Popover
@property (nonatomic, strong) PopoverSelectorBusquedaViewController * popoverContent;

// Método para mostrar el Popover
- (IBAction)showPopover:(id)sender;

// Container donde se mostrarán los tipo de Búsqueda: Subgeneros o Sensaciones
@property (weak, nonatomic) IBOutlet UIView *container;

@end
