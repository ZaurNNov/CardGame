//
//  Deck.h
//  CardGame
//
//  Created by A1 on 31.03.2018.
//  Copyright © 2018 Home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

-(void)addCard:(Card* )card atTop:(BOOL) atTop;
-(void)addCard:(Card *)card;
-(Card *) drawRandomCard;

@end
