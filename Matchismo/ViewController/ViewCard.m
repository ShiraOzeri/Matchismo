//
//  ViewCard.m
//  Matchismo
//
//  Created by Shira Ozeri on 12/11/2019.
//  Copyright © 2019 Shira Ozeri. All rights reserved.
//

#import "ViewCard.h"

@implementation ViewCard

#pragma mark - Properties
static const float kDefaultFaceCardScaleFactor = 0.90;

@synthesize faceCardScaleFactor = _faceCardScaleFactor;

- (CGFloat)faceCardScaleFactor {
  if (!_faceCardScaleFactor) {
    _faceCardScaleFactor = kDefaultFaceCardScaleFactor;
  }
  return _faceCardScaleFactor;
}

- (void)setFaceCardScaleFactor:(CGFloat)faceCardScaleFactor {
  _faceCardScaleFactor = faceCardScaleFactor;
  [self setNeedsDisplay];
}

- (void)setCard:(Card *)card {
  _card = [[Card alloc] initWithCard:card];
  [self setNeedsDisplay];
}

- (void)setFaceUp:(BOOL)faceUp {
  _faceUp = faceUp;
  [self setNeedsDisplay];
}

#pragma mark - Drawing

static const float kCornerFontStandaardHeight = 180;
static const float kCornerRadius = 12;

- (CGFloat)cornerScaleFactor {
  return self.bounds.size.height / kCornerFontStandaardHeight;
}
- (CGFloat)cornerRadius {
  return kCornerRadius * [self cornerScaleFactor];
}
- (CGFloat)cornerOffset {
  return [self cornerRadius] / 3.0;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
  // Drawing code
  UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];
  [roundedRect addClip];
  [[UIColor whiteColor] setFill];
  UIRectFill(self.bounds);
  [[UIColor blackColor] setStroke];
  [roundedRect stroke];
  if (self.faceUp) {
    [self displayFaceCard];
  } else {
    [[UIImage imageNamed:@"cardback"] drawInRect:self.bounds];
  }
}

- (void)displayFaceCard{
}

- (void)displayBackCard {
}

#pragma mark - Initialization

- (void)setup{
  self.backgroundColor = nil;
  self.opaque = NO;
  self.contentMode = UIViewContentModeRedraw;
}

- (void)awakeFromNib{
  [super awakeFromNib];
  [self setup];
}

- (id)initWithFrame:(CGRect)frame{
  self = [super initWithFrame:frame];
  [self setup];
  return self;
}

@end
