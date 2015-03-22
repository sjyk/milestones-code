README
ANNOTATION OF VIDEOS

Folder structure: 
. 
.. 
convert2images.m
data/
cascadeTrainer/

1. Convert .avi files to.mp4 format
Use Handbrake (free, open source) software. 
Format: mp4
Video Codec: H.264 (x264)
Framerate: same as source (30)
Peak Framerate (Constant Framerate)

Note: Suturing E videos are not originally 30 fps (as read by Handbrake). They seem to be of 25-26 fps which results in errors later in the pipeline

2. run the script convert2images.m

3. run cascadeTrailer from folder ../cascadeTrailer/cascadeTrailer.m

a. load all the image files. 
b. note that the ordering is not necessarily correct. 
(it sorts based on an incorrect string, might be fixed later)

4. save the annotations -- File menu, save annotations only. 
This saves the annotations as pairs of  filenames and bounding boxes
bbox: [xmin, ymin, width, height]
(xmin, ymin): top left corner
(xmin+width-1, ymin+width-1): bottom right corner

5. run saveFeatures.m util in data to read from this mat file. 
It will also provide interpolation(param: targetFramerate) if needed. 
By default it will featurize at full frame rate (30).

getFeatures.m
returns a matrix 'features': [t, xmin, ymin, width, height]
t is continuous obtained by t/30 with 30 being the original 
Todo- (might not necessarily match up with the kinematics data)

Use [xmin, ymin, width, height] as it is for feature it encodes position and implicit orientation (at least in 2D)

ToDO: visual processing to recover needle orientation.

