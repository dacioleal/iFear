//
//  BusquedaViewController.h
//  iFear
//
//  Created by José Alberto Martín Falcón on 01/05/14.
//  Copyright (c) 2014 José Alberto Martín Falcón. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopoverSelectorBusquedaViewController.h"
#import "BusquedaSubGeneroViewController.h"
#import "BusquedaSensacionesViewController.h"

@interface BusquedaViewController : UIViewController <UIPopoverControllerDelegate, PopoverSelectorBusquedaDelegate, BusquedaSubGeneroDelegate, BusquedaSensacionesDelegate, UITextFieldDelegate>

// Botón SWITCH de búsqueda
@property (weak, nonatomic) IBOutlet UIButton *buscarSensacionesButton;
@property (weak, nonatomic) IBOutlet UIButton *buscarSubGenButton;
@property (weak, nonatomic) IBOutlet UIView *loadingView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

// Método que cambiar el estado de los botones de buscar por subgenero o por sensaciones
- (IBAction)setStateSwitchs:(id)sender;

// Método cuando se pulsa el botón de buscar
- (IBAction)pushBuscarButton:(id)sender;

// Popover
@property (weak, nonatomic) IBOutlet UIButton *popoverSelectedOption;
@property(strong, nonatomic) UIPopoverController * selectorPopover;

// Contenido del Popover
@property (nonatomic, strong) PopoverSelectorBusquedaViewController * popoverContent;

// Método para mostrar el Popover
- (IBAction)showPopover:(id)sender;

- (void) showLoadingView: (BOOL) shown;

// Container donde se mostrarán los tipo de Búsqueda: Subgeneros o Sensaciones
@property (weak, nonatomic) IBOutlet UIView *container;
@property (weak, nonatomic) IBOutlet UITextField *textFieldSearch;

@end
