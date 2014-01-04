//
//  Film.h
//  JSClient
//
//  Created by Riccardo Faveto on 11/10/13.
//  Copyright (c) 2013 Riccardo Faveto. All rights reserved.
//


@interface Film: NSObject

@property int *Id;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *trama;
@property int *year;
@property int *durata;
@property (strong, nonatomic) NSString *cover;
@property int *coverW;
@property int *coverH;
@property (strong, nonatomic) NSData *data;
@property int *cat;
@property (strong, nonatomic) NSString *genere;
@end