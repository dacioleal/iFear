//
//  BusquedaSensacionesViewController.m
//  iFear
//
//  Created by José Alberto Martín Falcón on 20/04/14.
//  Copyright (c) 2014 José Alberto Martín Falcón. All rights reserved.
//

#import "BusquedaSensacionesViewController.h"

@interface BusquedaSensacionesViewController ()
{
    // Diccionario donde guardar las sensaciones que se eligen
    NSMutableDictionary * sensationValues;
    // Array con los sliders customizados para recorrerlos todos después facilmente y resetearlos
    NSMutableArray * listCustomSliders;
}

@end

@implementation BusquedaSensacionesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Se inicializa el array
    listCustomSliders = [[NSMutableArray alloc] init];
    // Se inicializa el diccionario de parámetros
    sensationValues = [[NSMutableDictionary alloc] init];
    
    // Se le añaden las claves
    [sensationValues setObject:[NSNumber numberWithInt:0]  forKey:@"Terror"];
    [sensationValues setObject:[NSNumber numberWithInt:0] forKey:@"Gore"];
    [sensationValues setObject:[NSNumber numberWithInt:0] forKey:@"Humor"];
    [sensationValues setObject:[NSNumber numberWithInt:0] forKey:@"Calidad"];
    
    // Se configuran las labels
    [self setFontAndColor:self.terrorPercent withText: @"0"];
    [self setFontAndColor:self.gorePercent withText: @"0"];
    [self setFontAndColor:self.calidadPercent withText: @"0"];
    [self setFontAndColor:self.humorPercent withText: @"0"];
    
    // Se inicializan los Slider con función de barra de progreso
    [self initProgressSlider:self.progressTerrorSlider withImageName:@"trozo_barra_terror_50x70.png"];
    [self initProgressSlider:self.progressGoreSlider withImageName:@"trozo_barra_gore_50x70.png"];
    [self initProgressSlider:self.progressHumorSlider withImageName:@"trozo_barra_humor_50x70.png"];
    [self initProgressSlider:self.progressCalidadSlider withImageName:@"trozo_barra_calidad_50x70.png"];
    
    // Se inicializan los slider customizados
    [self initCustomSlider:0 withValues:100];
    [self initCustomSlider:1 withValues:100];
    [self initCustomSlider:2 withValues:100];
    [self initCustomSlider:3 withValues:100];
    
    
}


#pragma mark - Funciones Propias -

// Método para inicializar un ProgressSlider
- (void) initProgressSlider:(id)sender withImageName: (NSString *) imageName
{
    // Se obtiene la referencia al ProgressSlider que sea
    ProgresSlider * auxSlider = (ProgresSlider *) sender;
    
    // Se desactiva la barra de progreso para que no se pueda arrastrar
    auxSlider.userInteractionEnabled = NO;
    
    // Imagen que llevará el progreso
    UIImage *progressTrackImage = [UIImage imageNamed: imageName] ;
    progressTrackImage = [self imageWithImage:progressTrackImage scaledToSize:CGSizeMake(25, 35)];
    
    // Esto es para que no salga la imagen del manejador
    [auxSlider setThumbImage:[[UIImage alloc]init] forState:UIControlStateNormal];
    // Se establece la imagen para el progreso del slider
    [auxSlider setMinimumTrackImage: progressTrackImage forState: UIControlStateNormal];
    
    // Se establece que comience en 0
    auxSlider.value = 0;
    
    // Se pone una imagen de fondo transparente para el MaximunTrack
    auxSlider.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin;
    UIGraphicsBeginImageContextWithOptions((CGSize){ 1, 1 }, NO, 0.0f);
    UIImage *transparentImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [auxSlider setMaximumTrackImage:transparentImage forState:UIControlStateNormal];
    
}

// Método para inicializar nuestros slider customizados
- (void) initCustomSlider: (int)sliderType withValues: (int) values
{
    CGRect frame;
    CustomIfearSlider * auxSlider;
    
    switch (sliderType) {
            // Terror
        case 0:
            frame = CGRectMake(self.progressTerrorSlider.frame.origin.x, self.progressTerrorSlider.frame.origin.y + 44, 502.0, 31.0);
            auxSlider = [[CustomIfearSlider alloc] initWithFrame:frame numberOfValues:values];
            auxSlider.tag = 1;
            
            break;
            // Gore
        case 1:
            frame = CGRectMake(self.progressGoreSlider.frame.origin.x, self.progressGoreSlider.frame.origin.y + 44, 502.0, 31.0);
            auxSlider = [[CustomIfearSlider alloc] initWithFrame:frame numberOfValues:values];
            auxSlider.tag = 2;
            break;
            // Humor
        case 2:
            frame = CGRectMake(self.progressHumorSlider.frame.origin.x, self.progressHumorSlider.frame.origin.y + 44, 502.0, 31.0);
            auxSlider = [[CustomIfearSlider alloc] initWithFrame:frame numberOfValues:values];
            auxSlider.tag = 3;
            break;
            // Calidad
        case 3:
            frame = CGRectMake(self.progressCalidadSlider.frame.origin.x, self.progressCalidadSlider.frame.origin.y + 44, 502.0, 31.0);
            auxSlider = [[CustomIfearSlider alloc] initWithFrame:frame numberOfValues:values];
            auxSlider.tag = 4;
            break;
    }
    // Se establece el método que gestiona los cambios de valores
    [auxSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    // Se establece el color del track
    auxSlider.trackColor = [UIColor blackColor];
    auxSlider.backgroundColor = [UIColor clearColor];
    auxSlider.trackHeight = 5.0;
    UIImage * img = [UIImage imageNamed:@"indicador_107x58.png"];
    auxSlider.leftHandlerImage = [self imageWithImage:img scaledToSize:CGSizeMake(55, 27)];
    // Se añade al array de custom sliders
    [listCustomSliders addObject:auxSlider];
    [self.view addSubview:auxSlider];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)sliderValueChanged:(id)sender
{
    CustomIfearSlider *auxSlider =  (CustomIfearSlider *) sender;
    NSUInteger currentValue =  ((int)((auxSlider.currentLeftSegment + 2.5) / 5) * 5);;
    switch (auxSlider.tag) {
        case 1:
            if (currentValue == 0){
                self.progressTerrorSlider.value = currentValue;
                [self setFontAndColor:self.terrorPercent withText: [NSNumber numberWithInteger:currentValue].stringValue];
                
            }else{
                self.progressTerrorSlider.value = currentValue;
                [self setFontAndColor:self.terrorPercent withText: [NSNumber numberWithInteger:currentValue].stringValue];
            }
            
            [sensationValues setValue:[NSNumber numberWithInt:self.progressTerrorSlider.value] forKey:@"Terror"];
            break;
        case 2:
            if (currentValue == 0){
                self.progressGoreSlider.value = currentValue;
                [self setFontAndColor:self.gorePercent withText: [NSNumber numberWithInteger:currentValue].stringValue];
            }else{
                self.progressGoreSlider.value = currentValue;
                [self setFontAndColor:self.gorePercent withText: [NSNumber numberWithInteger:currentValue].stringValue];
            }
            [sensationValues setValue:[NSNumber numberWithInt:self.progressGoreSlider.value] forKey:@"Gore"];
            break;
            
        case 3:
            if (currentValue == 0){
                self.progressHumorSlider.value = currentValue;
                [self setFontAndColor:self.humorPercent withText: [NSNumber numberWithInteger:currentValue].stringValue];
            }else{
                self.progressHumorSlider.value = currentValue;
                [self setFontAndColor:self.humorPercent withText: [NSNumber numberWithInteger:currentValue].stringValue];
            }
            [sensationValues setValue:[NSNumber numberWithInt:self.progressHumorSlider.value] forKey:@"Humor"];
            break;
            
        case 4:
            if (currentValue == 0){
                self.progressCalidadSlider.value = currentValue;
                [self setFontAndColor:self.calidadPercent withText: [NSNumber numberWithInteger:currentValue].stringValue];
                
            }else{
                self.progressCalidadSlider.value = currentValue;
                [self setFontAndColor:self.calidadPercent withText: [NSNumber numberWithInteger:currentValue].stringValue];
                
            }
            [sensationValues setValue:[NSNumber numberWithInt:self.progressCalidadSlider.value] forKey:@"Calidad"];
            
            break;
    }
    [self.delegate getSensationsValues:sensationValues];
}



//- (float)xPositionFromSliderValue:(UISlider *)aSlider;
//{
//    float sliderRange = aSlider.frame.size.width - aSlider.currentThumbImage.size.width;
//    float sliderOrigin = aSlider.frame.origin.x + (aSlider.currentThumbImage.size.width / 2.0);
//
//    float sliderValueToPixels = (((aSlider.value-aSlider.minimumValue)/(aSlider.maximumValue-aSlider.minimumValue)) * sliderRange) + sliderOrigin;
//
//    return sliderValueToPixels;
//}

#pragma mark - Métodos propios -
// Método para configurar las labels del porcentaje
- (void) setFontAndColor:(id)sender withText: (NSString *) text {
    UIColor *textColor = [[UIColor alloc] initWithRed:0.89 green:0.65 blue:0.08 alpha:1.0];
    UIFont *font = [UIFont fontWithName:@"Impact" size:36.0];
    NSAttributedString *atrStr = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
    UILabel *auxLabel =  (UILabel *) sender;
    auxLabel.attributedText = atrStr;
    auxLabel.shadowColor = [UIColor blackColor];
    auxLabel.shadowOffset = CGSizeMake(0, 2);
}

// Método para resetear los sliders
- (void) resetSliders
{
    self.progressTerrorSlider.value = 0;
    self.progressGoreSlider.value = 0;
    self.progressHumorSlider.value = 0;
    self.progressCalidadSlider.value = 0;
    
    for (CustomIfearSlider * slider in listCustomSliders) {
        [slider resetHandler];
    }
    
    [self setFontAndColor:self.terrorPercent withText: @"0"];
    [self setFontAndColor:self.gorePercent withText: @"0"];
    [self setFontAndColor:self.calidadPercent withText: @"0"];
    [self setFontAndColor:self.humorPercent withText: @"0"];
}

// Método para activar o desactivar los sliders
- (void) enableAllSliders: (BOOL) state
{
    for (CustomIfearSlider * slider in listCustomSliders) {
        slider.enabled = state;
    }
}

@end
