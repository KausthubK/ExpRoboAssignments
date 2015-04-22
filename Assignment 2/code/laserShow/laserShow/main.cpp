/*
 *  Orca-Components: Components for robotics.
 *  
 *  Copyright (C) 2004
 *  
 *  This program is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU General Public License
 *  as published by the Free Software Foundation; either version 2
 *  of the License, or (at your option) any later version.
 *  
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *  
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 */

//!
//! \author Stefan Williams
//!

#include <iostream>
#include <fstream>
#include <string>

#define SHOW_GUI
#ifdef SHOW_GUI
#include <opencv/highgui.h>
#include <opencv/cv.h>
#include <opencv/cvtypes.h>
#define IMAGE_WIDTH  640
#define IMAGE_HEIGHT  640
#define WORKSPACE_SCALE 0.125 
#define SHOW_INTERVAL 1
#endif

using namespace std;

///////////////////// DEFINES /////////////////////

#define USAGE_ARGS " <laserFile>"
#define NUM_LASER_POINTS 361

//////////////////// FUNCTIONS ////////////////////

//
// Returns the name of the xml configuration file
//
string
parseArgs( int argc, char **argv ) {
    //
    // Read the xml config file name off the command line
    //
    if ( argc != 2 ) {
        cout << "USAGE: " << argv[0] << USAGE_ARGS << endl;
        exit(1);
    }
    return argv[1];
}

#ifdef SHOW_GUI
void showPoint( IplImage *image, double range, double bearing, int radius, int colour)
{
   double x = range * cos (bearing);
   double y = range * sin (bearing);
   int cx = x / WORKSPACE_SCALE;
   int cy = IMAGE_HEIGHT/2 - y / WORKSPACE_SCALE;
   
   if (cx > 0 && cx < IMAGE_WIDTH && cy > 0 && cy < IMAGE_HEIGHT )
   {
     CvPoint location = cvPoint( cx, cy );
     cvCircle( image, location, radius, colour );
   }
}
#endif

int
main (int argc, char **argv) {
    //
    // Begin Setup Code
    //

    std::ifstream laserFile(argv[1]);

    if (!laserFile)
    {
      std::cerr << "Error opening laser file " << argv[1] << ". Please ensure file exists" << std::endl;
      exit(1);
    }
    //
    // Get and display the laser feature data repeatedly
    //

#ifdef SHOW_GUI
    // setup the GUI stuff...
    CvSize image_size = cvSize( IMAGE_WIDTH , IMAGE_HEIGHT );
    IplImage *image  = cvCreateImage( image_size, IPL_DEPTH_8U, 3 );
    int DisplayCounter = SHOW_INTERVAL;
#endif

    double timeStamp, lastUpdateTime;
    double laserRanges[NUM_LASER_POINTS];
    
    std::cout << "Starting feature extractor" << std::endl;

    while (!laserFile.eof()) 

    {
	laserFile >> timeStamp;
	std::cout << timeStamp << std::endl;
	
	for (int i = 0; i < NUM_LASER_POINTS; i++)
	{
	  laserFile >> laserRanges[i];
	  std::cout << laserRanges[i] << " ";
	}
	std::cout << std::endl;

        // last update is now
	lastUpdateTime = timeStamp;
        //std::cout << "Time stamp on laserData: " << lastUpdateTime << std::endl;
        
#ifdef SHOW_GUI
        // first clear the image
        cvSetZero( image );
  
        // now plot the raw laser points
        for (int i = 0; i < NUM_LASER_POINTS; i++)
        {
          double range = laserRanges[i]/100;
          double bearing = M_PI*i/(NUM_LASER_POINTS-1) - M_PI/2;
          showPoint( image, range, bearing, 1, CV_RGB( 0, 0, 255 ));
        }
  
        cvNamedWindow("laserFeatureViewer", 1);
        cvShowImage("laserFeatureViewer", image);
        cvResizeWindow("laserFeatureViewer", image->width+3, image->height+3);
#endif
    }

    return 0;
}
