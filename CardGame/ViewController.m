//
//  ViewController.m
//  CardGame
//
//  Created by A1 on 28.03.2018.
//  Copyright © 2018 Home. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@end

@implementation ViewController

- (IBAction)touchCardButton:(UIButton *)sender
{
    if ([sender.currentTitle length]) {
        [sender setBackgroundImage:[UIImage imageNamed: @"cardback"]
                          forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
    } else {
        [sender setBackgroundImage:[UIImage imageNamed: @"cardfront"]
                          forState:UIControlStateNormal];
        [sender setTitle:@"A♣️" forState:UIControlStateNormal];
    }
    

}



@end
