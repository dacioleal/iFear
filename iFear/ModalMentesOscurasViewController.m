//
//  ModalMentesOscurasViewController.m
//  iFear
//
//  Created by José Alberto Martín Falcón on 23/08/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import "ModalMentesOscurasViewController.h"
#import "Opinion.h"
#import "MentesOscurasOpinionesCellTableViewCell.h"

@interface ModalMentesOscurasViewController ()
{
    NSMutableArray * opinionesArray;
}

@end

@implementation ModalMentesOscurasViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Se establece un color negro semi-transparene a la vista principal
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.6f];
    
    // Animación
    UIInterpolatingMotionEffect* m1 =
    [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x"
                                                    type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    m1.maximumRelativeValue = @10.0;
    m1.minimumRelativeValue = @-10.0;
    UIInterpolatingMotionEffect* m2 =
    [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y"
                                                    type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    m2.maximumRelativeValue = @10.0;
    m2.minimumRelativeValue = @-10.0;
    UIMotionEffectGroup* g = [UIMotionEffectGroup new];
    g.motionEffects = @[m1,m2];
    
    [self.popupView addMotionEffect:g];
    
    
    self.opinionTable.dataSource = self;
    self.opinionTable.delegate = self;
    
    
    opinionesArray = [[NSMutableArray alloc] init];
    
    Opinion * opinion = [[Opinion alloc] initWithMovieTitle:@"INSIDIOUS: CHAPTER 2 (2013)" andFlashReview:@"Cuando una franquicia no da para más" andReview:@"No disponible" andTerrorScore:@"90" andGoreScore:@"40" andHumorScore:@"65" andCalidadScore:@"85"];
    
    [opinionesArray addObject:opinion];
    [opinionesArray addObject:opinion];
    [opinionesArray addObject:opinion];
    [opinionesArray addObject:opinion];
    
    [self setStyleTopHits];
    [self setStyleUserData];
    [self setStyleUserName];
    [self setStyleWorstMovie];
    
    self.topHitsView.hidden = NO;
    self.opinionView.hidden = YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}





- (IBAction)pushReturnButton:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:Nil];
}

#pragma mark - Style Font config -

- (void) setFontAndColor:(id)sender withText: (NSString *) text andWithColor: (UIColor *) textColor andWithFont: (UIFont *) font
{
    NSAttributedString *atrStr = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
    UILabel *auxLabel =  (UILabel *) sender;
    auxLabel.attributedText = atrStr;
    auxLabel.shadowColor = [UIColor blackColor];
    auxLabel.shadowOffset = CGSizeMake(0, 2);
    [auxLabel sizeToFit];
}

- (void) setStyleInArray:(NSArray *) list andWithColor: (UIColor *) textColor andWithFont: (UIFont *) font
{
    for (UILabel * label in list) {
        [self setFontAndColor:label withText:label.text andWithColor:textColor andWithFont:font];
    }
}

- (void) setStyleUserData
{
    UIColor *textColor = [UIColor colorWithRed:237/255.0 green:194/255.0 blue:0/255.0 alpha:1];
    UIFont *font = [UIFont fontWithName:@"Futura-Book" size:21.0];
   
    [self setStyleInArray:self.listLabelUserData andWithColor:textColor andWithFont:font];
}

- (void) setStyleWorstMovie
{
    UIColor *textColor = [UIColor colorWithRed:166/255.0 green:164/255.0 blue:164/255.0 alpha:1];
    UIColor *textColorData = [UIColor colorWithRed:130/255.0 green:130/255.0 blue:130/255.0 alpha:1];
    UIFont *font = [UIFont fontWithName:@"Futura-Book" size:18.0];
    
    [self setFontAndColor:self.labelWorstMovieTerror withText:self.labelWorstMovieTerror.text andWithColor:textColor andWithFont:font];
    [self setFontAndColor:self.titleWorstMovieTerror withText:self.titleWorstMovieTerror.text andWithColor:textColorData andWithFont:font];
}


- (void) setStyleTopHits
{
    UIColor *textColorLabel = [UIColor colorWithRed:237/255.0 green:194/255.0 blue:0/255.0 alpha:1];
    UIColor *textColorData = [UIColor colorWithRed:193/255.0 green:0/255.0 blue:31/255.0 alpha:1];
    UIFont *font = [UIFont fontWithName:@"Futura-Book" size:18.0];
    
    [self setStyleInArray:self.listLabelTitleTopHits andWithColor:textColorLabel andWithFont:font];
    [self setStyleInArray:self.listTitleTopHits andWithColor:textColorData andWithFont:font];
}


- (void) setStyleUserName
{
    UIColor *textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    UIFont *font = [UIFont fontWithName:@"Futura-Book" size:28.0];
    
    [self setFontAndColor:self.labelUserName withText:self.labelUserName.text andWithColor:textColor andWithFont:font];
}
//Pregunta el número de elementos que debe representar
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return opinionesArray.count;
}

//Crea la celda
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Se comprueba si existe una celda para que pueda reutilizarse
    MentesOscurasOpinionesCellTableViewCell *celda = (MentesOscurasOpinionesCellTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"opinionCell"];
    
    //Si no hay ninguna que pueda reutilizarse entonces se procede a crear una
    
    if (!celda){
        celda = [[MentesOscurasOpinionesCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"opinionCell"];
    }
    
    Opinion * currentOpinion = [opinionesArray objectAtIndex:indexPath.row];
    
    [self configCellWithIndex:indexPath andCell:celda andCurrentOpinion: currentOpinion];
    
    
    return celda;
}


- (void) configCellWithIndex: (NSIndexPath *) indexPath andCell: (MentesOscurasOpinionesCellTableViewCell *)celda andCurrentOpinion: (Opinion *) currentOpinion
{
    
    UIColor *textColorData;
    UIFont *font;
    // Imagen de fondo
    UIImage * filaImpar = [[UIImage imageNamed:@"casilla_impar_000x000.jpg"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0];
    UIImage * filaPar = [[UIImage imageNamed:@"casilla_par_816x292.jpg"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0];
    UIImageView * cellBgView = nil;
    
    int  esFilaPar = indexPath.row % 2 == 0;
    
    
    cellBgView = [[UIImageView alloc] initWithImage:filaImpar];
    if (esFilaPar) {
        cellBgView = [[UIImageView alloc] initWithImage:filaPar];
    }
    
    celda.backgroundView = cellBgView;
    
    textColorData = [UIColor colorWithRed:47/255.0 green:20/255.0 blue:20/255.0 alpha:1];
    font = [UIFont fontWithName:@"Futura-Book" size:22.0];
    
    [self setFontAndColor:celda.lblMovieTitle withText:[currentOpinion movieTitle] andWithColor:textColorData andWithFont:font];
    
    textColorData = [UIColor colorWithRed:80/255.0 green:27/255.0 blue:27/255.0 alpha:1];
    font = [UIFont fontWithName:@"Futura-Medium" size:18.0];
    
    
     [self setFontAndColor:celda.lblFlash withText:celda.lblFlash.text andWithColor:textColorData andWithFont:font];
     [self setFontAndColor:celda.lblFlashReview withText:[currentOpinion flashReview] andWithColor:textColorData andWithFont:font];
     [self setFontAndColor:celda.lblReviewTitle withText:celda.lblReviewTitle.text andWithColor:textColorData andWithFont:font];
     [self setFontAndColor:celda.lblReviewUser withText:[currentOpinion review] andWithColor:textColorData andWithFont:font];
    
    textColorData = [[UIColor alloc] initWithRed:0.89 green:0.65 blue:0.08 alpha:1.0];
    font = [UIFont fontWithName:@"Impact" size:36.0];
    
    [self setFontAndColor:celda.lblTerror withText:[currentOpinion terrorScore] andWithColor:textColorData andWithFont:font];
    [self setFontAndColor:celda.lblGore withText:[currentOpinion goreScore] andWithColor:textColorData andWithFont:font];
    [self setFontAndColor:celda.lblHumor withText:[currentOpinion humorScore] andWithColor:textColorData andWithFont:font];
    [self setFontAndColor:celda.lblCalidad withText:[currentOpinion calidadScore] andWithColor:textColorData andWithFont:font];
    
}


- (IBAction)changeView:(id)sender
{
    UIButton * auxButton = (UIButton *) sender;
    
    
    if (auxButton.tag == 1001) {
        self.topHitsView.hidden = FALSE;
        self.opinionView.hidden = TRUE;
    }else{
        self.topHitsView.hidden = TRUE;
        self.opinionView.hidden = FALSE;
    }
}

@end
