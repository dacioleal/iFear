//
//  LadoOscuroTableViewController.m
//  iFear
//
//  Created by Dacio Leal Rodriguez on 02/07/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import "LadoOscuroTableViewController.h"
#import "UserScoreCell.h"

@interface LadoOscuroTableViewController ()

@end

@implementation LadoOscuroTableViewController

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
    [self.navigationController.navigationBar setHidden:YES];

    NSLog(@"Puntuaciones Usuarios: %@", _puntuacionesUsuariosArray);
   
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
    return _puntuacionesUsuariosArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView registerNib:[UINib nibWithNibName:@"UserScoreCell" bundle:nil] forCellReuseIdentifier:@"scoreCell"];
    UserScoreCell *cell = (UserScoreCell *)[tableView dequeueReusableCellWithIdentifier:@"scoreCell" forIndexPath:indexPath];
    // Configure the cell...
    
    NSDictionary *dict = [_puntuacionesUsuariosArray objectAtIndex:indexPath.row];
    NSString *userName = [dict objectForKey:@"nombre_usuario"];
    NSString *terrorString = [dict valueForKey:@"terror"];
    NSString *goreString = [dict valueForKey:@"gore"];
    NSString *humorString = [dict valueForKey:@"humor"];
    NSString *calidadString = [dict valueForKey:@"calidad"];
    
     cell.userNameLabel.text = userName;
    
    UIColor *textColor = [[UIColor alloc] initWithRed:172.0/255.0 green:143.0/255.0 blue:40.0/255.0 alpha:1.0];
    UIFont *font = [UIFont fontWithName:@"Impact" size:32.0];
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:terrorString attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];

    
    cell.terrorLabel.textAlignment = NSTextAlignmentCenter;
    cell.terrorLabel.attributedText = attrString;
    
    attrString = [[NSAttributedString alloc] initWithString:goreString attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
    cell.goreLabel.textAlignment = NSTextAlignmentCenter;
    cell.goreLabel.attributedText = attrString;
    
    attrString = [[NSAttributedString alloc] initWithString:humorString attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
    cell.humorLabel.textAlignment = NSTextAlignmentCenter;
    cell.humorLabel.attributedText = attrString;
    
    attrString = [[NSAttributedString alloc] initWithString:calidadString attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
    cell.calidadLabel.textAlignment = NSTextAlignmentCenter;
    cell.calidadLabel.attributedText = attrString;
    
    textColor = [[UIColor alloc] initWithRed:56.0/255.0 green:21.0/255.0 blue:20.0/255.0 alpha:1.0];
    font = [UIFont fontWithName:@"Futura-Medium" size:16.0];
    attrString = [[NSAttributedString alloc] initWithString:userName attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
    cell.userNameLabel.attributedText = attrString;
    
    if ((indexPath.row % 2) == 0) {
        cell.backgroundColor = [[UIColor alloc] initWithRed:191.0/255.0 green:176.0/255.0 blue:166.0/255.0 alpha:1.0];
    } else {
        cell.backgroundColor = [[UIColor alloc] initWithRed:154.0/255.0 green:136.0/255.0 blue:127.0/255.0 alpha:1.0];
        
    }
   
    return cell;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
