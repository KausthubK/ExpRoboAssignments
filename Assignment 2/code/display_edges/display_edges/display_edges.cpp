/*!
 *  \example Display_Video Displays images from an ImageGrabber
 */ 

// Example configuration files:
/*!
 * \example v4l.cfg
 *   Example configuration file for accessing video-for-linux cameras 
 *   (ie those that are accessed though /dev/video), such as USB cameras.
 */

/*!
 * \example fw.cfg
 *   Example configuration file for accessing Firewire cameras.
 */

#include <iostream>
#include "camera.hpp"
#include <opencv/highgui.h>
#include <unistd.h>

//--------------------------- CONSTANTS ------------------------------

#define USAGE_ARGS " <configFile> [-q(uiet)] [-w(aitKey)]"

//------------------------------ DATA ------------------------------

// Camera
ImageGrabber *imageGrabber;

int width, height;
int quiet   = 0;
int waitKey = 0;
char configFileName[80];

//------------------------------ FUNCTIONS ------------------------------

using namespace std;

int isSavedImageGrabber( ImageGrabber *ig )
{
    SavedImageGrabber *sg;
    sg = dynamic_cast<SavedImageGrabber*>(ig);
    if ( sg == NULL )
    {
        return 0;
    }
    else
    {
        return 1;
    }
}

int main( int argc, char **argv )
{
    // args
    if ( argc < 2 )
    {
        std::cout << "Usage: " << argv[0] << USAGE_ARGS << std::endl;
        exit(1);
    }
    strcpy( configFileName, argv[1] );

    int i=2;
    while ( i < argc )
    {
//     if ( argc == 3 )
//     {
        if (!strcmp(argv[i],"-q"))
        {
            quiet = 1;
        }
        else if (!strcmp(argv[i],"-w"))
        {
            waitKey = 1;
        }
        else
        {
            std::cout << "Usage: " << argv[0] << USAGE_ARGS << std::endl;
            exit(1);
        }
        i++;
    }

    ImageGrabberConfig cfg(configFileName);
    imageGrabber = cfg.getImageGrabber();

    cout << "TRACE(display_video.cpp): ImageGrabber:" << endl << cfg << endl;

    width  = imageGrabber->getWidth();
    height = imageGrabber->getHeight();

    IplImage *image = cvCreateImage( cvSize( width, height ), 8, 3 );
    IplImage *image_grey = cvCreateImage( cvSize( width, height ), 8, 1 );
    IplImage *image_edge = cvCreateImage( cvSize( width, height ), 8, 1 );

    if ( !quiet )
    {
        cvNamedWindow("video",1);
        cvResizeWindow("video",width+1,height+1);

        cvNamedWindow("video_edge",1);
        cvResizeWindow("video_edge",width+1,height+1);
    }


    cout << "TRACE(display_video.cpp): ZOOM  = " << imageGrabber->getZoom()  << endl;
    cout << "TRACE(display_video.cpp): FOCUS = " << imageGrabber->getFocus() << endl;

    while ( imageGrabber->getImage( image ) )
    {
//         CvPoint p;
//         imageGrabber->getPointFromDirection( 0, 0, &p );
//         cvRectangle( image, 
//                      cvPoint( p.x-2, p.y-2 ),
//                      cvPoint( p.x+2, p.y+2 ),
//                      255 );

        cvCvtColor(image, image_grey, CV_RGB2GRAY);
        cvCanny(image_grey, image_edge, 0.0, 100.0, 3);

	
        if ( !quiet )
        {
            cvShowImage( "video", image );
            cvShowImage( "video_edge", image_edge );
        }

        if ( isSavedImageGrabber( imageGrabber ) )
        {
            usleep(50000);
        }

        if ( waitKey )
        {
            cvWaitKey();
        }
    }
}
