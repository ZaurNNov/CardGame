//
//  ViewController.m
//  CardGame
//
//  Created by A1 on 28.03.2018.
//  Copyright © 2018 Home. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (nonatomic) Deck *deck;

//new model
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardsButtons;

@end

@implementation ViewController

//lazy init for game
-(CardMatchingGame *) game
{
    if (!_game) _game = [[CardMatchingGame alloc]initWithCardCount:[self.cardsButtons count]
                                                         usingDeck:[self createDeck]];
    return _game;
}

-(Deck *) createDeck
{
    return [[PlayingCardDeck alloc]init];
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    NSUInteger chooseCardButtonIndex = [self.cardsButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chooseCardButtonIndex];
    [self updateUI];
}

-(void) updateUI
{
    for (UIButton *cardButton in self.cardsButtons) {
        NSUInteger cardButtonIndex = [self.cardsButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtindex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    }
    
    
    
    
}

-(NSString *)titleForCard: (Card *)card
{
    return card.isChosen ? card.contents : @"";
}

-(UIImage *)backgroundImageForCard: (Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

@end
