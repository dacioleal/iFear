//
//  CriticasUsuariosTableViewController.m
//  iFear
//
//  Created by Dacio Leal Rodriguez on 11/06/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import "CriticasUsuariosTableViewController.h"
#import "CriticaUsuarioViewController.h"
#import "CriticaUsuario.h"

@interface CriticasUsuariosTableViewController ()

@end

@implementation CriticasUsuariosTableViewController

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
    
    UIColor *textColor = [[UIColor alloc] initWithRed:0.28 green:0.02 blue:0.02 alpha:1.0];
    UIFont *font = [UIFont fontWithName:@"Futura-Medium" size:18.0];
    NSDictionary *titleAttributes = @{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor};
    self.navigationController.navigationBar.titleTextAttributes = titleAttributes;
    self.navigationController.navigationBar.topItem.title = @"Críticas Usuarios";
    
    self.navigationController.navigationBar.tintColor = [[UIColor alloc] initWithRed:0.28 green:0.02 blue:0.02 alpha:1.0];
    [self.navigationController.navigationBar setHidden:YES];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    
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
    return _criticasUsuariosArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    UIColor *cellColor = [UIColor clearColor];
    cell.backgroundColor = cellColor;
    //cell.tintColor = [[UIColor alloc] initWithRed:0.28 green:0.02 blue:0.02 alpha:1.0];
    cell.accessoryView.tintColor= [[UIColor alloc] initWithRed:0.28 green:0.02 blue:0.02 alpha:1.0];
    
    UIView *customCellSelectedBackgroundView = [[UIView alloc] init];
    customCellSelectedBackgroundView.backgroundColor = [[UIColor alloc] initWithRed:0.28 green:0.02 blue:0.02 alpha:1.0];
    cell.selectedBackgroundView = customCellSelectedBackgroundView;
    
    CriticaUsuario *critica = (CriticaUsuario *) [_criticasUsuariosArray objectAtIndex:indexPath.row];
    NSString *usuario = critica.usuario;
    NSString *titulo = critica.titulo;
    
    UIColor *textColor = [[UIColor alloc] initWithRed:0.28 green:0.02 blue:0.02 alpha:1.0];
    UIFont *font = [UIFont fontWithName:@"Futura-Medium" size:16.0];
    NSAttributedString *titleAttributedString = [[NSAttributedString alloc] initWithString:titulo attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
    cell.textLabel.attributedText = titleAttributedString;
    
    textColor = [[UIColor alloc] initWithRed:0.28 green:0.02 blue:0.02 alpha:1.0];
    font = [UIFont fontWithName:@"Futura-Light" size:16.0];
    NSAttributedString *descriptionAttributedString = [[NSAttributedString alloc] initWithString:usuario attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
    cell.detailTextLabel.attributedText = descriptionAttributedString;
    
    
    if ((indexPath.row % 2) == 0) {
        cell.backgroundColor = [[UIColor alloc] initWithRed:239.0/255.0 green:210.0/255.0 blue:213.0/255.0 alpha:1.0];
    } else {
        cell.backgroundColor = [[UIColor alloc] initWithRed:238.0/255.0 green:223.0/255.0 blue:226.0/255.0 alpha:1.0];
        
    }
    
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"goToCritica" sender:self];
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"goToCritica"])
    {
        if ([segue.destinationViewController respondsToSelector:@selector(setCriticaUsuario:)]) {
            
            NSIndexPath *index = [self.tableView indexPathForSelectedRow];
            CriticaUsuario *cu = (CriticaUsuario *) [_criticasUsuariosArray objectAtIndex:index.row];
            [segue.destinationViewController performSelector:@selector(setCriticaUsuario:) withObject:cu];
        }
    }
    
}


@end
