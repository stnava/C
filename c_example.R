library( ANTsR )

# Read in the images

dataDirectory <- './data/'

fixedImage <- antsImageRead(
   paste0( dataDirectory, 'chalf.nii.gz' ), dimension = 2 )
movingImage <- antsImageRead(
   paste0( dataDirectory, 'c.nii.gz' ), dimension = 2 )

# Plot the fixed  and moving images
plot( movingImage, fixedImage, color.overlay = "jet", alpha = 0.7 )

#######
#
# Perform registration
#

outputDirectory <- './OutputANTsR/'
if( ! dir.exists( outputDirectory ) )
  {
  dir.create( outputDirectory )
  }
outputPrefix <- paste0( outputDirectory, 'antsr' )

registration <- antsRegistration(
  fixed = fixedImage, moving = movingImage,
  typeofTransform = 'TVMSQC',
  gradStep = 2.0,
  verbose = TRUE, printArgs = TRUE, outprefix = outputPrefix )

antsImageWrite( registration$warpedmovout, paste0( outputPrefix, "Warped.nii.gz" ) )
antsImageWrite( registration$warpedfixout, paste0( outputPrefix, "InverseWarped.nii.gz" ) )

# Plot the moving and warped fixed image
plot( movingImage, registration$warpedfixout, color.overlay = "jet", alpha = 0.4 )
