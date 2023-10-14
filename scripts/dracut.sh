#!/bin/sh -x
dracut -f -v --omit-drivers="nouveau i915" --force-drivers="nvidia_drm nvidia_modeset nvidia_uvm nvidia" --kver $*

