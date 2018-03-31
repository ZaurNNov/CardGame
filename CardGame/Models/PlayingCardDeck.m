//
//  PlayingCardDeck.m
//  CardGame
//
//  Created by A1 on 31.03.2018.
//  Copyright © 2018 Home. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck

-(instancetype)init
{
    self = [super init];
    
    if (self) {
        for (NSString *suit in [PlayingCard validSuits]) {
            PlayingCard *card = [[PlayingCard alloc]init];
            for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++) {
                card.rank = rank;
                card.suit = suit;
                [self addCard: card];
                card = nil;
            }
        }
    }
    
    return self;
}

@end
