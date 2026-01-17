NEW_TAG=580.119.02
OLD_TAG=580.95.05

ln -sf /usr/lib64/libcudadebugger.so.${NEW_TAG} /usr/lib64/libcudadebugger.so.${OLD_TAG}
ln -sf /usr/lib64/libcuda.so.${NEW_TAG} /usr/lib64/libcuda.so.${OLD_TAG}
ln -sf /usr/lib64/libEGL_nvidia.so.${NEW_TAG} /usr/lib64/libEGL_nvidia.so.${OLD_TAG} 
ln -sf /usr/lib64/libGLESv1_CM_nvidia.so.${NEW_TAG} /usr/lib64/libGLESv1_CM_nvidia.so.${OLD_TAG}
ln -sf /usr/lib64/libGLESv2_nvidia.so.${NEW_TAG} /usr/lib64/libGLESv2_nvidia.so.${OLD_TAG}
ln -sf /usr/lib64/libGLX_nvidia.so.${NEW_TAG} /usr/lib64/libGLX_nvidia.so.${OLD_TAG}
ln -sf /usr/lib64/libnvcuvid.so.${NEW_TAG} /usr/lib64/libnvcuvid.so.${OLD_TAG}
ln -sf /usr/lib64/libnvidia-allocator.so.${NEW_TAG} /usr/lib64/libnvidia-allocator.so.${OLD_TAG}
ln -sf /usr/lib64/libnvidia-cfg.so.${NEW_TAG} /usr/lib64/libnvidia-cfg.so.${OLD_TAG}
ln -sf /usr/lib64/libnvidia-eglcore.so.${NEW_TAG} /usr/lib64/libnvidia-eglcore.so.${OLD_TAG}
ln -sf /usr/lib64/libnvidia-encode.so.${NEW_TAG} /usr/lib64/libnvidia-encode.so.${OLD_TAG}
ln -sf /usr/lib64/libnvidia-fbc.so.${NEW_TAG} /usr/lib64/libnvidia-fbc.so.${OLD_TAG}
ln -sf /usr/lib64/libnvidia-glcore.so.${NEW_TAG} /usr/lib64/libnvidia-glcore.so.${OLD_TAG}
ln -sf /usr/lib64/libnvidia-glsi.so.${NEW_TAG} /usr/lib64/libnvidia-glsi.so.${OLD_TAG}
ln -sf /usr/lib64/libnvidia-glvkspirv.so.${NEW_TAG} /usr/lib64/libnvidia-glvkspirv.so.${OLD_TAG}
ln -sf /usr/lib64/libnvidia-gpucomp.so.${NEW_TAG} /usr/lib64/libnvidia-gpucomp.so.${OLD_TAG}
ln -sf /usr/lib64/libnvidia-gtk3.so.${NEW_TAG} /usr/lib64/libnvidia-gtk3.so.${OLD_TAG}
ln -sf /usr/lib64/libnvidia-ml.so.${NEW_TAG} /usr/lib64/libnvidia-ml.so.${OLD_TAG}
ln -sf /usr/lib64/libnvidia-ngx.so.${NEW_TAG} /usr/lib64/libnvidia-ngx.so.${OLD_TAG}
ln -sf /usr/lib64/libnvidia-nvvm.so.${NEW_TAG} /usr/lib64/libnvidia-nvvm.so.${OLD_TAG}
ln -sf /usr/lib64/libnvidia-opencl.so.${NEW_TAG} /usr/lib64/libnvidia-opencl.so.${OLD_TAG}
ln -sf /usr/lib64/libnvidia-opticalflow.so.${NEW_TAG} /usr/lib64/libnvidia-opticalflow.so.${OLD_TAG}
ln -sf /usr/lib64/libnvidia-pkcs11-openssl3.so.${NEW_TAG} /usr/lib64/libnvidia-pkcs11-openssl3.so.${OLD_TAG}
ln -sf /usr/lib64/libnvidia-present.so.${NEW_TAG} /usr/lib64/libnvidia-present.so.${OLD_TAG}
ln -sf /usr/lib64/libnvidia-ptxjitcompiler.so.${NEW_TAG} /usr/lib64/libnvidia-ptxjitcompiler.so.${OLD_TAG}
ln -sf /usr/lib64/libnvidia-rtcore.so.${NEW_TAG} /usr/lib64/libnvidia-rtcore.so.${OLD_TAG}
ln -sf /usr/lib64/libnvidia-sandboxutils.so.${NEW_TAG} /usr/lib64/libnvidia-sandboxutils.so.${OLD_TAG}
ln -sf /usr/lib64/libnvidia-tls.so.${NEW_TAG} /usr/lib64/libnvidia-tls.so.${OLD_TAG}
ln -sf /usr/lib64/libnvidia-vksc-core.so.${NEW_TAG} /usr/lib64/libnvidia-vksc-core.so.${OLD_TAG}
ln -sf /usr/lib64/libnvidia-wayland-client.so.${NEW_TAG} /usr/lib64/libnvidia-wayland-client.so.${OLD_TAG}
ln -sf /usr/lib64/libnvoptix.so.${NEW_TAG} /usr/lib64/libnvoptix.so.${OLD_TAG}

ln -sf /usr/lib64/vdpau/libvdpau_nvidia.so.${NEW_TAG} /usr/lib64/vdpau/libvdpau_nvidia.so.${OLD_TAG}

ln -sf /lib/firmware/nvidia/${NEW_TAG} /lib/firmware/nvidia/${OLD_TAG}

ln -sf /usr/lib64/libnvidia-egl-gbm.so.1.1.3 /usr/lib64/libnvidia-egl-gbm.so.1.1.2
ln -sf /usr/lib64/libnvidia-egl-wayland.so.1.1.21 /usr/lib64/libnvidia-egl-wayland.so.1.1.20

ls -l /usr/lib64/*.${OLD_TAG}*
ls -l /usr/lib64/vdpau/*.${OLD_TAG}*
ls -l /lib/firmware/nvidia/${NEW_TAG}

