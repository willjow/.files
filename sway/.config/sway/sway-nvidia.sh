#!/bin/sh

# NOTE: Vulkan seems to really prefer selecting the nvidia gpu; the only way to
# use intel seems to be with `DRI_PRIME=0 MESA_VK_DEVICE_SELECT=8086:9a60!`.
#
# All other compbinations of `DRI_PRIME` and `MESA_VK_DEVICE_SELECT(!)` use
# nvidia when testing with `vkcube`.

WLR_DRM_DEVICES=/dev/dri/by-name/intel:/dev/dri/by-name/nvidia \
MESA_VK_DEVICE_SELECT=8086:9a60! \
sway --unsupported-gpu
