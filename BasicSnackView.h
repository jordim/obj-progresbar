//
//  BasicSnackView.h
//
//  Created by jordim on 16/7/18.
//

#import <UIKit/UIKit.h>

@interface BasicSnackView : UIView

@property(nonatomic, strong) NSTimer *timer_progres;
@property(nonatomic, strong) NSLayoutConstraint *constraint_width;
@property(nonatomic, strong) NSLayoutConstraint *constraint_bar_height;
@property(nonatomic, strong) NSLayoutConstraint *constraint_progresbar_height;

@property(nonatomic, strong) UIView *bar;
@property(nonatomic, strong) UIView *label;

@property(nonatomic, strong) UILabel *label_percentage;
@property(nonatomic, strong) UILabel *label_message;

@property (assign, nonatomic) int duration; 
@property (assign, nonatomic) float progres;
@property (assign, nonatomic) BOOL paused;
@property (assign, nonatomic) BOOL autoplay;
@property (assign, nonatomic) BOOL animation;

+ (instancetype) duration:(int) duration animation:(BOOL) animation toView:(UIView *) superview;

- (void) play;
- (void) pause;
- (void) close;

- (void) changeBackgroundColor:(UIColor *) color;
- (void) changeBarColor:(UIColor *) color;
- (void) percentageColor:(UIColor *) color;
- (void) messageColor:(UIColor *) color;
- (void) setMessage:(NSString *) message;
- (void) setBarProgres:(float) progres;
- (void) setBarHeight:(int) height;
- (void) setProgresBarHeight:(int) height;

- (void) hideMessage:(BOOL) message;
- (void) hidePercentage:(BOOL) percentage;

@end
