//
//  CardMatchingGame.m
//  CardGame
//
//  Created by A1 on 31.03.2018.
//  Copyright © 2018 Home. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; //of Card

@end

@implementation CardMatchingGame

//lazy init
-(NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc]init];
    return _cards;
}

-(instancetype)initWithCardCount: (NSUInteger) count usingDeck: (Deck *)deck
{
    self = [super init];
    
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
            
        }
    }
    
    return self;
}

-(void) chooseCardAtIndex: (NSUInteger) index
{
    
}

-(Card *)cardAtindex: (NSUInteger)index
{
    return self.cards[index];
}


@end
