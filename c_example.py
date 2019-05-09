import ants
import os

# Read in the images

dataDirectory = './data/'

fixedImageFile = dataDirectory + 'chalf.nii.gz'
fixedImage = ants.image_read( fixedImageFile, dimension = 2 )
movingImageFile = dataDirectory + 'c.nii.gz'
movingImage = ants.image_read( movingImageFile, dimension = 2 )

# Plot the fixed  and moving images
ants.plot( movingImage, overlay = fixedImage, overlay_cmap = "viridis", alpha = 0.9 )

#######
#
# Perform registration
#

outputDirectory = './OutputANTsPy/'
if not os.path.isdir( outputDirectory ):
  os.mkdir( outputDirectory )

outputPrefix = outputDirectory + 'antsr'

registration = ants.registration(
  fixed = fixedImage, moving = movingImage,
  type_of_transform = 'TVMSQC',
  grad_step = 2.0,
  verbose = True, outprefix = outputPrefix )

ants.image_write( registration['warpedmovout'], outputPrefix + "Warped.nii.gz" )
ants.image_write( registration['warpedfixout'], outputPrefix + "InverseWarped.nii.gz" )

# Plot the moving and warped fixed image
ants.plot( movingImage, overlay = registration['warpedfixout'], overlay_cmap = "viridis", alpha = 0.9 )
