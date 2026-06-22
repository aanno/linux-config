#!/bin/bash
# webcam-settings.sh

# Arguments:
#   $1 = camera model pattern (e.g., "BRIO")
#   $2 = settings name (e.g., "day")

CAMERA_PATTERN="$1"
SETTINGS_NAME="$2"

if [[ -z "$CAMERA_PATTERN" || -z "$SETTINGS_NAME" ]]; then
    echo "Usage: $0 <camera-pattern> <settings-name>"
    echo "Example: $0 BRIO day"
    exit 1
fi

# Find device by camera model pattern
DEVICE=$(for d in /dev/video[0-9]*; do
    if v4l2-ctl --all -d "$d" 2>/dev/null | grep -qi "$CAMERA_PATTERN"; then
        echo "$d"
        break
    fi
done)

if [[ -z "$DEVICE" ]]; then
    echo "Error: No camera found matching '$CAMERA_PATTERN'"
    exit 1
fi

echo "Using device: $DEVICE"

CONFIG_DIR="$HOME/.webcam_settings"
mkdir -p "$CONFIG_DIR"
CONFIG_FMT="$CONFIG_DIR/${CAMERA_PATTERN}_${SETTINGS_NAME}.fmt"
CONFIG_CTRL="$CONFIG_DIR/${CAMERA_PATTERN}_${SETTINGS_NAME}.ctrls"

# The 9 settings to save/restore
CONTROLS=(
    "brightness"
    "contrast"
    "power_line_frequency"
    "sharpness"
    "backlight_compensation"
    "zoom_absolute"
    "saturation"
    "zoom_absolute"
    "white_balance_automatic"
    "white_balance_temperature"
    "auto_exposure"
    "exposure_time_absolute"
    "exposure_dynamic_framerate"
    "focus_absolute"
    "focus_automatic_continuous"
)

save() {
    echo "Saving settings for $CAMERA_PATTERN -> $SETTINGS_NAME..."
    
    # Save format (resolution, pixel format, fps)
    v4l2-ctl --all -d "$DEVICE" | \
    grep -A10 "Format Video Capture:" | \
    grep -E "Width/Height|Pixel Format|Frames per second" > "$CONFIG_FMT"
    
    # Extract current values
    WIDTH=$(v4l2-ctl -d "$DEVICE" --get-fmt-video | grep "Width/Height" | awk -F': ' '{print $2}' | awk -F'/' '{print $1}')
    HEIGHT=$(v4l2-ctl -d "$DEVICE" --get-fmt-video | grep "Width/Height" | awk -F': ' '{print $2}' | awk -F'/' '{print $2}')
    PIXELFORMAT=$(v4l2-ctl -d "$DEVICE" --get-fmt-video | grep "Pixel Format" | awk -F"'" '{print $2}')
    FPS=$(v4l2-ctl --all -d "$DEVICE" | grep "Frames per second:" | awk -F': ' '{print $2}' | awk '{print $1}')
    
    echo "width=$WIDTH" > "$CONFIG_CTRL"
    echo "height=$HEIGHT" >> "$CONFIG_CTRL"
    echo "pixelformat=$PIXELFORMAT" >> "$CONFIG_CTRL"
    echo "fps=$FPS" >> "$CONFIG_CTRL"
    
    # Save each control value
    for ctrl in "${CONTROLS[@]}"; do
        VALUE=$(v4l2-ctl -d "$DEVICE" --all | grep "$ctrl" | awk -F'value=' '{print $2}' | awk '{print $1}')
        echo "$ctrl=$VALUE" >> "$CONFIG_CTRL"
    done
    
    echo "Saved to: $CONFIG_FMT and $CONFIG_CTRL"
}

restore() {
    if [[ ! -f "$CONFIG_CTRL" ]]; then
        echo "Error: Settings file not found: $CONFIG_CTRL"
        echo "Run 'save' first to create it."
        exit 1
    fi
    
    echo "Restoring settings for $CAMERA_PATTERN -> $SETTINGS_NAME..."
    
    # Read values
    while IFS='=' read -r key value; do
        case "$key" in
            width) WIDTH="$value" ;;
            height) HEIGHT="$value" ;;
            pixelformat) PIXELFORMAT="$value" ;;
            fps) FPS="$value" ;;
            brightness) BRIGHTNESS="$value" ;;
            contrast) CONTRAST="$value" ;;
            power_line_frequency) POWER_LINE_FREQ="$value" ;;
            sharpness) SHARPNESS="$value" ;;
            backlight_compensation) BACKLIGHT="$value" ;;
            zoom_absolute) ZOOM="$value" ;;
        esac
    done < "$CONFIG_CTRL"
    
    # Restore format (resolution, pixel format)
    echo "Setting format: $WIDTHx$HEIGHT $PIXELFORMAT @ $FPS fps"
    v4l2-ctl -d "$DEVICE" --set-fmt-video=width=$WIDTH,height=$HEIGHT,pixelformat=$PIXELFORMAT
    
    # Note: fps is set via stream parameters, not directly via v4l2-ctl
    # Some cameras need gst-v4l2 or application-level setting
    
    # Restore controls
    echo "Setting brightness=$BRIGHTNESS"
    v4l2-ctl -d "$DEVICE" -c brightness=$BRIGHTNESS
    
    echo "Setting contrast=$CONTRAST"
    v4l2-ctl -d "$DEVICE" -c contrast=$CONTRAST
    
    echo "Setting power_line_frequency=$POWER_LINE_FREQ"
    v4l2-ctl -d "$DEVICE" -c power_line_frequency=$POWER_LINE_FREQ
    
    echo "Setting sharpness=$SHARPNESS"
    v4l2-ctl -d "$DEVICE" -c sharpness=$SHARPNESS
    
    echo "Setting backlight_compensation=$BACKLIGHT"
    v4l2-ctl -d "$DEVICE" -c backlight_compensation=$BACKLIGHT
    
    echo "Setting zoom_absolute=$ZOOM"
    v4l2-ctl -d "$DEVICE" -c zoom_absolute=$ZOOM
    
    echo "Settings restored from: $CONFIG_CTRL"
}

case "$3" in
    save)
        save
        ;;
    restore)
        restore
        ;;
    *)
        echo "Usage: $0 <camera-pattern> <settings-name> <save|restore>"
        echo "Example: $0 BRIO day save"
        echo "Example: $0 BRIO day restore"
        exit 1
        ;;
esac

