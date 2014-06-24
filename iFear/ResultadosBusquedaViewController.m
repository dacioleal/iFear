//
//  ResultadosBusquedaViewController.m
//  iFear
//
//  Created by José Alberto Martín Falcón on 07/06/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import "ResultadosBusquedaViewController.h"
#import "Pelicula.h"
#import "ResultSearchTableViewCell.h"
#import "DetalleViewController.h"

@interface ResultadosBusquedaViewController ()
{
    Pelicula * movieSegue;
}

@end

@implementation ResultadosBusquedaViewController

@synthesize resultSearchList;
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
    
    // Establece los delegados de la tabla
    self.resultsTable.dataSource = self;
    self.resultsTable.delegate = self;
    
    // Para que la tabla sea transparente
    self.resultsTable.backgroundColor = [UIColor clearColor];
    self.resultsTable.opaque = NO;
    self.resultsTable.backgroundView = nil;
    self.resultsTable.separatorColor = [UIColor clearColor]; // Línea separadora
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - IBAction
- (IBAction)pushBackButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return self.resultSearchList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"resultCell";
    // Obtiene la celda
    ResultSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Obtiene la película
    Pelicula * movie = [resultSearchList objectAtIndex:indexPath.section];
    
    // Se configura la fila con los estilos y los datos
    [self conFigureRowWitMovie:movie andCell:cell];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView  willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Imagen de fondo
    UIImage * cuchilloBg = [[UIImage imageNamed:@"base_cuchillo_2020x348.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0];
    // Normal
    UIImageView * cellBgView = [[UIImageView alloc] initWithImage:cuchilloBg];
    // Selecconada
    UIImageView * cellSelectedBgView = [[UIImageView alloc] initWithImage:cuchilloBg];
    cell.backgroundView = cellBgView;
    cell.selectedBackgroundView = cellSelectedBgView;
    
    // Se le pone el fondo transparente
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor clearColor];
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    movieSegue = [resultSearchList objectAtIndex:indexPath.section];
    [self performSegueWithIdentifier:@"goToDetailMovieFromSearch" sender:self];
}

// Separacíon entre celdas
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15.; // you can have your own choice, of course
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}


#pragma mark - Segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"goToDetailMovieFromSearch"])
    {
        DetalleViewController * detalleVC = [segue destinationViewController];
        [detalleVC setMovie:movieSegue];
        
    }
}


#pragma mark - Métodos propios
- (void) setFontAndColor:(id)sender withText: (NSString *) text andWithColor: (UIColor *) textColor andWithFont: (UIFont *) font{
    NSMutableParagraphStyle *paragraphStyles = [[NSMutableParagraphStyle alloc] init];
    paragraphStyles.alignment                = NSTextAlignmentJustified;
    paragraphStyles.firstLineHeadIndent      = 0.05;    // Very IMP
    
    NSAttributedString *atrStr = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
    UILabel *auxLabel =  (UILabel *) sender;
    auxLabel.attributedText = atrStr;
    auxLabel.shadowColor = [UIColor blackColor];
    auxLabel.shadowOffset = CGSizeMake(0, 2);
    [auxLabel sizeToFit];
}

-(CGFloat)heightForLabel:(UILabel *)label withText:(NSString *)text
{
    CGSize maximumLabelSize     = CGSizeMake(290, FLT_MAX);
    CGRect  textRect = [text boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: label.font} context:nil];
    
    CGSize expectedLabelSize    = textRect.size;
    
    
    return expectedLabelSize.height;
}

-(void)resizeHeightToFitForLabel:(UILabel *)label
{
    CGRect newFrame         = label.frame;
    newFrame.size.height    = [self heightForLabel:label withText:label.text];
    label.frame             = newFrame;
}

-(void)resizeHeightToFitForLabel:(UILabel *)label withText:(NSString *)text
{
    label.text              = text;
    [self resizeHeightToFitForLabel:label];
}


- (void) conFigureRowWitMovie: (Pelicula *) movie andCell: (ResultSearchTableViewCell * ) cell
{
    UIColor *textColorTitle = [UIColor colorWithRed:145/255.0 green:43/255.0 blue:49/255.0 alpha:1];
    UIFont *fontTitle = [UIFont fontWithName:@"Futura-Medium" size:26.0];
    NSString * title = [NSString stringWithFormat:@"%@ (%i)", movie.titulo, movie.anio];
    [self setFontAndColor:cell.lblTitle withText:title andWithColor:textColorTitle andWithFont:fontTitle];
    
    // Nombre Director
    UIColor *textColorDirector = [UIColor colorWithRed:189/255.0 green:188/255.0 blue:188/255.0 alpha:1];
    UIFont *fontDirector = [UIFont fontWithName:@"Futura-Book" size:16.0];
    [self setFontAndColor:cell.lblNombreDirector withText:movie.director andWithColor:textColorDirector andWithFont:fontDirector];
    
    // Etiqueta director
    UIColor *textColorLblDirector = [UIColor colorWithRed:145/255.0 green:43/255.0 blue:49/255.0 alpha:1];
    [self setFontAndColor:cell.lblDirector withText:@"DIRECTOR:" andWithColor:textColorLblDirector andWithFont:fontDirector];
    
    // Sinopsis
    [self setFontAndColor:cell.lblSinopsis withText:movie.sinopsis andWithColor:textColorDirector andWithFont:fontDirector];
    
    [cell.movieImage setImage:movie.imagen];
}



@end
