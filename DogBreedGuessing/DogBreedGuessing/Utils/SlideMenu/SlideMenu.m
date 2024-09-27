//
//  SlideMenu.m
//  SlideMenu
//
//  Created by Leon on 2024/9/25.
//

#import "SlideMenu.h"

// Width percentage of screen for menu
static CGFloat MenuWidthScale = 0.8f;
static CGFloat MaxCoverAlpha = 0.3;
static CGFloat MinActionSpeed = 500;

@interface SlideMenu() <UIGestureRecognizerDelegate> {
    CGPoint _originalPoint;
}

@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, strong) UIPanGestureRecognizer *pan;

@end

@implementation SlideMenu

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super init]) {
        _rootViewController = rootViewController;
        [self addChildViewController:_rootViewController];
        [self.view addSubview:_rootViewController.view];
        [_rootViewController didMoveToParentViewController:self];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    _pan.delegate = self;
    [self.view addGestureRecognizer:_pan];
    
    _coverView = [[UIView alloc] initWithFrame:self.view.bounds];
    _coverView.backgroundColor = [UIColor blackColor];
    _coverView.alpha = 0;
    _coverView.hidden = true;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [_coverView addGestureRecognizer:tap];
    [_rootViewController.view addSubview:_coverView];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [self updateLeftMenuFrame];
}

// MARK: - Setter && Getter

- (void)setMenuViewController:(UIViewController *)menuViewController {
    _menuViewController = menuViewController;
    [self addChildViewController:_menuViewController];
    [self.view insertSubview:_menuViewController.view atIndex:0];
    [_menuViewController didMoveToParentViewController:self];
}

- (void)setSlideEnabled:(BOOL)slideEnabled {
    _pan.enabled = slideEnabled;
}

- (BOOL)slideEnabled {
    return _pan.isEnabled;
}

// MARK: - Gestures

- (void)pan:(UIPanGestureRecognizer*)pan {
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            _originalPoint = _rootViewController.view.center;
            break;
        case UIGestureRecognizerStateChanged:
            [self panChanged:pan];
            break;
        case UIGestureRecognizerStateEnded:
            [self panEnd:pan];
            break;
            
        default:
            break;
    }
}

-(void)panChanged:(UIPanGestureRecognizer*)pan{
    CGPoint translation = [pan translationInView:self.view];
    
    _rootViewController.view.center = CGPointMake(_originalPoint.x + translation.x, _originalPoint.y);
    
    if (!_menuViewController && CGRectGetMinX(_rootViewController.view.frame) >= 0) {
        _rootViewController.view.frame = self.view.bounds;
    }
    
    if (CGRectGetMinX(_rootViewController.view.frame) > self.menuWidth) {
        _rootViewController.view.center = CGPointMake(_rootViewController.view.bounds.size.width/2 + self.menuWidth, _rootViewController.view.center.y);
    }
    if (CGRectGetMaxX(_rootViewController.view.frame) < self.emptyWidth) {
        _rootViewController.view.center = CGPointMake(_rootViewController.view.bounds.size.width/2 - self.menuWidth, _rootViewController.view.center.y);
    }
    
    if (CGRectGetMinX(_rootViewController.view.frame) > 0) {
        [self updateLeftMenuFrame];
        
        _coverView.hidden = false;
        [_rootViewController.view bringSubviewToFront:_coverView];
        _coverView.alpha = CGRectGetMinX(_rootViewController.view.frame)/self.menuWidth * MaxCoverAlpha;
    }
}

- (void)panEnd:(UIPanGestureRecognizer*)pan {
    CGFloat speedX = [pan velocityInView:pan.view].x;
    if (ABS(speedX) > MinActionSpeed) {
        [self dealWithFastSliding:speedX];
        return;
    }
    
    if (CGRectGetMinX(_rootViewController.view.frame) > self.menuWidth / 2) {
        [self showMenuViewControllerAnimated:true];
    } else {
        [self showRootViewControllerAnimated:true];
    }
}

- (void)dealWithFastSliding:(CGFloat)speedX {
    BOOL swipeRight = speedX > 0;
    
    CGFloat roootX = CGRectGetMinX(_rootViewController.view.frame);
    if (swipeRight) {
        if (roootX > 0) {
            [self showMenuViewControllerAnimated:true];
        }else if (roootX < 0){
            [self showRootViewControllerAnimated:true];
        }
    }
    return;
}

// MARK: - PanDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([_rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)_rootViewController;
        if (navigationController.viewControllers.count > 1 && navigationController.interactivePopGestureRecognizer.enabled) {
            return NO;
        }
    }
    
    if ([_rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabbarController = (UITabBarController*)_rootViewController;
        UINavigationController *navigationController = tabbarController.selectedViewController;
        if ([navigationController isKindOfClass:[UINavigationController class]]) {
            if (navigationController.viewControllers.count > 1 && navigationController.interactivePopGestureRecognizer.enabled) {
                return NO;
            }
        }
    }
    
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        CGFloat actionWidth = [self emptyWidth];
        CGPoint point = [touch locationInView:gestureRecognizer.view];
        if (point.x <= actionWidth || point.x > self.view.bounds.size.width - actionWidth) {
            return YES;
        } else {
            return NO;
        }
    }
    return YES;
}

- (void)tap {
    [self showRootViewControllerAnimated:true];
}

// MARK: - Show / Hide

- (void)showRootViewControllerAnimated:(BOOL)animated {
    __weak typeof (self) weakSelf = self;
    [UIView animateWithDuration:[self animationDurationAnimated:animated] animations:^{
        CGRect frame = weakSelf.rootViewController.view.frame;
        frame.origin.x = 0;
        weakSelf.rootViewController.view.frame = frame;
        [weakSelf updateLeftMenuFrame];
        weakSelf.coverView.alpha = 0;
    } completion:^(BOOL finished) {
        weakSelf.coverView.hidden = true;
    }];
}

- (void)showMenuViewControllerAnimated:(BOOL)animated {
    if (!_menuViewController) { return; }
    _coverView.hidden = false;
    [_rootViewController.view bringSubviewToFront:_coverView];
    __weak typeof (self) weakSelf = self;
    [UIView animateWithDuration:[self animationDurationAnimated:animated] animations:^{
        weakSelf.rootViewController.view.center = CGPointMake(weakSelf.rootViewController.view.bounds.size.width / 2 + weakSelf.menuWidth, weakSelf.rootViewController.view.center.y);
        weakSelf.menuViewController.view.frame = CGRectMake(0, 0, [weakSelf menuWidth], weakSelf.view.bounds.size.height);
        weakSelf.coverView.alpha = MaxCoverAlpha;
    }];
}

// MARK: - Others

- (void)updateLeftMenuFrame {
    _menuViewController.view.center = CGPointMake(CGRectGetMinX(_rootViewController.view.frame) / 2, _menuViewController.view.center.y);
}

- (CGFloat)menuWidth {
    return MenuWidthScale * self.view.bounds.size.width;
}

- (CGFloat)emptyWidth {
    return self.view.bounds.size.width - self.menuWidth;
}

- (CGFloat)animationDurationAnimated:(BOOL)animated {
    return animated ? 0.25 : 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
