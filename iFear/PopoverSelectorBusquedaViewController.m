//
//  PopoverSelectorBusquedaViewController.m
//  iFear
//
//  Created by José Alberto Martín Falcón on 02/03/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import "PopoverSelectorBusquedaViewController.h"

@interface PopoverSelectorBusquedaViewController ()
{
    // Listado con las opciones que tendrá el popover
    NSMutableArray  * optionSearchList;
    NSMutableArray * imageList;
}

@end

@implementation PopoverSelectorBusquedaViewController

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
    
    optionSearchList = [[NSMutableArray alloc] initWithObjects:@"Titulo",@"Director",@"Reparto", nil];
    imageList = [[NSMutableArray alloc] init];
    [imageList addObject:[UIImage imageNamed:@"selector_titulo_318x54.png"]];
    [imageList addObject:[UIImage imageNamed:@"selector_director_318x54.png"]];
    [imageList addObject:[UIImage imageNamed:@"selector_reparto_318x54.png"]];
    
    
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
    return optionSearchList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
     ///cell.textLabel.text = [optionSearchList objectAtIndex:indexPath.row];
    

//    cell.backgroundView = [ [[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"opcion_activada.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0] ]];
    cell.backgroundView = [[UIImageView alloc] initWithImage:[imageList objectAtIndex:indexPath.row]];
//    cell.selectedBackgroundView = [ [[UIImageView alloc] initWithImage:[ [UIImage i   mageNamed:@"cell_pressed.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0] ]autorelease];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *selected = [optionSearchList objectAtIndex:indexPath.row];
    
    //Notify the delegate if it exists.
    if (_delegate != nil) {
        [_delegate setSearchSelector:selected imgButtonSelected:[imageList objectAtIndex:indexPath.row]];
    }
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
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
