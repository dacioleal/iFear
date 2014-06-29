//
//  IfearAlertView.m
//  iFear
//
//  Created by José Alberto Martín Falcón on 21/06/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//



#import "IfearAlertView.h"

@interface IfearAlertView () <UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>
// Vista del AlertView
@property (nonatomic, weak) IBOutlet UIView* alertView;
// Botón para cerrar el AlertView
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
// Etiqueta donde se mostrará el label
@property (weak, nonatomic) IBOutlet UILabel *lblMessage;
// Mensaje
@property (strong, nonatomic) NSString * message;
@end

@implementation IfearAlertView

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
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
    [self.alertView addMotionEffect:g];
    
    // Imagen de fondo de la alerta
    UIImage * img =[UIImage imageNamed:@"ventana_alerta_820x510.png"];
    UIImage * auxImg = [self imageWithImage:img scaledToSize:CGSizeMake(410, 255)];
    self.alertView.backgroundColor = [UIColor colorWithPatternImage:auxImg];
    
    // Configura el botón
    [self configButton];
    
    // Configura el label
    [self configLabelMessage];
    
}

// Cuando se pulsa en el botón para cerrar
- (IBAction) doDismiss: (id) sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}


#pragma  mark - UIViewControllerTransitioningDelegate -

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return self;
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self;
}

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController* vc1 =
    [transitionContext viewControllerForKey:
     UITransitionContextFromViewControllerKey];
    UIViewController* vc2 =
    [transitionContext viewControllerForKey:
     UITransitionContextToViewControllerKey];
    UIView* con = [transitionContext containerView];
    UIView* v1 = vc1.view;
    UIView* v2 = vc2.view;
    
    if (vc2 == self) { // presenting
        [con addSubview:v2];
        v2.frame = v1.frame;
        self.alertView.transform = CGAffineTransformMakeScale(1.6,1.6);
        v2.alpha = 0;
        v1.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
        [UIView animateWithDuration:0.25 animations:^{
            v2.alpha = 1;
            self.alertView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    } else { // dismissing
        [UIView animateWithDuration:0.25 animations:^{
            self.alertView.transform = CGAffineTransformMakeScale(0.5,0.5);
            v1.alpha = 0;
        } completion:^(BOOL finished) {
            v2.tintAdjustmentMode = UIViewTintAdjustmentModeAutomatic;
            [transitionContext completeTransition:YES];
        }];
    }
}

#pragma mark - Métodos propios -
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

// Método para mostrar el alert.
- (void) showAlert: (id) sender withMessage: (NSString *) message
{
    NSLog(@"%@",message);
    _message = message;
    // Configura el label
    [self configLabelMessage];
    
    UIViewController * auxVc = (UIViewController *) sender;
    
    [auxVc presentViewController:self animated:YES completion:nil];
}

// Método para configurar el label
- (void) configLabelMessage
{
    UIColor *textColorLbl = [UIColor whiteColor];
    UIFont *fontLbl = [UIFont fontWithName:@"Impact" size:14.0];
    NSAttributedString *normalAttributedStringLbl = [[NSAttributedString alloc] initWithString:_message attributes:@{NSFontAttributeName: fontLbl, NSForegroundColorAttributeName: textColorLbl}];
    [_lblMessage setAttributedText:normalAttributedStringLbl];
}
// Método para configurar el botón
- (void) configButton
{
    UIColor *textColor = [[UIColor alloc] initWithRed:0.89 green:0.65 blue:0.08 alpha:1.0];
    UIFont *font = [UIFont fontWithName:@"Impact" size:18.0];
    NSAttributedString *normalAttributedString = [[NSAttributedString alloc] initWithString:@"OK" attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
    [_closeButton setAttributedTitle:normalAttributedString forState:UIControlStateNormal];
}


@end

