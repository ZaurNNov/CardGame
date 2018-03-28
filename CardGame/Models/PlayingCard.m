//
//  PlayingCard.m
//  CardGame
//
//  Created by A1 on 28.03.2018.
//  Copyright © 2018 Home. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

@synthesize suit = _suit;

-(NSString *)suit
{
    return _suit ? _suit : @"?";
}

-(void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

-(void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

+(NSArray *) validSuits
{
    return @[@"♥️", @"♦️", @"♠️", @"♣️"];
}

+(NSUInteger) maxRank
{
   return [[self rankStrings] count]-1;
}

+(NSArray *)rankStrings
{
    return  @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

-(NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

-(int)match:(NSArray *)otherCards
{
    int score = 0;
    int numMatches = 0;
    if ([otherCards count] > 0) {
        for (int i = 0; i < [otherCards count]; i++) {
            id otherCard1 = otherCards[i];
            
            if ([otherCard1 isKindOfClass:[PlayingCard class]]) {
                PlayingCard *card1 = (PlayingCard *)otherCard1;
                
                for (int j = i+1; j < [otherCards count]; j++) {
                    id otherCard2 =otherCards[j];
                    
                    if ([otherCard2 isKindOfClass:[PlayingCard class]]) {
                        PlayingCard *card2 =(PlayingCard *)otherCard2;
                            // check for the same suit
                        if ([card1.suit isEqualToString:card2.suit]) {
                            score += 1;
                            numMatches++;
                        }
                            // check for the same rank
                        if (card1.rank == card2.rank) {
                            score += 4;
                            numMatches++;
                        }
                    }
                }
            }
        }
        
        if (numMatches < [otherCards count] -1)
            score = 0;
    }
    return score;
}

@end
