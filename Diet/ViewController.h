//
//  ViewController.h
//  Diet
//
//  Created by 藤浦ゆず on 2014/05/03.
//  Copyright (c) 2014年 藤浦ゆず. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreImage/CoreImage.h>




@interface PhotoViewController : UINavigationController<UIPageViewControllerDelegate> {
    id delegate;
}

@property (nonatomic, assign) id delegate;

-(id)initController;

@end

@interface CameraOverlayView : UIImageView

@property (nonatomic) BOOL cameraFlag;
@property UIImagePickerController *pickerController;

@end

@interface imagePickerController:UIImagePickerController
@property  (strong) NSString *ciImage;

@end



@interface ViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    IBOutlet UIImageView *imageview;
    IBOutlet UIImageView *imageview2;
    
    
}

@property (nonatomic, retain) NSMutableArray *groupList;
@property (nonatomic) UIImage *image;




-(IBAction)openLibrary;


-(IBAction)postToFacebook;

-(IBAction)postTotwitter;




@end