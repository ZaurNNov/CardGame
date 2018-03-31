//
//  CardMatchingGame.h
//  CardGame
//
//  Created by A1 on 31.03.2018.
//  Copyright © 2018 Home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

-(instancetype)initWithCardCount: (NSUInteger) count usingDeck: (Deck *)deck;
-(void) chooseCardAtIndex: (NSUInteger) index;
-(Card *)cardAtindex: (NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic) NSUInteger numberOfMatchesSwich;

@property (nonatomic, strong) NSArray *descriptionMatchedCards;
@property (nonatomic, readonly) NSInteger descriptionLastFlipPoints;

@end
