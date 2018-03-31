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
@property (nonatomic, strong) NSMutableArray *faceUpCards;

@end

@implementation CardMatchingGame

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int MINIMUM_MATCH_COUNT = 2;
static const int COST_TO_CHOOSE = 1;


//lazy init
-(NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc]init];
    return _cards;
}

-(void)setNumberOfMatchesSwich:(NSUInteger)numberOfMatchesSwich
{
    _numberOfMatchesSwich = numberOfMatchesSwich >= MINIMUM_MATCH_COUNT ? numberOfMatchesSwich : MINIMUM_MATCH_COUNT;
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
    // return self.cards[index];
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
            
            
            self.faceUpCards = [[NSMutableArray alloc]initWithArray:@[card]];
                //match against other choosen cards
            for (Card *otherCard in self.cards) {
                
                if (otherCard.isChosen && !otherCard.isMatched) {
                    [self.faceUpCards insertObject:otherCard atIndex:0];
                    
                    if ([self.faceUpCards count] == (self.numberOfMatchesSwich)) {
                        int matchScore = [card match:self.faceUpCards];
                        if (matchScore) {
                            self.score += matchScore * MATCH_BONUS;
                            for (Card *faceUpCard in self.faceUpCards) {
                                faceUpCard.matched =YES;
                            }
                            
                        } else {
                            self.score -= MISMATCH_PENALTY;
                            for (Card *faceUpCard in self.faceUpCards) {
                                if (faceUpCard != card) faceUpCard.chosen = NO;
                            }
                        }
                        break;
                    }
                }
            }
                card.chosen = YES;
                self.score -= COST_TO_CHOOSE;
            }
        }
    }



@end
