//
//  mainTableViewController.m
//  JSClient
//
//  Created by Riccardo Faveto on 08/10/13.
//  Copyright (c) 2013 Riccardo Faveto. All rights reserved.
//

#import "mainTableViewController.h"

@interface mainTableViewController ()

@end



@implementation mainTableViewController
@synthesize films;
//@synthesize managedObjectContext;

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
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context =
    [appDelegate managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Titles" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]
                              initWithKey:@"nvcLocalTitle" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    NSError *error;
    NSArray *items = [context executeFetchRequest:fetchRequest error:&error];
     NSMutableArray *filmsTMP = [[NSMutableArray alloc] initWithCapacity:[items count]];
    for (NSManagedObject *info in items) {
        Film *f = [[Film alloc] init];
        f.Id = [[info valueForKey:@"intId"] intValue];
        f.title = [info valueForKey:@"nvcLocalTitle"];
        f.trama = [info valueForKey:@"ntxDescription"];
        f.year = [[info valueForKey:@"intProductionYear"] intValue];
        f.durata = [[info valueForKey:@"intRuntime"] intValue];
        f.cover = [info valueForKey:@"nvcCover"];
        f.coverW = [[info valueForKey:@"intCoverWidth"] intValue];
        f.coverH = [[info valueForKey:@"intCoverHeight"] intValue];
       // NSString *theDate = [info valueForKey:@"datDataChanged"];
       // NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
       // [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss CET"];
       // f.data = [formatter dateFromString:theDate];
        f.cat= [[info valueForKey:@"intAddType"] intValue];
        f.genere = [info valueForKey:@"nvcGenrs"];
        [filmsTMP addObject:f];
    }
    self.films = [filmsTMP copy]; //6
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.films count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   // static NSString *CellIdentifier = @"Cell";
    static NSString *cellIdentifier = @"TableCellID";
       // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
   // if (cell == nil) {
   //     cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
   // }
    TableCell *cell = (TableCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.delegate = self;

    if (cell == nil)
    {
      // NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Cell" owner:self options:nil];
      // cell = [nib objectAtIndex:0];
       cell = [[TableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.cellTitle = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 220.0, 15.0)];
       cell.cellTitle.font = [UIFont systemFontOfSize:14.0];
        cell.cellTitle.textAlignment = UITextAlignmentLeft;
       cell.cellTitle.textColor = [UIColor blackColor];
        cell.cellTitle.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
        [cell.contentView addSubview:cell.cellTitle];
        
        cell.cellDescr = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 20.0, 220.0, 25.0)];
        cell.cellDescr.font = [UIFont systemFontOfSize:12.0];
        cell.cellDescr.textAlignment = UITextAlignmentLeft;
        cell.cellDescr.textColor = [UIColor darkGrayColor];
        cell.cellDescr.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
        [cell.contentView addSubview:cell.cellDescr];

    }
    cell.cellTitle.text = [[films objectAtIndex:indexPath.row] title];
    //cell.textLabel.font=[UIFont fontWithName:@"Arial Rounded MT Bold" size:10.0];
    Film * f = [films objectAtIndex:indexPath.row];
    // Configure the cell...
    NSString *detail =[NSString stringWithFormat:@"%ld",  (long)f.year];
    detail = [detail stringByAppendingString:@" "];
    detail = [detail stringByAppendingString:f.genere];
    cell.cellDescr.text = detail;
    //enrica
    NSString * imagesPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *imagesExt = @".jpg";
    NSString *imageName  = [NSString stringWithFormat:@"%@%@%@%@", imagesPath, @"/",f.cover, imagesExt];
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(cell.contentView.frame.origin.x, cell.contentView.frame.origin.y, cell.contentView.frame.size.width, cell.contentView.frame.size.height)];
    imageView.image = [UIImage imageNamed:imageName];
   // cell.cellImage.image = imageView.image;
   //  cell.cellImage.image = imageView.image;
    //[cell.contentView addSubview:imageView];
    //enricafine
    return cell;
}

/*-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    Film *f = [self.films objectAtIndex:indexPath.row];
    DetailedViewController *dvc = (DetailedViewController *)[segue destinationViewController];
    [dvc setFilm:f]; //4
}*/
/*-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailedViewController *dvc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailedViewController"];
    dvc.film = [self.films objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:dvc animated:YES];
}*/

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailVC *dvc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailVC"];
     Film *f = [[Film alloc] init];
     f = [self.films objectAtIndex:indexPath.row];
    dvc.film = f;
    [self.navigationController pushViewController:dvc animated:YES];
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
