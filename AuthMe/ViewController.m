//
//  ViewController.m
//  AuthMe
//
//  Created by Erika Bueno on 3/24/16.
//  Copyright © 2016 ErikaBueno. All rights reserved.
//

#import "ViewController.h"
#import "AuthModel.h"
#import "AuthService.h"
#import "AuthController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *userPasswordField;
@property (weak, nonatomic) IBOutlet UILabel *authenticationResultLabel;
@property (weak, nonatomic) IBOutlet UITextView *userRolesTextView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (IBAction)authenticateUser:(id)sender {
    
    // since it's mocked, it's gonna work every single time ;)
    
    self.authenticationResultLabel.text = @" ";
    
    AuthModel *authModel = [[AuthModel alloc] init];
    authModel.userEmail = self.userNameField.text;
    authModel.userPassword = self.userPasswordField.text;
    authModel.applicationKey = @"00000000-0000-0000-0000-000000000000";
    authModel.tokenExpiration = [NSNumber numberWithInt:30];
    
    AuthController *authController = [[AuthController alloc] init];
    [authController authenticateUser:authModel block:^(NSError * _Nullable error) {
        
        dispatch_async(dispatch_get_main_queue(),
                       ^{
                           if (error) {
                               NSLog(@"Authentication error: %@", error.description);
                               self.authenticationResultLabel.text = @"Authentication error";
                           } else {
                               NSLog(@"User authenticated");
                               self.authenticationResultLabel.text = @"User authenticated";
                           }
                       });
    }];
    
}

- (IBAction)listRoles:(id)sender {
    self.userRolesTextView.text = @"teste";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
