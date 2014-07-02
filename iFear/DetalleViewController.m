//
//  DetalleViewController.m
//  iFear
//
//  Created by Dacio Leal Rodriguez on 12/03/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import "DetalleViewController.h"
#import "CriticasTableViewController.h"
#import "CriticasFlashTableViewController.h"
#import "CriticasUsuariosTableViewController.h"
#import "Pelicula.h"
#import "TrailersSearch.h"
#import "CriticasMediosSearch.h"
#import "CriticasFlashSearch.h"
#import "CriticasUsuariosSearch.h"
#import "PuntuacionesMediasSearch.h"
#import "ScoreBar.h"
#import <AVFoundation/AVFoundation.h>

#define SCORE_BAR_LENGTH 300

@interface DetalleViewController ()
{
    NSString *movieID;
    NSArray *leftPanelButtons;
    NSArray *reviewsPanelButtons;
    NSArray *trailersArray;
    NSArray *criticasMediosArray;
    NSArray *criticasFlashArray;
    NSArray *criticasUsuariosArray;
    NSDictionary *puntuacionesMediasDictionary;
    NSArray *contentViews;
    UIView *mediaView;
    UIView *flashView;
    UIView *usersView;
}




- (IBAction)imageTap:(UITapGestureRecognizer *)sender;

@end

@implementation DetalleViewController


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
	// Do any additional setup after loading the view.
    
    contentViews = @[_descriptionTextView, _trailersScrollView, _reviewsContainerView];
    leftPanelButtons = @[_descriptionButton, _trailersButton, _reviewsButton, _darkSideButton];
    reviewsPanelButtons = @[_mediaButton, _flashButton, _usersButton];
    
    
    _movieImageView.image = _movie.imagen;
    
    UIColor *textColor = [[UIColor alloc] initWithRed:0.89 green:0.65 blue:0.08 alpha:1.0];
    UIFont *font = [UIFont fontWithName:@"Futura-Light" size:46.0];
    NSAttributedString *title = [[NSAttributedString alloc] initWithString:_movie.titulo attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
    _titleLabel.attributedText = title;
    _titleLabel.shadowColor = [UIColor blackColor];
    _titleLabel.shadowOffset = CGSizeMake(0, 2);
    
    [self descriptionPushButton:_descriptionButton];
    
    textColor = [[UIColor alloc] initWithRed:0.25 green:0.06 blue:0.04 alpha:1.0];
    font = [UIFont fontWithName:@"Impact" size:32.0];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"Ficha Técnica" attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
    _contentTitleLabel.attributedText = attributedString;
    
    
    [self configureDescriptionTextView];
    [self configureLeftPanelButtons];
    [self configureReviewsPanelButtons];
    [self hideReviewsPanelButton];
    [self mediaPushButton:_mediaButton];
    
    
    //Creamos un objeto de la clase TrailersSearch para obtener los datos de los trailers de la película desde el servidor
    movieID = [[NSString alloc] initWithFormat:@"%d",_movie.idPelicula ] ;
    TrailersSearch *trailersSearch = [[TrailersSearch alloc] init];
    NSDictionary *parameters = [[NSDictionary alloc] initWithObjectsAndKeys:@"getTrailersForID", @"function", movieID, @"idMovie",nil];
    trailersArray = [trailersSearch searchWithParameters:parameters];
    
    //Creamos un objeto de la clase CriticasMediosSearch para obtener los datos de las críticas de medios de la película desde el servidor
    CriticasMediosSearch *criticasMediosSearch = [[CriticasMediosSearch alloc] init];
    NSDictionary *parametersCriticasMedios = [[NSDictionary alloc] initWithObjectsAndKeys:@"getCriticasMediosPelicula", @"function", movieID, @"idMovie",nil];
    criticasMediosArray = [criticasMediosSearch searchWithParameters:parametersCriticasMedios];
    
    //Creamos un objeto de la clase CriticasFlashSearch para obtener los datos de las críticas flash de la película desde el servidor
    CriticasFlashSearch *criticasFlashSearch = [[CriticasFlashSearch alloc] init];
    NSDictionary *parametersCriticasFlash = [[NSDictionary alloc] initWithObjectsAndKeys:@"getCriticasFlashPelicula", @"function", movieID, @"idMovie",nil];
    criticasFlashArray = [criticasFlashSearch searchWithParameters:parametersCriticasFlash];
    
    //Creamos un objeto de la clase CriticasUsuariosSearch para obtener los datos de las críticas de usuarios de la película desde el servidor
    CriticasUsuariosSearch *criticasUsuariosSearch = [[CriticasUsuariosSearch alloc] init];
    NSDictionary *parametersCriticasUsuarios = [[NSDictionary alloc] initWithObjectsAndKeys:@"getCriticasLargasPelicula", @"function", movieID, @"idMovie",nil];
    criticasUsuariosArray = [criticasUsuariosSearch searchWithParameters:parametersCriticasUsuarios];
    
    //Creamos un objeto de la clase PuntuacionesMediasSearch para obtener las puntuaciones medias de la película desde el servidor
    PuntuacionesMediasSearch *puntuacionesMediasSearch = [[PuntuacionesMediasSearch alloc] init];
    NSDictionary *parametersPuntuacionesMedias = [[NSDictionary alloc] initWithObjectsAndKeys:@"getPuntuacionesMediasPelicula", @"function", movieID, @"idMovie",nil];
    puntuacionesMediasDictionary = [puntuacionesMediasSearch searchWithParameters:parametersPuntuacionesMedias];
    
    
    //Añadimos al propio viewcontroller como observador de las notificaciones producidas por las distintos objetos de las clases Search que obtienen los datos del servidor y que cuando terminan de obtener estos datos lo comunican mediante la notificación correspondiente
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(configureTrailersView) name:@"trailersFinished" object:trailersSearch];
    [defaultCenter addObserver:self selector:@selector(configureTrailersView) name:@"NoTrailers" object:trailersSearch];
    [defaultCenter addObserver:self selector:@selector(configureCriticasMediosView) name:@"CriticasMediosFinished" object:criticasMediosSearch];
    [defaultCenter addObserver:self selector:@selector(configureCriticasMediosView) name:@"CriticasMediosEmpty" object:criticasMediosSearch];
    [defaultCenter addObserver:self selector:@selector(configureCriticasFlashView) name:@"CriticasFlashFinished" object:criticasFlashSearch];
    [defaultCenter addObserver:self selector:@selector(configureCriticasFlashView) name:@"CriticasFlashEmpty" object:criticasFlashSearch];
    [defaultCenter addObserver:self selector:@selector(configureCriticasUsuariosView) name:@"CriticasUsuariosFinished" object:criticasUsuariosSearch];
    [defaultCenter addObserver:self selector:@selector(configureCriticasUsuariosView) name:@"CriticasUsuariosEmpty" object:criticasUsuariosSearch];
    [defaultCenter addObserver:self selector:@selector(configurePuntuacionesMediasView) name:@"PuntuacionesMediasFinished" object:puntuacionesMediasSearch];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Push action methods

- (IBAction)backPushButton:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)descriptionPushButton:(UIButton *)sender {
    
    _backgroundImageView.image = [UIImage imageNamed:@"fondo_fichasC_2048x1536.jpg"];
    [self unselectLeftPanelButtons];
    [self hideContentViews];
    [self hideReviewsPanelButton];
    _descriptionTextView.hidden = NO;
    [_contentView bringSubviewToFront:_descriptionTextView];    
    [_descriptionButton setSelected:YES];
    
    UIColor *textColor = [[UIColor alloc] initWithRed:0.25 green:0.06 blue:0.04 alpha:1.0];
    UIFont *font = [UIFont fontWithName:@"Impact" size:32.0];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"Ficha Técnica" attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
    _contentTitleLabel.attributedText = attributedString;

}

- (IBAction)trailersPushButton:(UIButton *)sender {
    
    _backgroundImageView.image = [UIImage imageNamed:@"fondo_fichasC_2048x1536.jpg"];
    [self unselectLeftPanelButtons];
    [self hideContentViews];
    [self hideReviewsPanelButton];
    _trailersScrollView.hidden = NO;
    [_contentView bringSubviewToFront:_trailersScrollView];
    [_trailersButton setSelected:YES];
    
    UIColor *textColor = [[UIColor alloc] initWithRed:0.25 green:0.06 blue:0.04 alpha:1.0];
    UIFont *font = [UIFont fontWithName:@"Impact" size:32.0];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"Trailers" attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
    _contentTitleLabel.attributedText = attributedString;
    
}

- (IBAction)reviewsPushButton:(UIButton *)sender {
    
    _backgroundImageView.image = [UIImage imageNamed:@"fondo_fichasC_2048x1536.jpg"];
    [self unselectLeftPanelButtons];
    [self hideContentViews];
    [self showReviewsPanelButton];
    _reviewsContainerView.hidden = NO;
    [_contentView bringSubviewToFront:_reviewsContainerView];
    
    [_reviewsButton setSelected:YES];
    
    UIColor *textColor = [[UIColor alloc] initWithRed:0.25 green:0.06 blue:0.04 alpha:1.0];
    UIFont *font = [UIFont fontWithName:@"Impact" size:32.0];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"Críticas" attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
    _contentTitleLabel.attributedText = attributedString;

}

- (IBAction)darkSidePushButton:(UIButton *)sender {
    
    _backgroundImageView.image = [UIImage imageNamed:@"fondo_lado_oscuro_2048x1536.jpg"];
    //[_contentView bringSubviewToFront:_trailersScrollView];
    _contentTitleLabel.attributedText = nil;
    [self unselectLeftPanelButtons];
    [self hideReviewsPanelButton];
    [_darkSideButton setSelected:YES];
    
    
}

- (IBAction)rateMoviePushButton:(UIButton *)sender {
}

- (IBAction)mediaPushButton:(UIButton *)sender {
    
    [_reviewsContainerView bringSubviewToFront:mediaView];
    mediaView.hidden = NO;
    flashView.hidden = YES;
    usersView.hidden = YES;
    [_mediaButton setSelected:YES];
    [_flashButton setSelected:NO];
    [_usersButton setSelected:NO];
}

- (IBAction)flashPushButton:(UIButton *)sender {
    
    [_reviewsContainerView bringSubviewToFront:flashView];
    flashView.hidden = NO;
    mediaView.hidden = YES;
    usersView.hidden = YES;
    [_mediaButton setSelected:NO];
    [_flashButton setSelected:YES];
    [_usersButton setSelected:NO];
}

- (IBAction)usersPushButton:(UIButton *)sender {
    
    [_reviewsContainerView bringSubviewToFront:usersView];
    usersView.hidden = NO;
    mediaView.hidden = YES;
    flashView.hidden = YES;
    [_mediaButton setSelected:NO];
    [_flashButton setSelected:NO];
    [_usersButton setSelected:YES];
}


- (IBAction)imageTap:(UITapGestureRecognizer *)sender {
    
        CGRect initialBounds = CGRectMake(0, 0, 180, 258);
        CGRect finalBounds = CGRectMake(0, 0, 396,  516);
    
        CGPoint initialCenter = CGPointMake(121, 187);
        CGPoint finalCenter = CGPointMake(512, 384);
    
    if ((_movieImageView.center.x == initialCenter.x) && (_movieImageView.center.y == initialCenter.y)) {
        
        [UIView animateWithDuration:0.3 animations:^{
            _movieImageView.center = finalCenter;
            _movieImageView.bounds = finalBounds;
            
        }];
    } else if ((_movieImageView.center.x == finalCenter.x) && (_movieImageView.center.y == finalCenter.y)) {
        
        [UIView animateWithDuration:0.3 animations:^{
            _movieImageView.center = initialCenter;
            _movieImageView.bounds = initialBounds;
        }];
        
    }
    
}

#pragma mark - Personalized Methods

- (NSString *) createHTMLStringForVideoID: (NSString *) videoIDString
{
    //Crea la cadena HTML necesaria para la url de cada video
    NSString *string = [NSString stringWithFormat:@"<html><head><title>.</title><style>body,html,iframe{margin:0;padding:0;}</style></head><body><iframe width=\"1280\" height=\"720\" src=\"//www.youtube.com/embed/%@\" frameborder=\"0\" allowfullscreen></iframe></body></html>", videoIDString];
    return string;
}

# pragma mark - configure views methods

- (void) configureTrailersView
{
    
    float videoHeight = 304;  // Tamaño en altura del video para insertar el trailer
    float videoWidth = 540;   // Tamaño en anchura del video para insertar el trailer
    
    //Le damos tamaño a la VIEW para los trailers
    CGSize size = CGSizeMake(videoWidth, videoHeight * trailersArray.count);
    _trailersScrollView.contentSize = size;
    
    // Bucle para insertar los trailers en la VIEW
    for (int i=0 ; i<trailersArray.count ; i++ ) {
        
        CGRect rect = CGRectMake(0, videoHeight * i, videoWidth, videoHeight);
        UIWebView *youtubeWebView = [[UIWebView alloc] initWithFrame:rect];
        youtubeWebView.backgroundColor = [UIColor clearColor];
        youtubeWebView.scrollView.scrollEnabled = NO;;
        youtubeWebView.allowsInlineMediaPlayback = YES;
        NSString *trailerLink = (NSString *)[trailersArray objectAtIndex:i];
        [youtubeWebView loadHTMLString:[self createHTMLStringForVideoID:trailerLink] baseURL:[NSURL URLWithString:@"http://www.youtube.com"]];
        
        youtubeWebView.scalesPageToFit = YES;
        [_trailersScrollView addSubview:youtubeWebView];
    }
    
    
}

- (void) configureDescriptionTextView
{
    _descriptionTextView.textContainerInset = UIEdgeInsetsMake(5.0, 10.0, 0, 10.0);
    
    NSArray *titlesArray = [_movie titlesArrayToMakeDescriptionSheet];
    NSArray *stringsArray = [_movie stringsArrayToMakeDescriptionSheet];
    
    NSString *titleString = [[NSString alloc] init];
    NSString *descriptionString = [[NSString alloc] init];
    NSMutableAttributedString *completedAttributedString = [[NSMutableAttributedString alloc] init];
    
    for (int i = 1 ; i < titlesArray.count; i++) {
        
        titleString = [titlesArray objectAtIndex:i];
        
        titleString = [titleString uppercaseString];
        
        UIColor *textColor = [[UIColor alloc] initWithRed:0.76 green:0 blue:0.122 alpha:1.0];
        UIFont *font = [UIFont fontWithName:@"Futura-Medium" size:18.0];
        NSAttributedString *titleAttributedString = [[NSAttributedString alloc] initWithString:titleString attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
        
        descriptionString = [stringsArray objectAtIndex:i];
        
        textColor = [[UIColor alloc] initWithRed:0.84 green:0.84 blue:0.84 alpha:1.0];
        font = [UIFont fontWithName:@"Futura-Book" size:18.0];
         NSAttributedString *descriptionAttributedString = [[NSAttributedString alloc] initWithString:descriptionString attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
        [attributedString appendAttributedString:titleAttributedString];
        [attributedString appendAttributedString:descriptionAttributedString];
        [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
        [completedAttributedString appendAttributedString:attributedString];
        
    }
    
    _descriptionTextView.attributedText = completedAttributedString;
}

- (void) configureLeftPanelButtons
{
    
    UIColor *textColor = [[UIColor alloc] initWithRed:0.89 green:0.65 blue:0.08 alpha:1.0];
    UIFont *font = [UIFont fontWithName:@"Impact" size:24.0];
    NSAttributedString *normalAttributedString = [[NSAttributedString alloc] initWithString:@"FICHA" attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
    [_descriptionButton setAttributedTitle:normalAttributedString forState:UIControlStateNormal];

    textColor = [[UIColor alloc] initWithRed:0.28 green:0.016 blue:0.016 alpha:1.0];
    NSAttributedString *selectedAttributedString = [[NSAttributedString alloc] initWithString:@"FICHA" attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
    [_descriptionButton setAttributedTitle:selectedAttributedString forState:UIControlStateSelected];

    
    textColor = [[UIColor alloc] initWithRed:0.89 green:0.65 blue:0.08 alpha:1.0];
    normalAttributedString = [[NSAttributedString alloc] initWithString:@"TRAILERS" attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
    [_trailersButton setAttributedTitle:normalAttributedString forState:UIControlStateNormal];
    
    textColor = [[UIColor alloc] initWithRed:0.28 green:0.016 blue:0.016 alpha:1.0];
    selectedAttributedString = [[NSAttributedString alloc] initWithString:@"TRAILERS" attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
    [_trailersButton setAttributedTitle:selectedAttributedString forState:UIControlStateSelected];
 
    
    textColor = [[UIColor alloc] initWithRed:0.89 green:0.65 blue:0.08 alpha:1.0];
    normalAttributedString = [[NSAttributedString alloc] initWithString:@"CRÍTICA" attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
    [_reviewsButton setAttributedTitle:normalAttributedString forState:UIControlStateNormal];
    
    textColor = [[UIColor alloc] initWithRed:0.28 green:0.016 blue:0.016 alpha:1.0];
    selectedAttributedString = [[NSAttributedString alloc] initWithString:@"CRÍTICA" attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
    [_reviewsButton setAttributedTitle:selectedAttributedString forState:UIControlStateSelected];

    
}

- (void) configureReviewsPanelButtons
{
    UIColor *textColor = [[UIColor alloc] initWithRed:0.65 green:0.39 blue:0.39 alpha:1.0];
    UIFont *font = [UIFont fontWithName:@"Impact" size:24.0];
    NSAttributedString *normalAttributedString = [[NSAttributedString alloc] initWithString:@"MEDIOS" attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
    [_mediaButton setAttributedTitle:normalAttributedString forState:UIControlStateNormal];
    
    textColor = [[UIColor alloc] initWithRed:0.92 green:0.73 blue:0.05 alpha:1.0];
    NSAttributedString *selectedAttributedString = [[NSAttributedString alloc] initWithString:@"MEDIOS" attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
    [_mediaButton setAttributedTitle:selectedAttributedString forState:UIControlStateSelected];
    
    textColor = [[UIColor alloc] initWithRed:0.65 green:0.39 blue:0.39 alpha:1.0];
    normalAttributedString = [[NSAttributedString alloc] initWithString:@"FLASH" attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
    [_flashButton setAttributedTitle:normalAttributedString forState:UIControlStateNormal];
    
    textColor = [[UIColor alloc] initWithRed:0.92 green:0.73 blue:0.05 alpha:1.0];
    selectedAttributedString = [[NSAttributedString alloc] initWithString:@"FLASH" attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
    [_flashButton setAttributedTitle:selectedAttributedString forState:UIControlStateSelected];
    
    textColor = [[UIColor alloc] initWithRed:0.65 green:0.39 blue:0.39 alpha:1.0];
    normalAttributedString = [[NSAttributedString alloc] initWithString:@"USUARIOS" attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
    [_usersButton setAttributedTitle:normalAttributedString forState:UIControlStateNormal];
    
    textColor = [[UIColor alloc] initWithRed:0.92 green:0.73 blue:0.05 alpha:1.0];
    selectedAttributedString = [[NSAttributedString alloc] initWithString:@"USUARIOS" attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
    [_usersButton setAttributedTitle:selectedAttributedString forState:UIControlStateSelected];
    
}

- (void) configureCriticasMediosView
{
    //NSLog(@"Array de Críticas Medios: %@", criticasMediosArray);
    
    UINavigationController *criticasNC = [self.storyboard instantiateViewControllerWithIdentifier:@"criticasMediosNavigationController"];
    
    CriticasTableViewController *criticasTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"criticasTableViewController"];
    criticasTVC.movieID = movieID;
    criticasTVC.criticasMediosArray = criticasMediosArray;
    [criticasNC addChildViewController:criticasTVC];
    
    [self addChildViewController:criticasNC];
    mediaView = criticasNC.view;
    [_reviewsContainerView addSubview:mediaView];
    mediaView.frame = CGRectMake(0, 0, mediaView.superview.frame.size.width, mediaView.superview.frame.size.height);
    

}

- (void) configureCriticasFlashView
{
    //NSLog(@"Array de Críticas Flash: %@", criticasFlashArray);
    
    UINavigationController *criticasFlashNC = [self.storyboard instantiateViewControllerWithIdentifier:@"criticasFlashNavigationController"];
    CriticasFlashTableViewController *criticasFlashTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"criticasFlashTableViewController"];
    criticasFlashTVC.movieID = movieID;
    criticasFlashTVC.criticasFlashArray = criticasFlashArray;
    [criticasFlashNC addChildViewController:criticasFlashTVC];
    
    [self addChildViewController:criticasFlashNC];
    flashView = criticasFlashNC.view;
    [_reviewsContainerView addSubview:flashView];
    flashView.frame = CGRectMake(0, 0, flashView.superview.frame.size.width, flashView.superview.frame.size.height);
    flashView.hidden = YES;
    
}

- (void) configureCriticasUsuariosView
{
    //NSLog(@"Array de Críticas Usuarios: %@", criticasUsuariosArray);
    
    UINavigationController *criticasUsuariosNC = [self.storyboard instantiateViewControllerWithIdentifier:@"criticasUsuariosNavigationController"];
    CriticasUsuariosTableViewController *criticasUsuariosTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"criticasUsuariosTableViewController"];
    criticasUsuariosTVC.movieID = movieID;
    criticasUsuariosTVC.criticasUsuariosArray = criticasUsuariosArray;
    [criticasUsuariosNC addChildViewController:criticasUsuariosTVC];
    
    [self addChildViewController:criticasUsuariosNC];
    usersView = criticasUsuariosNC.view;
    [_reviewsContainerView addSubview:usersView];
    usersView.frame = CGRectMake(0, 0, usersView.superview.frame.size.width, usersView.superview.frame.size.height);
    usersView.hidden = YES;
    
}

- (void) configurePuntuacionesMediasView
{
    NSLog(@"%@", puntuacionesMediasDictionary);
    
    //Se calcula la altura de las barras de puntuación en función del valor de puntuación
    float terrorBarLength = [[puntuacionesMediasDictionary valueForKey:@"terror"] floatValue] * SCORE_BAR_LENGTH/100;
    float goreBarLength = [[puntuacionesMediasDictionary valueForKey:@"gore"] floatValue] * SCORE_BAR_LENGTH/100;
    float humorBarLength = [[puntuacionesMediasDictionary valueForKey:@"humor"] floatValue] * SCORE_BAR_LENGTH/100;
    float calidadBarLength = [[puntuacionesMediasDictionary valueForKey:@"calidad"] floatValue] * SCORE_BAR_LENGTH/100;
    
    //Se crean los objetos barras de puntuación. Se les pasa los parámetros de tamaño y la imagen patrón de fondo de la barra
    ScoreBar *terrorScoreBar = [[ScoreBar alloc] initWithFrame:CGRectMake(36.0, 393, 23.0, 0) andTiledImage:[[UIImage imageNamed:@"tramo_verde_girado180_47x6.png"] CGImage]];
    ScoreBar *goreScoreBar = [[ScoreBar alloc] initWithFrame:CGRectMake(78.0, 393, 23.0, 0) andTiledImage:[[UIImage imageNamed:@"tramo_rojo_girado180_47x6.png"] CGImage]];
    ScoreBar *humorScoreBar = [[ScoreBar alloc] initWithFrame:CGRectMake(121.0, 393, 23.0, 0) andTiledImage:[[UIImage imageNamed:@"tramo_amarillo_girado180_47x6.png"] CGImage]];
    ScoreBar *calidadScoreBar = [[ScoreBar alloc] initWithFrame:CGRectMake(163.0, 393, 23.0, 0) andTiledImage:[[UIImage imageNamed:@"tramo_azul_girado180_47x6.png"] CGImage]];
    
    //Se establece el origen de coordenadas de la barras en la esquina superior izquierda (0,0)
    terrorScoreBar.layer.anchorPoint = CGPointZero;
    goreScoreBar.layer.anchorPoint = CGPointZero;
    humorScoreBar.layer.anchorPoint = CGPointZero;
    calidadScoreBar.layer.anchorPoint = CGPointZero;
    
    //Se aplica un giro de 180º a las barras para que la coordenada "y" crezca hacia arriba
    terrorScoreBar.layer.transform = CATransform3DMakeAffineTransform(CGAffineTransformMakeRotation(M_PI));
    goreScoreBar.layer.transform = CATransform3DMakeAffineTransform(CGAffineTransformMakeRotation(M_PI));
    humorScoreBar.layer.transform = CATransform3DMakeAffineTransform(CGAffineTransformMakeRotation(M_PI));
    calidadScoreBar.layer.transform = CATransform3DMakeAffineTransform(CGAffineTransformMakeRotation(M_PI));
    
    //Se añaden las barras a la vista _scoresView
    [_scoresView addSubview:terrorScoreBar];
    [_scoresView addSubview:goreScoreBar];
    [_scoresView addSubview:humorScoreBar];
    [_scoresView addSubview:calidadScoreBar];
    
    //Se realiza la animación de llenado de las barras de puntuación
    [UIView animateWithDuration:0.5 animations:^{
        terrorScoreBar.bounds = CGRectMake(terrorScoreBar.bounds.origin.x, terrorScoreBar.bounds.origin.y, terrorScoreBar.bounds.size.width, terrorBarLength);
        goreScoreBar.bounds = CGRectMake(goreScoreBar.bounds.origin.x, goreScoreBar.bounds.origin.y, goreScoreBar.bounds.size.width, goreBarLength);
        humorScoreBar.bounds = CGRectMake(humorScoreBar.bounds.origin.x, humorScoreBar.bounds.origin.y, humorScoreBar.bounds.size.width, humorBarLength);
        calidadScoreBar.bounds = CGRectMake(calidadScoreBar.bounds.origin.x, calidadScoreBar.bounds.origin.y, calidadScoreBar.bounds.size.width, calidadBarLength);
        
    }];
}

- (void) unselectLeftPanelButtons
{
    for (int i=0; i<leftPanelButtons.count; i++) {
        UIButton *button = (UIButton *) [leftPanelButtons objectAtIndex:i];
        [button setSelected:NO];
    }
}

- (void) hideContentViews
{
    for ( UIView *view in contentViews) {
        view.hidden = YES;
    }
}

- (void) hideReviewsPanelButton
{
    for (UIButton *button in reviewsPanelButtons)
    {
        button.hidden = YES;
    }
}

- (void) showReviewsPanelButton
{
    for (UIButton *button in reviewsPanelButtons)
    {
        button.hidden = NO;
    }
}


@end

























