# CGODemoApp

# Tasks done:
1. Ingests a json feed from   https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json  
2. You can use a third party json parser to parse this if desired. 
3. The feed contains a title and a list of rows 
4. Use Collection View to display the content. Making sure the CollectionViewCell size is dynamic and which should vary based on the image size. 
5. Restrict the image to go to outside of the device width if image is having a larger width then your device. 
6. Loads the images lazily 
7. Don’t download them all at once, but only as needed
8. Refresh function 
9. Each image having title at the bottom of the image. 
10. For iphone & iPad (portrait)- When click on collection view image, navigate to detail page having title on navigation bar with image as banner and description at the bottom of the banner image. 
11. For iphone & iPad (landscape)- When click on collection view image, navigate to detail page having title on navigation bar with image on the left hand side of the screen and description at the right hand side of the screen (ratio size of the screen between image and description is 30:70). 

>> Pull to refresh and network reachability

![Alt text](https://github.com/rheyansh/CGODemoApp/blob/master/Screenshots/0.png)
![Alt text](https://github.com/rheyansh/CGODemoApp/blob/master/Screenshots/1.png)
![Alt text](https://github.com/rheyansh/CGODemoApp/blob/master/Screenshots/3.png)

# TECHNICAL SPECIFICATION

1. Min deployment target:                     iOS 8.0
2. IDE:                             	  	    XCode 9.3 (Please make sure to use 9.3 version of xcode)
3. Design pattern:                          	MVC
4. Programming language usage:     	          Swift 4.1
5. View specification:                       	Storyboard
6. Layout support:                         	  Autolayout
7. Compatibility:                            	All iPhone/iPad
8. Mode:                            	        Both portrait and ladscape
8. Online/Offline:                            Online

# Project structure

Folder/Viewcontroller:- It contains all the used viewcontroller files.

Folder/CustomCells:- It contains all the custom cells used for UITableView and UICollectionView.

Folder/Extension:- It has reusable and helper extensions for UIImageView, UIApplication, UIView, UIImageView, Dictionary etc.

Folder/Artwork:- Contains placeholder image and can be used to add custom fonts, static html etc.

Folder/Modals:- Contains all the models classes for data parsing and business logic.

Folder/Utils:- Contains utility classes, constants files, logger and debuggers etc.

Folder/WebApiClasses:- Contains all the files and classes needed for client server communications like Reachability, Service helper, progress hud.

Folder/Storyboards:- Contains multiple storyboards with scenes.

Assets.scassests:- Contains slices image in 2x and 3x resolutions including app icons. Note that launch screen are note added here as there is separate launch storyboard which is used for launch image to minimize app size.
Info.plist:- App’s pre configurations, permissions, info, behaviours are added in this file.

Folder/ExternalClasses:- All the third party classes are added in this folder.

Podfile:- Contains dependencies and their versions used in project.


