//
//  BusquedaSensacionesViewController.h
//  iFear
//
//  Created by José Alberto Martín Falcón on 20/04/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomIfearSlider.h"
#import "ProgresSlider.h"


// Protoco para devolver los datos hasta el ViewController Padre.
@protocol BusquedaSensacionesDelegate <NSObject>
- (void) getSensationsValues: (NSMutableDictionary *) categoriesValues;
@end


@interface BusquedaSensacionesViewController : UIViewController

// Delegado
@property (nonatomic, weak) id<BusquedaSensacionesDelegate> delegate;


// Sliders
@property (weak, nonatomic) IBOutlet ProgresSlider *progressTerrorSlider;
@property (weak, nonatomic) IBOutlet ProgresSlider *progressGoreSlider;
@property (weak, nonatomic) IBOutlet ProgresSlider *progressHumorSlider;
@property (weak, nonatomic) IBOutlet ProgresSlider *progressCalidadSlider;

// Porcentaje
@property (weak, nonatomic) IBOutlet UILabel *terrorPercent;
@property (weak, nonatomic) IBOutlet UILabel *gorePercent;
@property (weak, nonatomic) IBOutlet UILabel *humorPercent;
@property (weak, nonatomic) IBOutlet UILabel *calidadPercent;

- (void)sliderValueChanged:(id)sender;

- (void) resetSliders;

- (void) enableAllSliders: (BOOL) state;

@end
