#!/usr/bin/env bash

# date_utils.sh - Cross-platform date utility functions
# Provides consistent date formatting and arithmetic across GNU (Linux), BSD (macOS), and Windows (Git Bash/MSYS) systems

# Detect the platform type
# Returns: "darwin", "linux", "windows", or "unknown"
get_platform() {
    local os_type
    os_type=$(uname -s)

    case "$os_type" in
        Darwin)
            echo "darwin"
            ;;
        Linux)
            echo "linux"
            ;;
        MINGW*|MSYS*|CYGWIN*)
            # Git Bash, MSYS2, or Cygwin on Windows
            echo "windows"
            ;;
        *)
            echo "unknown"
            ;;
    esac
}

# Get current timestamp in ISO 8601 format with seconds precision
# Returns: YYYY-MM-DDTHH:MM:SS+00:00 format
get_iso_timestamp() {
    local platform
    platform=$(get_platform)

    case "$platform" in
        darwin)
            # macOS (BSD date)
            # Use manual formatting and add colon to timezone offset
            date -u +"%Y-%m-%dT%H:%M:%S%z" | sed 's/\(..\)$/:\1/'
            ;;
        windows)
            # Git Bash/MSYS on Windows - uses GNU-like date but -Iseconds may not work
            # Use explicit format for maximum compatibility
            date -u +"%Y-%m-%dT%H:%M:%S+00:00"
            ;;
        *)
            # Linux (GNU date) - use -u flag for UTC
            date -u -Iseconds
            ;;
    esac
}

# Get time component (HH:MM:SS) for one hour from now
# Returns: HH:MM:SS format
get_next_hour_time() {
    local platform
    platform=$(get_platform)

    case "$platform" in
        darwin)
            # macOS (BSD date) - use -v flag for date arithmetic
            date -v+1H '+%H:%M:%S'
            ;;
        windows)
            # Git Bash/MSYS on Windows - date -d may not work reliably
            # Calculate manually using current hour + 1
            local current_hour=$(date +%H)
            local next_hour=$(( (10#$current_hour + 1) % 24 ))
            printf "%02d:%02d:%02d\n" $next_hour $(date +%M) $(date +%S)
            ;;
        *)
            # Linux (GNU date) - use -d flag for date arithmetic
            date -d '+1 hour' '+%H:%M:%S'
            ;;
    esac
}

# Get current timestamp in a basic format (fallback)
# Returns: YYYY-MM-DD HH:MM:SS format
get_basic_timestamp() {
    date '+%Y-%m-%d %H:%M:%S'
}

# Get current Unix epoch time in seconds
# Returns: Integer seconds since 1970-01-01 00:00:00 UTC
get_epoch_seconds() {
    date +%s
}

# Export functions for use in other scripts
export -f get_platform
export -f get_iso_timestamp
export -f get_next_hour_time
export -f get_basic_timestamp
export -f get_epoch_seconds
