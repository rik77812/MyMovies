//
//  DetailVC.m
//  TableViewTutorial
//
//  Created by dev27 on 6/17/13.
//  Copyright (c) 2013 Codigator. All rights reserved.
//

#import "DetailVC.h"

@interface DetailVC ()

@end

@implementation DetailVC
@synthesize film;

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
  //9
    [self.titoloOutlet setText:self.film.title];
    [self.annoOutlet setText:[@"Anno: " stringByAppendingString: [NSString stringWithFormat:@"%d", self.film.year]]];
    [self.durataOutlet setText:[[NSString stringWithFormat:@"%d",self.film.durata]  stringByAppendingString:@" min."]];
    [self.tramaOutlet  setText:film.trama];
    [self.catOutlet setText:self.film.genere];
    NSString * imagesPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *imagesExt = @".jpg";
    NSString *imageName  = [NSString stringWithFormat:@"%@%@%@%@", imagesPath, @"/",self.film.cover, imagesExt];
    UIImage *thumbNail = [UIImage imageWithContentsOfFile:imageName];
    self.Locandina.image = thumbNail;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
