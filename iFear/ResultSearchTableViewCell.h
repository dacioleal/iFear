//
//  ResultSearchTableViewCell.h
//  iFear
//
//  Created by José Alberto Martín Falcón on 07/06/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultSearchTableViewCell : UITableViewCell

// Imagen
@property (weak, nonatomic) IBOutlet UIImageView *movieImage;
// Etiquetas de contenido
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblDirector;
@property (weak, nonatomic) IBOutlet UILabel *lblSinopsis;
@property (weak, nonatomic) IBOutlet UILabel *lblNombreDirector;


@end
