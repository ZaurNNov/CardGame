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

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;

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

-(Card *)cardAtindex: (NSUInteger)index
{
        //    return self.cards[index];
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

-(void) chooseCardAtIndex: (NSUInteger) index
{
    Card *card = [self cardAtindex:index];
    
    if (!card.isMatched) {
        
        //if card choosen - set it not choosed!
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            //match against other choosen cards
            for (Card *otherCard in self.cards) {
                
                if (otherCard.isChosen && !otherCard.isMatched) {
                    //cost for flipping
                    int matchScore = [card match:@[otherCard]];
                    
                    if (matchScore) {
                        self.score += matchScore * MATCH_BONUS;
                        otherCard.matched = YES;
                        card.matched = YES;
                    } else {
                        self.score -= MISMATCH_PENALTY;
                        otherCard.chosen = NO;
                    }
                    break; //can only choose 2 cards for now
                }
            }
            
            card.chosen = YES;
        }
        
    }
    
    
    
}




@end
