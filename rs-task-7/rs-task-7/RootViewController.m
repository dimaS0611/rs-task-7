//
//  RootViewController.m
//  rs-task-7
//
//  Created by Dzmitry Semenovich on 4.07.21.
//

#import "RootViewController.h"

@interface RootViewController () <UITextFieldDelegate>

@property (weak, nonatomic) NSString * username;
@property (weak, nonatomic) NSString * password;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.username = @"username";
    self.password = @"password";
    
    self.usernameTextField.delegate = self;
    self.passwordTextField.delegate = self;
    
    [self.secureView setHidden:YES];
    [self.secureView setUserInteractionEnabled: NO];
    
    [[self.usernameTextField layer] setBorderColor: [UIColor colorNamed:@"BlackCoral"].CGColor];
    [[self.passwordTextField layer] setBorderColor: [UIColor colorNamed:@"BlackCoral"].CGColor];
    
    [self.usernameTextField setBorderStyle: UITextBorderStyleRoundedRect];
    [self.passwordTextField setBorderStyle: UITextBorderStyleRoundedRect];
    
    
    [[self.usernameTextField layer] setBorderWidth:1.5];
    [[self.passwordTextField layer] setBorderWidth:1.5];
    
    [[self.usernameTextField layer] setCornerRadius:5.0];
    [[self.passwordTextField layer] setCornerRadius:5.0];
    
    [[self.buttonSave layer] setBorderWidth:1.5];
    [[self.buttonSave layer] setCornerRadius:10.0];
    [[self.buttonSave layer] setBorderColor: [UIColor colorNamed:@"LittleBoy"].CGColor];
    
    [self setBackgroundColorFor:self.buttonSave with: [UIColor colorNamed:@"LittleBoySecondary"] forState:UIControlStateHighlighted];
    
    [[self.buttonOne layer] setBorderWidth:1.5];
    [[self.buttonTwo layer] setBorderWidth:1.5];
    [[self.buttonThree layer] setBorderWidth:1.5];
    
    [[self.buttonOne layer] setBorderColor: [UIColor colorNamed:@"LittleBoy"].CGColor];
    [[self.buttonTwo layer] setBorderColor: [UIColor colorNamed:@"LittleBoy"].CGColor];
    [[self.buttonThree layer] setBorderColor: [UIColor colorNamed:@"LittleBoy"].CGColor];
    
    [self.buttonOne addTarget:self action:@selector(secureButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonTwo addTarget:self action:@selector(secureButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonThree addTarget:self action:@selector(secureButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [[self.secureView layer] setBorderWidth:2.0];
    [[self.secureView layer] setCornerRadius:10.0];
}

- (void) refreshView {
    
    [self.secureView setHidden:YES];
    [self.authorizeView setUserInteractionEnabled: YES];
    [self.authorizeView setAlpha:1.0f];
    
    [[self.authorizeView layer] setBorderColor: UIColor.systemBackgroundColor.CGColor];
    self.secureCodeLabel.text = @"_";
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)setBackgroundColorFor:(UIButton *)button with:(UIColor *)backgroundColor forState:(UIControlState)state {
    [button setBackgroundImage: [self imageFromColor:backgroundColor] forState:state];
}

- (UIImage *)imageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 0.5, 0.5);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void) secureButtonTapped:(UIButton *) sender {
    if ([[self.secureCodeLabel text] length] < 3) {
        if ([[self.secureCodeLabel text] isEqual:@"_"]) {
            self.secureCodeLabel.text = @"";
        }
        
        if ([sender isEqual:[self buttonOne]]) {
            self.secureCodeLabel.text = [self.secureCodeLabel.text stringByAppendingString: @"1"];
            if ([[self.secureCodeLabel text] length] == 3) {
                [self checkSecureCode];
            }
        }
        if ([sender isEqual:[self buttonTwo]]) {
            self.secureCodeLabel.text = [self.secureCodeLabel.text stringByAppendingString: @"2"];
            if ([[self.secureCodeLabel text] length] == 3) {
                [self checkSecureCode];
            }
        }
        if([sender isEqual:[self buttonThree]]) {
            self.secureCodeLabel.text = [self.secureCodeLabel.text stringByAppendingString: @"3"];
            if ([[self.secureCodeLabel text] length] == 3) {
                [self checkSecureCode];
            }
        }
    } else {
        [self checkSecureCode];
    }
}

- (void) checkSecureCode {
    if ([[self.secureCodeLabel text] isEqual: @"132"]) {
        
        [[self.secureView layer] setBorderColor: [UIColor colorNamed:@"TurquoiseGreen"].CGColor];
        [self.secureView setUserInteractionEnabled: NO];
        [self showAlertWith:@"Welcome!" andMessage:@"You are successfuly authorized!"];
    } else {
        self.secureCodeLabel.text = @"_";
        [[self.secureView layer] setBorderColor: [UIColor colorNamed:@"VenetianRed"].CGColor];
    }
}


- (IBAction)authorize:(id)sender {
    if ([[self.usernameTextField text] isEqual:[self username]] && [[self.passwordTextField text] isEqual:[self password]]) {
        
        [[self.usernameTextField layer] setBorderColor: [UIColor colorNamed:@"BlackCoral"].CGColor];
        [[self.passwordTextField layer] setBorderColor: [UIColor colorNamed:@"BlackCoral"].CGColor];
        
        self.usernameTextField.text = nil;
        self.passwordTextField.text = nil;
        
        [self.authorizeView setUserInteractionEnabled: NO];
        [self.authorizeView setAlpha:0.3f];
        
        [self.secureView setHidden:NO];
        [self.secureView setUserInteractionEnabled: YES];
        [self.view endEditing:YES];
        
    } else if ([[self.usernameTextField text] isEqual:[self username]]) {
        
        [[self.passwordTextField layer] setBorderColor:UIColor.redColor.CGColor];
        [[self.usernameTextField layer] setBorderColor: [UIColor colorNamed:@"BlackCoral"].CGColor];
    } else if ([[self.passwordTextField text] isEqual:[self password]]) {
        
        [[self.usernameTextField layer]setBorderColor:UIColor.redColor.CGColor];
        [[self.passwordTextField layer] setBorderColor: [UIColor colorNamed:@"BlackCoral"].CGColor];
    } else {
        
        [[self.usernameTextField layer]setBorderColor:UIColor.redColor.CGColor];
        [[self.passwordTextField layer] setBorderColor:UIColor.redColor.CGColor];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [[textField layer] setBorderColor: [UIColor colorNamed:@"BlackCoral"].CGColor];
}

- (void)textFieldDidChangeSelection:(UITextField *)textField {
    [[textField layer] setBorderColor: [UIColor colorNamed:@"BlackCoral"].CGColor];
}

- (void) showAlertWith:(NSString *)title andMessage:(NSString *) message {
    UIAlertController * ac = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * buttonOK = [UIAlertAction actionWithTitle:@"Refresh" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self refreshView];
    }];
    
    [ac addAction:buttonOK];
    [self presentViewController:ac animated:YES completion:nil];
}

@end

