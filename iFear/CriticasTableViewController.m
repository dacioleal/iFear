//
//  CriticasTableViewController.m
//  iFear
//
//  Created by Dacio Leal Rodriguez on 29/04/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import "CriticasTableViewController.h"
#import "CriticasMediosSearch.h"
#import "CriticaMedio.h"
#import "DetalleViewController.h"
#import "CriticaMedioViewController.h"

@interface CriticasTableViewController ()
{
    
}

@end

@implementation CriticasTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationController.navigationBar.tintColor = [[UIColor alloc] initWithRed:0.76 green:0 blue:0.122 alpha:1.0];
    
    UIColor *textColor = [[UIColor alloc] initWithRed:0.76 green:0 blue:0.122 alpha:1.0];
    UIFont *font = [UIFont fontWithName:@"Futura-Medium" size:18.0];
    NSDictionary *titleAttributes = @{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor};
    self.navigationController.navigationBar.titleTextAttributes = titleAttributes;
    self.navigationController.navigationBar.topItem.title = @"Críticas Medios";
    
    [self.navigationItem setHidesBackButton:YES];
    
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.

    return _criticasMediosArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    UIColor *cellColor = [UIColor clearColor];
    cell.backgroundColor = cellColor;
    
    UIView *customCellSelectedBackgroundView = [[UIView alloc] init];
    customCellSelectedBackgroundView.backgroundColor = [[UIColor alloc] initWithRed:0.76 green:0 blue:0.122 alpha:1.0];
    cell.selectedBackgroundView = customCellSelectedBackgroundView;
    
    NSString *autor = [(CriticaMedio *)[_criticasMediosArray objectAtIndex:indexPath.row] autor];
    NSString *medio = [(CriticaMedio *)[_criticasMediosArray objectAtIndex:indexPath.row] medio];
    NSString *contenido = [(CriticaMedio *)[_criticasMediosArray objectAtIndex:indexPath.row] contenido];
    NSString *title = [NSString stringWithFormat:@"%@     %@", autor, medio ];
        
    UIColor *textColor = [[UIColor alloc] initWithRed:0.76 green:0 blue:0.122 alpha:1.0];
    UIFont *font = [UIFont fontWithName:@"Futura-Medium" size:18.0];
    NSAttributedString *titleAttributedString = [[NSAttributedString alloc] initWithString:title attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
    cell.textLabel.attributedText = titleAttributedString;
    
    textColor = [[UIColor alloc] initWithRed:0.84 green:0.84 blue:0.84 alpha:1.0];
    font = [UIFont fontWithName:@"Futura-Book" size:18.0];
    NSAttributedString *descriptionAttributedString = [[NSAttributedString alloc] initWithString:contenido attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
    cell.detailTextLabel.attributedText = descriptionAttributedString;
    cell.detailTextLabel.shadowColor = [UIColor blackColor];
    cell.detailTextLabel.shadowOffset = CGSizeMake(1, 1);
    
    if ((indexPath.row % 2) == 0) {
        cell.backgroundColor = [UIColor blackColor];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"goToComment" sender:self];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"goToComment"])
    {
        if ([segue.destinationViewController respondsToSelector:@selector(setCriticaMedio:)]) {
            
            NSIndexPath *index = [self.tableView indexPathForSelectedRow];
            CriticaMedio *cm = (CriticaMedio *) [_criticasMediosArray objectAtIndex:index.row];
            [segue.destinationViewController performSelector:@selector(setCriticaMedio:) withObject:cm];
        }
    }
    
}


@end
