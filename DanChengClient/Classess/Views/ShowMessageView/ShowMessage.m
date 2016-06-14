//
//  ShowMessage.m
//  影讯
//
//  Created by 高 on 14-6-10.
//  Copyright (c) 2014年 罗 何. All rights reserved.
//

#import "ShowMessage.h"
#import "AppDelegate.h"

#define  kTimeOut   2.0f
#define  kViewMaxHeight 200.0f
#define  kViewTag 917996690

@interface ShowMessage()

@property (nonatomic, copy) NSString    *message;
@property (nonatomic,strong)UIView      *progressView;

@end


@implementation ShowMessage

static ShowMessage *instance = nil;
+ (ShowMessage *)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (nil == instance){
            instance = [[ShowMessage alloc] init];
        }
    });
    return instance;
}

- (id)init {
    if (instance == nil)
    {
        if (self = [super init]) {
            [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:.7f]];
            [self.layer setMasksToBounds:YES];
            [self.layer setCornerRadius:4.0f];
            [self.layer setBorderWidth:1.0f];
            [self.layer setBorderColor:[UIColor colorWithRed:0.86f green:0.86f blue:0.86f alpha:.7f].CGColor];
            [self setTag:kViewTag];
            instance = self;
        }
    }
    return instance;
}

- (id)initPro
{
    if (self = [super init]) {
    
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {

    }
    return self;
}


- (void)showProgress:(UIView*)view
{
    if (nil!=self) {
        self.backgroundColor = [UIColor whiteColor];
        CGRect frame = view.frame;
        frame.origin.y = kNavagationBarH;
        self.frame = frame;
        [view addSubview:self];
        [self showProgress];
    }
}

- (void)showTableViewProgress:(UIView *)TableView
{
    if (nil!=self) {
        self.backgroundColor = [UIColor whiteColor];
        self.frame = TableView.bounds;
        [TableView addSubview:self];
        [self showProgress];
    }
}

- (void)showSoonViewProgress:(UIView *)view
{
    if (nil!=self) {
        self.backgroundColor = [UIColor whiteColor];
        CGRect frame = view.frame;
        frame.origin.y = HEAD_HEIGTH+KHEAD_ORIGN;
        frame.origin.x += view.frame.size.width;
        self.frame = frame;
        [view addSubview:self];
        [self showProgress];
    }
}

- (void)hideProgress
{
    if (nil!=self) {
        
        [self removeFromSuperview];
        [self unobserveNotification:UIApplicationDidBecomeActiveNotification];
    }
}

- (void)showProgress
{
    UIImage *waitImg =[ UIImage imageNamed:@"Refresh_icn"];
    CALayer *imgeLayer =[ CALayer layer];
    imgeLayer.name = @"turnLayer";
    [imgeLayer setContentsScale:[UIScreen mainScreen].scale];
    [imgeLayer setBackgroundColor:[UIColor clearColor].CGColor];
    [imgeLayer setPosition:CGPointMake(90, self.frame.size.height/2 - 44.0f+2)];
    [imgeLayer setBounds:CGRectMake(0, 0, waitImg.size.width, waitImg.size.height)];
    [imgeLayer setContents:(id)waitImg.CGImage];
    [self.layer addSublayer:imgeLayer];
    
    CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //kCAMediaTimingFunctionLinear 表示时间方法为线性，使得足球匀速转动
    rotation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    rotation.toValue = [NSNumber numberWithFloat:4 * M_PI];
    rotation.duration = 2;
    rotation.repeatCount = HUGE_VALF;
    [imgeLayer addAnimation:rotation forKey:@"rotation"];
    
    CATextLayer  *textLayer = [CATextLayer layer];
    [textLayer setContentsScale:[UIScreen mainScreen].scale];
    [textLayer setForegroundColor:[UIColor grayColor].CGColor];
    [textLayer setFontSize:13.0f];
    [textLayer setFrame:CGRectMake(110.0f, imgeLayer.frame.origin.y+3 , self.frame.size.width - 120, 25.0f)];
    [textLayer setString:@"loading...."];
    [self.layer addSublayer:textLayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appBecomeActive:)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
}

- (void)startTurn
{
    for (CALayer *layer in self.layer.sublayers)
    {
        if ([layer.name isEqualToString:@"turnLayer"])
        {
            CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
            //kCAMediaTimingFunctionLinear 表示时间方法为线性，使得足球匀速转动
            rotation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
            rotation.toValue = [NSNumber numberWithFloat:4 * M_PI];
            rotation.duration = 2;
            rotation.repeatCount = HUGE_VALF;
            [layer addAnimation:rotation forKey:@"rotation"];
        }
    }
}

- (void)appBecomeActive:(NSNotification*)note
{
    if (nil!=self)
    {
        [self startTurn];
    }
}

- (void)dealloc
{
    [self unobserveAllNotification];
    self.message = nil;
    [self removeFromSuperview];
}


+ (CGRect)tipsViewRectWithMessage:(NSString *)message font:(UIFont *)font maxWidth:(CGFloat)maxWidth padding:(UIEdgeInsets)padding {
    CGSize constrainedToSize = CGSizeMake(maxWidth-padding.left-padding.right, kViewMaxHeight-padding.top-padding.bottom);
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,nil];
    CGSize size = CGSizeZero;
    if (IOS7)
    {
        size = [message boundingRectWithSize:constrainedToSize
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:tdic
                                     context:nil].size;
    }
    else
    {
        size = [message sizeWithFont:font constrainedToSize:constrainedToSize lineBreakMode:NSLineBreakByCharWrapping];
    }
    
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    
    CGFloat height = size.height + padding.top + padding.bottom;
    CGFloat width = size.width + padding.left + padding.right;
    CGFloat x = (screenBounds.size.width - width) / 2;
    CGFloat y = 4*(screenBounds.size.height - height)/5;
    
    return CGRectMake(x, y, width, height);
}


+(void)dismissshow
{
    [[ShowMessage sharedInstance] dismissshow];
}

- (void)dismissshow {
    [UIView animateWithDuration:.2f animations:^{
        [self setAlpha:0.0f];
        [self setBounds:CGRectMake(0, 0, 0, 0)];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)setMessage:(NSString *)message {
    if (_message != message)
    {
        _message = [message copy];
        [self setNeedsDisplay];
    }
}


+(void)showMessage:(NSString *)message
{
//    [self showMessage:message selector:nil dismissAfterDelay:kTimeOut];
    [ShowMessage showMessage:message selector:nil dismissAfterDelay:kTimeOut];
}

+ (void)showMessage:(NSString *)message selector:(void(^)(void))selector dismissAfterDelay:(NSTimeInterval)delay
{
    
    [[ShowMessage sharedInstance]showMessage:message selector:selector dismissAfterDelay:delay];
}

- (void)showMessage:(NSString *)message selector:(void(^)(void))selector dismissAfterDelay:(NSTimeInterval)delay{
    if (![message isKindOfClass:[NSString class]]) {
        return;
    }
    
    if (delay <= 0) {
        delay = kTimeOut;
    }
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dismissshow) object:nil];
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    CGRect frame = [ShowMessage tipsViewRectWithMessage:message
                                                   font:[UIFont systemFontOfSize:14.0]
                                               maxWidth:300
                                                padding:UIEdgeInsetsMake(5.0f, 5.0f, 5.0f, 5.0f)];
    
    CGFloat pointX = CGRectGetMidX(frame);
    CGFloat pointY = CGRectGetMidY(frame);
    [self setCenter:CGPointMake(pointX, pointY)];
    
//    [UIView animateWithDuration:0.3f animations:^{
        [self setFrame:frame];
        [self setAlpha:1.0f];
//    }];
    
    UIWindow *keyboardWindow = nil;
    for (UIWindow *window in [[UIApplication sharedApplication] windows])
    {
        if (![NSStringFromClass([window class]) isEqualToString:NSStringFromClass([UIWindow class])])
        {
            keyboardWindow = window;
            break;
        }
    }
    if (keyboardWindow !=nil && ![keyboardWindow viewWithTag:kViewTag]) {
        [keyboardWindow addSubview:self];
        [keyboardWindow bringSubviewToFront:self];
    }else if(window != nil && ![window viewWithTag:kViewTag]) {
        
        [window addSubview:self];
        [window bringSubviewToFront:self];
        
    }
    
    [self setMessage:message];
    
    [self performSelector:@selector(dismissshow) withObject:nil afterDelay:delay];
}


- (CGFloat)maxWidth {
    return 300.0f;
}

- (UIEdgeInsets)padding {
    return UIEdgeInsetsMake(5.0f, 5.0f, 5.0f, 5.0f);
}

- (UIFont *)messageFont {
    return [UIFont systemFontOfSize:14.0f];
}

- (UIColor*)messageColour
{
    return [UIColor whiteColor];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    if (self.message) {
        CGFloat paddingTop = [self padding].top;
        CGFloat paddingBottom = [self padding].bottom;
        CGFloat paddingLeft = [self padding].left;
        CGFloat paddingRight = [self padding].right;
        
        CGRect viewRect = [self frame];
        CGFloat width = CGRectGetWidth(viewRect)-paddingLeft-paddingRight;
        CGFloat height = CGRectGetHeight(viewRect)-paddingTop-paddingBottom;
        
        CGRect drawRect = CGRectMake(paddingLeft, paddingTop, width, height);
        
        [UICOLOR_FROM_RGB(157, 157, 157)setFill];// 设置背景填充色
//        [[UIColor whiteColor] set];// 设置字符颜色
        if (IOS7)
        {
            NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:[self messageFont],NSFontAttributeName,[self messageColour],NSForegroundColorAttributeName,nil];
            [self.message drawWithRect:drawRect
                               options:NSStringDrawingUsesLineFragmentOrigin
                            attributes:tdic
                               context:nil];
        }
        else
        {
            [self.message drawInRect:drawRect
                            withFont:[self messageFont]
                       lineBreakMode:NSLineBreakByCharWrapping];
        }
    }
}


@end
