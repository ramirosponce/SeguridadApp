//
//  DataHelper.m
//  SeguridadApp
//
//  Created by Ramiro Ponce on 05/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import "DataHelper.h"
#import "CategoryFilter.h"
#import "Comment.h"

@implementation DataHelper

+ (NSArray*) getMapData
{
    NSArray* data = @[@{@"id": @"1",
                        @"title": @"Robo de bolso",
                        @"datetime": [NSDate date],
                        @"description": @"Me robaron el bolso mientras caminaba, 2 personas",
                        @"location":@{@"lat":@"-33.2942646",@"lon":@"-66.3327161"}, // ,
                        @"affected": @"1",
                        @"isTrue": @"2",
                        @"isntTrue": @"0",
                        @"pictures": @[@"picture_example.png"],
                        @"tags":@[@"robo,asalto"],
                        @"isAnonymous": [NSNumber numberWithBool:YES],
                        @"user":@{
                                @"id":@"123",
                                @"username":@"Mr T",
                                @"picture":@"mrT.png"}
                        },
                      @{@"id": @"2",
                        @"title": @"Asalto a mano armada",
                        @"datetime": [NSDate date],
                        @"description": @"Me robaron el bolso mientras caminaba, 2 personas",
                        @"location":@{@"lat":@"-33.28311319395295",@"lon":@"-66.32809594273567"},
                        @"affected": @"2",
                        @"isTrue": @"2",
                        @"isntTrue": @"0",
                        @"pictures": @[@"picture_example.png"],
                        @"tags":@[@"robo,asalto"],
                        @"isAnonymous": [NSNumber numberWithBool:YES],
                        @"user":@{
                                @"id":@"12",
                                @"username":@"He Man",
                                @"picture":@"heman.png"}
                        },
                      @{@"id": @"3",
                        @"title": @"Asalto a mano armada 2",
                        @"datetime": [NSDate date],
                        @"description": @"Me robaron el bolso mientras caminaba, 2 personas",
                        @"location":@{@"lat":@"-33.27421551645575",@"lon":@"-66.31247475743294"},
                        @"affected": @"5",
                        @"isTrue": @"0",
                        @"isntTrue": @"0",
                        @"pictures": @[],
                        @"tags":@[@"robo,asalto"],
                        @"isAnonymous": [NSNumber numberWithBool:NO],
                        @"user":@{
                                @"id":@"34",
                                @"username":@"Diego Maradona",
                                @"picture":@"maradona.jpg"}
                        },
                      @{@"id": @"4",
                        @"title": @"Robo de bolso 2",
                        @"datetime": [NSDate date],
                        @"description": @"Me robaron el bolso mientras caminaba, 2 personas",
                        @"location":@{@"lat":@"-33.29466447030427",@"lon":@"-66.32148697972298"},
                        @"affected": @"2",
                        @"isTrue": @"2",
                        @"isntTrue": @"0",
                        @"pictures": @[@"picture_example.png"],
                        @"tags":@[@"robo,asalto"],
                        @"isAnonymous": [NSNumber numberWithBool:YES],
                        @"user":@{
                                @"id":@"98",
                                @"username":@"James Bond",
                                @"picture":@"bond.jpg"}
                        },
                      @{@"id": @"4",
                        @"title": @"Abusador",
                        @"datetime": [NSDate date],
                        @"description": @"Me atraco un tipo y me empezo a hablar incoherencias",
                        @"location":@{@"lat":@"-33.2957712",@"lon":@"-66.3324587"},
                        @"affected": @"2",
                        @"isTrue": @"2",
                        @"isntTrue": @"0",
                        @"pictures": @[],
                        @"tags":@[@"abusador",@"violacion",@"droga"],
                        @"isAnonymous": [NSNumber numberWithBool:NO],
                        @"user":@{
                                @"id":@"44",
                                @"username":@"Juan Felippo",
                                @"picture":@"juan.jpg"}
                        },
                      @{@"id": @"4",
                        @"title": @"Venta de droga",
                        @"datetime": [NSDate date],
                        @"description": @"todo villavo sabe que en el barrio popular esta la olla mas peligrosa de la ciudad y la policia no hace nada",
                        @"location":@{@"lat":@"-33.3029809",@"lon":@"-66.3353769"},
                        @"affected": @"2",
                        @"isTrue": @"2",
                        @"isntTrue": @"0",
                        @"pictures": @[],
                        @"tags":@[@"violacion",@"droga"],
                        @"isAnonymous": [NSNumber numberWithBool:NO],
                        @"user":@{
                                @"id":@"77",
                                @"username":@"Alberto Rodriguez",
                                @"picture":@"alberto.jpg"}
                        },
                      @{@"id": @"4",
                        @"title": @"Durante el paso de la Avenida...",
                        @"datetime": [NSDate date],
                        @"description": @"Durante el paso de la Avenida Caracas a la Calle 80, cuando pasa por debajo de la via del Tren que va hacia el norte.",
                        @"location":@{@"lat":@"-33.3094189",@"lon":@"-66.3368575"},
                        @"affected": @"2",
                        @"isTrue": @"2",
                        @"isntTrue": @"0",
                        @"pictures": @[],
                        @"tags":@[@"abusador",@"violacion",@"droga"],
                        @"isAnonymous": [NSNumber numberWithBool:YES],
                        @"user":@{
                                @"id":@"33",
                                @"username":@"Cristina K",
                                @"picture":@"kkk.jpg"}
                        },
                      @{@"id": @"4",
                        @"title": @"Invasion espacio publico",
                        @"datetime": [NSDate date],
                        @"description": @"Un señor se toma el derecho de la calle como parqueador privado en una via publica. El no tiene derecho de cobrarle a las personas",
                        @"location":@{@"lat":@"-33.3094189",@"lon":@"-66.3368575"},
                        @"affected": @"2",
                        @"isTrue": @"2",
                        @"isntTrue": @"0",
                        @"pictures": @[],
                        @"tags":@[@"abusador",@"violacion",@"droga"],
                        @"isAnonymous": [NSNumber numberWithBool:NO],
                        @"user":@{
                                @"id":@"76",
                                @"username":@"Edgar Glellel",
                                @"picture":@"turco.jpg"}
                        },
                      @{@"id": @"4",
                        @"title": @"Abusador",
                        @"datetime": [NSDate date],
                        @"description": @"Me atraco un tipo y me empezo a hablar incoherencias",
                        @"location":@{@"lat":@"-33.263347",@"lon":@"-66.3089089"},
                        @"affected": @"2",
                        @"isTrue": @"2",
                        @"isntTrue": @"0",
                        @"pictures": @[],
                        @"tags":@[@"abusador",@"violacion",@"droga"],
                        @"isAnonymous": [NSNumber numberWithBool:NO],
                        @"user":@{
                                @"id":@"44",
                                @"username":@"Juan Felippo",
                                @"picture":@"juan.jpg"}
                        }
                      
                      ];
    return data;
}

+ (NSArray*) getTimeFilterData
{
    NSArray* data = @[
                      @{@"title": NSLocalizedString(@"Today", @"Today")},
                      @{@"title": NSLocalizedString(@"Last Week", @"Last Week")},
                      @{@"title": NSLocalizedString(@"Last Month", @"Last Month")},
                      @{@"title": NSLocalizedString(@"All", @"All")},
                      ];
    return data;
}

+ (NSArray*) getCategoryFilterData
{
    NSArray* data = @[
                      [[CategoryFilter alloc] initWithData:@{@"id": @"1",@"name": @"Delitos electorales"}],
                      [[CategoryFilter alloc] initWithData:@{@"id": @"2",@"name": @"Hurtos"}],
                      [[CategoryFilter alloc] initWithData:@{@"id": @"3",@"name": @"Venta de artículos ilegales"}],
                      [[CategoryFilter alloc] initWithData:@{@"id": @"4",@"name": @"Espacios inseguros"}],
                      [[CategoryFilter alloc] initWithData:@{@"id": @"5",@"name": @"Perturbación al orden público y a la tranquilidad"}],
                      [[CategoryFilter alloc] initWithData:@{@"id": @"6",@"name": @"Violencia"}],
                      [[CategoryFilter alloc] initWithData:@{@"id": @"7",@"name": @"Armas"}],
                      [[CategoryFilter alloc] initWithData:@{@"id": @"8",@"name": @"Homicidio"}],
                      [[CategoryFilter alloc] initWithData:@{@"id": @"9",@"name": @"Menores de edad"}],
                      [[CategoryFilter alloc] initWithData:@{@"id": @"10",@"name": @"Terrorismo"}],
                      [[CategoryFilter alloc] initWithData:@{@"id": @"12",@"name": @"Grupos criminales"}],
                      [[CategoryFilter alloc] initWithData:@{@"id": @"13",@"name": @"Fraudes / Estafas"}],
                      [[CategoryFilter alloc] initWithData:@{@"id": @"14",@"name": @"Conductas antiecologicas"}],
                      [[CategoryFilter alloc] initWithData:@{@"id": @"15",@"name": @"Otros"}],
                      ];
    return data;
}


/*
 Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.Lorem ipsum dolor sit er elit lamet,
 */

+ (NSArray*) getCommentsData{
    
    NSArray* data = @[
                      [[Comment alloc] initWithData:@{@"id":@"13",
                                                      @"text":@"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                                                      @"user":@{@"id":@"44",
                                                                @"username":@"James Bond",
                                                                @"picture":@"bond.jpg"}}],
                      [[Comment alloc] initWithData:@{@"id":@"13",
                                                      @"text":@"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu",
                                                      @"user":@{@"id":@"44",
                                                                @"username":@"Juan Felippo",
                                                                @"picture":@"juan.jpg"}}],
                      [[Comment alloc] initWithData:@{@"id":@"13",
                                                      @"text":@"Ut enim ad minim veniam, quis nostrud",
                                                      @"user":@{@"id":@"44",
                                                                @"username":@"He Man",
                                                                @"picture":@"heman.png"}}],
                      [[Comment alloc] initWithData:@{@"id":@"13",
                                                      @"text":@"Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.Lorem ipsum dolor sit er elit lamet",
                                                      @"user":@{@"id":@"44",
                                                                @"username":@"Cristina K",
                                                                @"picture":@"kkk.jpg"}}],
                      [[Comment alloc] initWithData:@{@"id":@"13",
                                                      @"text":@"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.Lorem ipsum dolor sit er elit lamet",
                                                      @"user":@{@"id":@"44",
                                                                @"username":@"Diego Maradona",
                                                                @"picture":@"maradona.jpg"}}],
                      [[Comment alloc] initWithData:@{@"id":@"13",
                                                      @"text":@"consectetaur cillium adipisicing pecu",
                                                      @"user":@{@"id":@"44",
                                                                @"username":@"Mr T.",
                                                                @"picture":@"mrT.png"}}],
                      [[Comment alloc] initWithData:@{@"id":@"13",
                                                      @"text":@"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                                                      @"user":@{@"id":@"44",
                                                                @"username":@"Edgar Glellel",
                                                                @"picture":@"turco.jpg"}}],
                      [[Comment alloc] initWithData:@{@"id":@"13",
                                                      @"text":@"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
                                                      @"user":@{@"id":@"44",
                                                                @"username":@"Juan Felippo",
                                                                @"picture":@"juan.jpg"}}],
                      ];
    return data;
}

@end
