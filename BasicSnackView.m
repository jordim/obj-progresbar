//
//  BasicSnackView.m
//
//  Created by jordim on 16/7/18.
//

#import "BasicSnackView.h"

@implementation BasicSnackView
    
+ (instancetype) duration:(int) duration animation:(BOOL) animation toView:(UIView *) superview {
    
    BasicSnackView *hud = [[self alloc] initWithFrame:superview.frame];
    hud.backgroundColor = [UIColor lightGrayColor];
    hud.duration = duration;
    hud.animation = animation;
    hud.paused = YES;
    [superview addSubview:hud];
    [hud setupViews:superview];
    
    return hud;
}

#pragma mark - Controls

- (void) play {
    
    if(!self.isPlaying) {
        self.paused = NO;
        NSDictionary *data = @{@"duration":@(self.duration)};
        self.timer_progres = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(updateProgressBar:) userInfo:data repeats: YES];
    }
}

- (void) pause {
    
    self.paused = YES;
    
    if(self.timer_progres != nil) {
        [self.timer_progres invalidate];
    }
}

- (BOOL) isPlaying {
    
    return self.paused == NO;
}

- (void) cancel {
    
    self.progres = 0;
    self.paused = YES;
    if(self.timer_progres != nil) {
        [self.timer_progres invalidate];
    }
}


- (void) close {
    
    if(self.animation) {
        [UIView animateKeyframesWithDuration:0.1
                                       delay:1.5
                                     options:UIViewKeyframeAnimationOptionCalculationModeLinear
                                  animations:^{
                                      self.alpha = 0;
                                  }
                                  completion:^(BOOL finished) {
                                      [self removeFromSuperview];
                                  }];
    } else {
        [self removeFromSuperview];
    }
}


#pragma mark - UX

- (void) setupViews:(UIView *) superview {
    
    self.bar = [[UIView alloc] initWithFrame:self.bounds];
    self.bar.translatesAutoresizingMaskIntoConstraints = NO;
    self.bar.backgroundColor = [UIColor blackColor];
    [self addSubview:self.bar];
    
    self.label_percentage = [[UILabel alloc] initWithFrame:CGRectZero];
    self.label_percentage.translatesAutoresizingMaskIntoConstraints = NO;
    self.label_percentage.text = @"0%";
    self.label_percentage.backgroundColor = [UIColor clearColor];
    self.label_percentage.font = [UIFont boldSystemFontOfSize:18];
    self.label_percentage.textColor = [UIColor whiteColor];
    [self addSubview:self.label_percentage];
    
    self.label_message = [[UILabel alloc] initWithFrame:CGRectZero];
    self.label_message.translatesAutoresizingMaskIntoConstraints = NO;
    self.label_message.numberOfLines = 0;
    self.label_message.font = [UIFont boldSystemFontOfSize:15];
    [self.label_message setAdjustsFontSizeToFitWidth:YES];
    self.label_message.textColor = [UIColor whiteColor];
    [self addSubview:self.label_message];

    [self buildConstraints:superview];
}

- (void) buildConstraints:(UIView *) superview {
    
    [self buildViewConstraints:superview];
    [self buildLabelPercentageConstraints];
    [self buildProgresBarConstraints];
    [self buildLabelMessageConstraints];
}

- (void) buildViewConstraints:(UIView *) superview {
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *self_width =[NSLayoutConstraint
                                     constraintWithItem:self
                                     attribute:NSLayoutAttributeWidth
                                     relatedBy:0
                                     toItem:superview
                                     attribute:NSLayoutAttributeWidth
                                     multiplier:1.0
                                     constant:0];
    
    self.constraint_bar_height = [NSLayoutConstraint constraintWithItem:self
                                                                   attribute:NSLayoutAttributeHeight
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:nil
                                                                   attribute:NSLayoutAttributeNotAnAttribute
                                                                  multiplier:1.0
                                                                    constant:44];
    
    NSLayoutConstraint *self_bottom = [NSLayoutConstraint constraintWithItem:self
                                                                   attribute:NSLayoutAttributeBottom
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:superview
                                                                   attribute:NSLayoutAttributeBottom
                                                                  multiplier:1.0f
                                                                    constant:0];
    
    NSLayoutConstraint *self_leading = [NSLayoutConstraint
                                        constraintWithItem:self
                                        attribute:NSLayoutAttributeLeading
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:superview
                                        attribute:NSLayoutAttributeLeading
                                        multiplier:1.0f
                                        constant:0.f];
    
    [superview addConstraint:self_width];
    [superview addConstraint:self.constraint_bar_height];
    [superview addConstraint:self_bottom];
    [superview addConstraint:self_leading];
}

- (void) buildLabelMessageConstraints {
    
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self.label_message
                                                              attribute:NSLayoutAttributeHeight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.label_percentage
                                                              attribute:NSLayoutAttributeHeight
                                                             multiplier:1.0
                                                               constant:0];
    
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self.label_message
                                                         attribute:NSLayoutAttributeWidth
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeWidth
                                                        multiplier:0.8
                                                          constant:0];
    
    
    NSLayoutConstraint *y = [NSLayoutConstraint constraintWithItem:self.label_message
                                                         attribute:NSLayoutAttributeCenterY
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeCenterY
                                                        multiplier:1.0f
                                                          constant:0];
    
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:self.label_message
                                                                      attribute:NSLayoutAttributeLeading
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self
                                                                      attribute:NSLayoutAttributeLeading
                                                                     multiplier:1.0f
                                                                       constant:10];
    
    [self addConstraint:height];
    [self addConstraint:width];
    [self addConstraint:y];
    [self addConstraint:leading];
}


- (void) buildProgresBarConstraints {
    
    self.constraint_progresbar_height = [NSLayoutConstraint constraintWithItem:self.bar
                                                                   attribute:NSLayoutAttributeHeight
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:nil
                                                                   attribute:NSLayoutAttributeNotAnAttribute
                                                                  multiplier:1.0
                                                                    constant:5];
    
    
    
    NSLayoutConstraint *y = [NSLayoutConstraint constraintWithItem:self.bar
                                                              attribute:NSLayoutAttributeTop
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self
                                                              attribute:NSLayoutAttributeTop
                                                             multiplier:1.0
                                                               constant:0];
    
    
    [self.bar addConstraint:self.constraint_progresbar_height];
    [self addConstraint:y];
    
    self.constraint_width = [NSLayoutConstraint constraintWithItem:self.bar
                                                         attribute:NSLayoutAttributeWidth
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeWidth
                                                        multiplier:0
                                                          constant:0];
    
    
    self.constraint_width.constant = 0;
    [self addConstraint:self.constraint_width];
}

- (void) buildLabelPercentageConstraints {
    
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self.label_percentage
                                                                    attribute:NSLayoutAttributeHeight
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self
                                                                    attribute:NSLayoutAttributeHeight
                                                                   multiplier:0.7
                                                                     constant:0];
    
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self.label_percentage
                                                                   attribute:NSLayoutAttributeWidth
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:nil
                                                                   attribute:NSLayoutAttributeNotAnAttribute
                                                                  multiplier:1.0
                                                                    constant:50];
    
    
    
    NSLayoutConstraint *center = [NSLayoutConstraint constraintWithItem:self
                                                                    attribute:NSLayoutAttributeCenterY
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self.label_percentage
                                                                    attribute:NSLayoutAttributeCenterY
                                                                   multiplier:1.0f
                                                                     constant:0];
    
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:self.label_percentage
                                                                      attribute:NSLayoutAttributeTrailing
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self
                                                                      attribute:NSLayoutAttributeTrailing
                                                                     multiplier:1.0f
                                                                       constant:-10];
    
    [self.label_percentage addConstraint:width];
    [self addConstraint:height];
    [self addConstraint:center];
    [self addConstraint:trailing];
}

#pragma mark - Elements

- (void) hideMessage:(BOOL) message {
    
    self.label_message.hidden = message;
}
- (void) hidePercentage:(BOOL) percentage  {
    
    self.label_percentage.hidden = percentage;
}

- (void) setMessage:(NSString *) message {
    
    if(self.label_message != nil) {
        self.label_message.text = message;
    }
}

#pragma mark - Bar

- (void) setBarHeight:(int) height {
    
    self.constraint_bar_height.constant = height;
}

- (void) setProgresBarHeight:(int) height {
    
    if(height > self.constraint_bar_height.constant) {
        height = self.constraint_bar_height.constant / 4;
    }
    self.constraint_progresbar_height.constant = height;
}

- (void) percentageColor:(UIColor *) color {
    
    self.label_percentage.textColor = color;
}

- (void) messageColor:(UIColor *) color {
    
    self.label_message.textColor = color;
}

- (void) changeBackgroundColor:(UIColor *) color {
    
    self.backgroundColor = color;
}
- (void) changeBarColor:(UIColor *) color {
    
    if(self.bar != nil) {
        self.bar.backgroundColor = color;
    }
}

- (void) setBarProgres:(float) progres {
    
    if(self.constraint_width != nil) {
        if(progres > 100.0f) {
            progres = 100.0f;
        }
        float width = self.bounds.size.width;
        self.constraint_width.constant = (progres/100)*width;
    }
}

- (void) setBarAlpha:(float) alpha {
    
    if(alpha < 0) alpha = 0;
    if(alpha > 1) alpha = 1;
    self.alpha = alpha;
}
- (void) setProgresBarAlpha:(float) alpha {
    
    if(alpha < 0) alpha = 0;
    if(alpha > 1) alpha = 1;
    self.bar.alpha = alpha;
}

- (void) updateProgressBar:(NSTimer *) sender {
    
    NSDictionary *data = sender.userInfo;
    int duration = [[data objectForKey:@"duration"] intValue];
    
    float background_width = self.frame.size.width;
    
    self.progres = (background_width/duration) / 100;
    
    if(self.constraint_width.constant + self.progres > background_width) {
        self.constraint_width.constant = background_width;
    } else {
        self.constraint_width.constant += self.progres;
    }
    [UIView animateWithDuration:1 animations:^{
        float factor = self.constraint_width.constant / background_width;
        int percentage = factor * 100;
        self.label_percentage.text = [NSString stringWithFormat:@"%i%%",percentage];
        if(factor >= 1) {
            [self close];
            [self.timer_progres invalidate];
        }
        [self.bar layoutIfNeeded];
    }];
}

#pragma mark - Lifecycle


- (instancetype)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {

    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {

    }
    return self;
}

- (id)initWithView:(UIView *)view {
    NSAssert(view, @"View must not be nil.");
    return [self initWithFrame:view.bounds];
}

@end
