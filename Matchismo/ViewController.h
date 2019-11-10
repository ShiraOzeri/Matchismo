//
//  ViewController.h
//  Matchismo
//
//  Created by Shira Ozeri on 28/10/2019.
//  Copyright © 2019 Shira Ozeri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "CardGame.h"

@interface ViewController : UIViewController

- (Deck *)createDeck;

@property (strong, nonatomic) CardGame *game;


@end

