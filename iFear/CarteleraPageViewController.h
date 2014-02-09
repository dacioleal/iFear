//
//  CarteleraPageViewController.h
//  iFear
//
//  Created by José Alberto Martín Falcón on 02/02/14.
//  Copyright (c) 2014. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarteleraPageViewController : UIPageViewController <NSURLSessionDataDelegate, NSURLSessionDownloadDelegate, UIPageViewControllerDataSource,UIPageViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicadorDeCargo;
@property (weak, nonatomic) IBOutlet UIImageView *imagenUno;
@property (weak, nonatomic) IBOutlet UIImageView *imagenDos;
@property (weak, nonatomic) IBOutlet UIImageView *imagenTres;
@property (weak, nonatomic) IBOutlet UIImageView *imagenCuatro;
@property (weak, nonatomic) IBOutlet UIImageView *imagenCinco;

- (IBAction)pulsarObtenDatos:(id)sender;

@end
