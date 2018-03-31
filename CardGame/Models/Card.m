//
//  Card.m
//  CardGame
//
//  Created by A1 on 28.03.2018.
//  Copyright © 2018 Home. All rights reserved.
//

#import "Card.h"

@implementation Card

-(int)match:(NSArray *)otherCards
{
    int score = 0;
    
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    
    return score;
}

-(NSString *)description
{
    return self.contents;
}

@end
