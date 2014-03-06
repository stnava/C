dim=2
m=data/c.nii.gz 
f=data/chalf.nii.gz
its=[1200x1200x100x20x0,0,5]
smth=8x6x4x2x1vox
down=8x6x4x2x1
antsRegistration -d $dim  \
                        -m demons[ $f,$m, 0.5, 0 ] \
                        -m meansquares[ $f,$m, 1, 0 ] \
                        -t TimeVaryingVelocityField[ 2.0, 8, 1,0.0, 0.05,0 ] \
                        -c $its  \
                        -s $smth  \
                        -f $down \
                       -u 1 \
                       -o [output/ex_,output/ex_diff.nii.gz,output/ex_diff_inv.nii.gz] 
CreateWarpedGridImage $dim output/ex_0InverseWarp.nii.gz output/grid.nii.gz 
ConvertToJpg output/grid.nii.gz figures/grid.png 
CreateJacobianDeterminantImage 2 output/ex_0Warp.nii.gz output/jac.nii.gz 0 1
CreateJacobianDeterminantImage 2 output/ex_0InverseWarp.nii.gz output/jac_inv.nii.gz 0 1
