//
//  BusquedaSubGeneroViewController.h
//  iFear
//
//  Created by José Alberto Martín Falcón on 20/04/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>

// Protoco para devolver los datos hasta el ViewController Padre.
@protocol BusquedaSubGeneroDelegate <NSObject>
- (void) getSelectedSubGenre: (NSMutableArray *) subgenres;
@end



@interface BusquedaSubGeneroViewController : UIViewController

// Delegado
@property (nonatomic, weak) id<BusquedaSubGeneroDelegate> delegate;

// Botones de subgeneros
@property (weak, nonatomic) IBOutlet UIButton *animacionButton;
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
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *listButons;

// Método llamado cuando se pulsa algún botón de subgénero
- (IBAction)pushCategoriesButton:(id)sender;

- (void) searchInArray: (NSString *) subgenre;

// Método para desactivar todos los botones
- (void) enabledAllButtons: (Boolean) state;

// Método para desactivar todos los botones
- (void) selectAllButtons: (Boolean) state;

@end
