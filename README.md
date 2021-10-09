# FDL-HCGH-feature
The light field dataset used for feature matching includes a real-world light field dataset and a synthetic light field dataset (blender).
We create a LF dataset with ground truth matching points using the open-source software Blender.  For each group data, we have generated a pair of LF images with known translation,
rotation and camera settings. The LF includes 9∗9 views, each view is 512 ∗ 512 in spatial resolution, with a the disparity range within the interval [[ 2, 2] pixels.
We capture multiple pairs of real-world LFs, in which the illumination and noise are more complex. With the Lytro camera, one LF of each pair has 11∗13 views, and each view has a 378∗328 spatial resolution.
With the Illum camera, the angular resolution and spatial resolution are 15 ∗ 17 and 541 ∗ 434 respectively. Due to the limited aperture (or angular baseline) the disparity range of all real-world datasets is within [[ 2, 2] pixels.
