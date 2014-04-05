//
//  BusquedaViewController.h
//  iFear
//
//  Created by Dacio Leal Rodriguez on 30/01/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopoverSelectorBusquedaViewController.h"

@interface BusquedaViewController : UIViewController <UIPopoverControllerDelegate, PopoverSelectorBusquedaDelegate, NSURLConnectionDataDelegate, NSURLSessionDownloadDelegate>

// Botón SWITCH de búsqueda
@property (weak, nonatomic) IBOutlet UIButton *buscarSensacionesButton;
@property (weak, nonatomic) IBOutlet UIButton *buscarSubGenButton;


// Botones de subgeneros
@property (weak, nonatomic) IBOutlet UIButton *catastrofeButton;
@property (weak, nonatomic) IBOutlet UIButton *cortometrajeButton;
@property (weak, nonatomic) IBOutlet UIButton *exorcismosButton;
@property (weak, nonatomic) IBOutlet UIButton *asesinosSeriesButton;
@property (weak, nonatomic) IBOutlet UIButton *sciFyButton;
@property (weak, nonatomic) IBOutlet UIButton *documentalButton;
@property (weak, nonatomic) IBOutlet UIButton *fakeButton;
@property (weak, nonatomic) IBOutlet UIButton *licantropos;
@property (weak, nonatomic) IBOutlet UIButton *enfermedadesButton;
@property (weak, nonatomic) IBOutlet UIButton *fantasmasButton;
@property (weak, nonatomic) IBOutlet UIButton *manicomiosButton;
@property (weak, nonatomic) IBOutlet UIButton *secuelaButton;
@property (weak, nonatomic) IBOutlet UIButton *zombiesButton;
@property (weak, nonatomic) IBOutlet UIButton *brujeriaButton;
@property (weak, nonatomic) IBOutlet UIButton *casasEncanButton;
@property (weak, nonatomic) IBOutlet UIButton *extraterrestresButton;
@property (weak, nonatomic) IBOutlet UIButton *gialloButton;
@property (weak, nonatomic) IBOutlet UIButton *metrajeEncontradoButton;
@property (weak, nonatomic) IBOutlet UIButton *serieTvButton;

@property (weak, nonatomic) IBOutlet UIButton *jHorrorButton;
@property (weak, nonatomic) IBOutlet UIButton *monstruosButton;

@property (weak, nonatomic) IBOutlet UIButton *sectasButton;
@property (weak, nonatomic) IBOutlet UIButton *vampirosButton;
@property (weak, nonatomic) IBOutlet UIButton *hechosRealesButton;
@property (weak, nonatomic) IBOutlet UIButton *comediaButton;



- (IBAction)pushBuscarButton:(id)sender;

// Botones para las categorias
@property (weak, nonatomic) IBOutlet UIButton *animacionButton;

// Popover
@property(strong, nonatomic) UIPopoverController * selectorPopover;

// Contenido del Popover
@property (nonatomic, strong) PopoverSelectorBusquedaViewController * popoverContent;

// Array que contiene todos los botones de busqueda
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *listCagegoriesSearchButton;

- (IBAction)pushCategoriesButton:(id)sender;

- (IBAction)setStateSensacionesButton:(id)sender;
- (IBAction)showPopover:(id)sender;

-(void) setImageForAllButtons;

@end
