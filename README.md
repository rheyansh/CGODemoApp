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

# TECHNICAL SPECIFICATION

1. Min deployment target:                     iOS 8.0
2. IDE:                             	  	    XCode 9.3
3. Design pattern:                          	MVC
4. Programming language usage:     	          Swift 4.1
5. View specification:                       	Storyboard
6. Layout support:                         	  Autolayout
7. Compatibility:                            	All iPhone/iPad
8. Mode:                            	        Both portrait and ladscape
8. Online/Offline:                            Online
