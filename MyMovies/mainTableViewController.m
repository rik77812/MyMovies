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
@synthesize Progress;

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
    [self LoadData];

}

- (void)LoadData{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.navigationController.toolbarHidden = NO;
    [self.storyboard instantiateViewControllerWithIdentifier:@"TVC"];
    self.Progress.progress = 0.0;
    NSURL *url = [NSURL URLWithString:@"http://centcom:81/MyMoviesWS/MyMovies.svc/GetAllFilmsInJson"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval: 20.0]; // Will timeout after 10 seconds
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue currentQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               
                               if (data != nil && error == nil)
                               {
                                   self.Progress.hidden = FALSE;
                                   
                                   [self performSelectorInBackground:@selector(fetchedData:) withObject:data];
                                   
                               }
                               else
                               {
                                   // There was an error, alert the user
                                   UIAlertView *errSyncAlert = [[UIAlertView alloc]
                                                                initWithTitle:@"ERROR" message:@"Error during synchronization" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                   
                                   // Display the Hello World Message
                                   [errSyncAlert show];
                                   [self fillTableView];
                                   
                               }
                               
                           }];

}


- (void)fillTableView
{
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
        f.cat= [[info valueForKey:@"intAddType"] intValue];
        f.genere = [info valueForKey:@"nvcGenrs"];
        [filmsTMP addObject:f];
    }
    self.films = [filmsTMP copy]; //6
    [self.tableView reloadData];
}

- (void)fillTableViewOn
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
     NSPredicate *predicate = [NSPredicate predicateWithFormat:@"intAddType == 3"];
    
    [fetchRequest setPredicate:predicate];
    
    
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
    return 70;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [self.films count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *cellIdentifier = @"Cell";
    TableCell *cell = (TableCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.delegate = self;

    if (cell == nil)
    {
 
       cell = [[TableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    }
    cell.cellTitle.text = [[films objectAtIndex:indexPath.row] title];
      Film * f = [films objectAtIndex:indexPath.row];
    NSString *detail =[NSString stringWithFormat:@"%ld",  (long)f.year];
    detail = [detail stringByAppendingString:@" "];
    detail = [detail stringByAppendingString:f.genere];
    cell.cellDescr.text = detail;
    NSString * imagesPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *imagesExt = @".jpg";
    NSString *imageName  = [NSString stringWithFormat:@"%@%@%@%@", imagesPath, @"/",f.cover, imagesExt];
   UIImage *thumbNail = [UIImage imageWithContentsOfFile:imageName];
    cell.cellImage.image = thumbNail;
    NSString *StatusImg = @"";
    if(f.cat == 3)
        StatusImg = @"green.png";
    else
        StatusImg = @"red.png";
    UIImage *Status = [UIImage imageNamed:StatusImg];
    cell.statusImage.image = Status;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailVC *dvc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailVC"];
    dvc.film = [self.films objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:dvc animated:YES];
}

- (IBAction)ClickSyncButton:(id)sender{
    self.Progress.progress = 0.0;
    [self LoadData];
}


- (IBAction)ClickAllButton:(id)sender{
    [self fillTableView];
}

- (IBAction)ClickOnButton:(id)sender{
    [self fillTableViewOn];

}


- (void) deleteAllObjects: (NSString *) entityDescription  {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context =
    [appDelegate managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityDescription inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *items = [context executeFetchRequest:fetchRequest error:&error];
    for (NSManagedObject *managedObject in items) {
    	[context deleteObject:managedObject];
    }
    if (![context save:&error]) {
    	
    }
    
}

- (void)fetchedData:(NSData *)responseData {
    
    [self deleteAllObjects:@"Titles"];
    NSArray* json = [NSJSONSerialization
                     JSONObjectWithData:responseData //1
                     options:kNilOptions error:nil];
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context =
    [appDelegate managedObjectContext];
    
    int total = [json count];
    int progress  = 0;
    self.SyncButton.enabled = NO;
    // enrica
    NSString * documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    //enrica fine
    for (NSDictionary *dict in json) { //3
        
        NSNumber *prog = [[NSNumber alloc] initWithFloat:((float)progress / (float)total)];
        [self performSelectorOnMainThread:@selector(updateProgressBar:) withObject:prog waitUntilDone:NO];
        progress = progress + 1;
        
        Film *f = [[Film alloc] init]; //4
        NSManagedObject *newTitle;
        newTitle = [NSEntityDescription
                    insertNewObjectForEntityForName:@"Titles"
                    inManagedObjectContext:context];
        f.Id = [[dict objectForKey:@"Id"] intValue];
        [newTitle setValue: [NSNumber numberWithInt:f.Id] forKey:@"intId"];
        f.title         = [dict objectForKey:@"LocalTitle"];
        [newTitle setValue: f.title forKey:@"nvcLocalTitle"];
        f.trama =[dict objectForKey:@"Trama"];
        [newTitle setValue: f.trama forKey:@"ntxDescription"];
        f.year = [[dict objectForKey:@"Anno"] intValue];
        [newTitle setValue: [NSNumber numberWithInt:f.year] forKey:@"intProductionYear"];
        f.durata = [[dict objectForKey:@"Durata"] intValue];
        [newTitle setValue: [NSNumber numberWithInt:f.durata] forKey:@"intRuntime"];
        f.cover =[dict objectForKey:@"Cover"];
        [newTitle setValue: f.cover forKey:@"nvcCover"];
        f.coverW = [[dict objectForKey:@"CoverW"] intValue];
        [newTitle setValue: [NSNumber numberWithInt:f.coverW] forKey:@"intCoverWidth"];
        f.coverH = [[dict objectForKey:@"CoverH"] intValue];
        [newTitle setValue: [NSNumber numberWithInt:f.coverH] forKey:@"intCoverHeight"];
        NSString *theDate = [dict objectForKey:@"InsertDate"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd/MM/yyyy HH:mm:ss"];//07/09/2011 08:21:08
        f.data = [formatter dateFromString:theDate];
        [newTitle setValue: f.data forKey:@"datDataChanged"];
        f.cat= [[dict objectForKey:@"Gruppo"] intValue];
        [newTitle setValue: [NSNumber numberWithInt:f.cat] forKey:@"intAddType"];
        f.genere         = [dict objectForKey:@"Generi"];
        [newTitle setValue: f.genere forKey:@"nvcGenrs"];
        //enrica
        
        NSString *imagesPath = @"http://centcom:81/Covers/";
        NSString *imagesExt = @".jpg";
        NSString * localImagePathName= [NSString stringWithFormat:@"%@%@%@%@", documentsDirectoryPath, @"/",f.cover, imagesExt];
        BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:localImagePathName];
        if (!fileExists) {
            
            //Get Image From URL
            NSString *imageName  = [NSString stringWithFormat:@"%@%@%@", imagesPath, f.cover, imagesExt];
            UIImage * coverFromURL = [self getCoverFromURL:imageName];
            //Save Image to Directory
            [self saveCover: coverFromURL withFileName:f.cover ofType:@"jpg" inDirectory:documentsDirectoryPath];
            
        }
    }
    UIAlertView *syncDoneAlert = [[UIAlertView alloc]
                                  initWithTitle:@"Synchronizing" message:@"Synchronization done" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    self.SyncButton.enabled = YES;
    self.Progress.hidden = TRUE;
    [self fillTableView];
    // Display the Hello World Message
    [syncDoneAlert show];
    
}

-(UIImage *) getCoverFromURL:(NSString *)fileURL {
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    
    return result;
}
// SAVE COVER IN LOCAL FILE SYSTEM
-(void) saveCover:(UIImage *)image withFileName:(NSString *)imageName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath {
    if ([[extension lowercaseString] isEqualToString:@"png"]) {
        [UIImagePNGRepresentation(image) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"png"]] options:NSAtomicWrite error:nil];
    } else if ([[extension lowercaseString] isEqualToString:@"jpg"] || [[extension lowercaseString] isEqualToString:@"jpeg"]) {
        [UIImageJPEGRepresentation(image, 1.0) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"jpg"]] options:NSAtomicWrite error:nil];
    } else {
        //   ALog(@"Image Save Failed\nExtension: (%@) is not recognized, use (PNG/JPG)", extension);
    }
}

- (void)updateProgressBar: (NSNumber *) prognum {
    self.Progress.progress = [prognum floatValue];
}



@end
