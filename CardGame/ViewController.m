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
@property (weak, nonatomic) IBOutlet UISegmentedControl *numberOfMatchesSegmentControl;
@property (weak, nonatomic) IBOutlet UILabel *resultDescriptionLabel;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardsButtons;

@end

@implementation ViewController

static const int MINIMUM_MATCH_COUNT = 2;

//Models
-(Deck *) createDeck
{
    return [[PlayingCardDeck alloc]init];
}

//lazy init for game
-(CardMatchingGame *) game
{
    if (!_game) _game = [[CardMatchingGame alloc]initWithCardCount:[self.cardsButtons count]
                                                         usingDeck:[self createDeck]];
    _game.numberOfMatchesSwich = [self numberOfMatchesSwich];
    return _game;
}

//UI action
-(void) updateUI
{
    for (UIButton *cardButton in self.cardsButtons) {
        NSUInteger cardButtonIndex = [self.cardsButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtindex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
    }
    [self updateResultDescription];
}

//helpers
-(void)updateResultDescription
{
    NSString *text= @" ";
    if ([self.game.descriptionMatchedCards  count] > 0) {
        text = [text stringByAppendingString:
                [self.game.descriptionMatchedCards componentsJoinedByString:@" "]];
        if ([self.game.descriptionMatchedCards count] == [self numberOfMatchesSwich]) {
            if (self.game.descriptionLastFlipPoints < 0) {
                text = [text stringByAppendingString:[NSString stringWithFormat:
                        @"✘ %d penalty", (int)self.game.descriptionLastFlipPoints]];
            } else {
                text = [text stringByAppendingString:[NSString stringWithFormat:
                        @"✔ +%d bonus", (int)self.game.descriptionLastFlipPoints]];
            }
        } else text = [self textForSingleCard];
    } else text = @"Play game!";
    self.resultDescriptionLabel.text = text;
}

- (NSString *)textForSingleCard
{
    Card *card = [self.game.descriptionMatchedCards lastObject];
    return [NSString stringWithFormat:@"%@ flipped %@", card, (card.isChosen) ? @"up!" : @"back!"];
}

-(NSString *)titleForCard: (Card *)card
{
    return card.isChosen ? card.contents : @"";
}

-(UIImage *)backgroundImageForCard: (Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

-(void)resetGame
{
    [self segmetControlEnabled];
    self.game = nil;
    [self updateUI];
}

-(NSUInteger)numberOfMatchesSwich
{
    return self.numberOfMatchesSegmentControl.selectedSegmentIndex + MINIMUM_MATCH_COUNT;
}

-(void)segmetControlEnabled
{
    self.numberOfMatchesSegmentControl.enabled = YES;
}

-(void)segmetControlDisabled
{
    self.numberOfMatchesSegmentControl.enabled = NO;
}

// MARK: Actions
- (IBAction)dealAction:(UIButton *)sender {
    [self resetGame];
}


- (IBAction)touchCardButton:(UIButton *)sender
{
    [self segmetControlDisabled];
    NSUInteger chooseCardButtonIndex = [self.cardsButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chooseCardButtonIndex];
    [self updateUI];
}

- (IBAction)matchChangesSegmentControlAction:(UISegmentedControl *)sender {
    [self resetGame];
}

@end
