#!/bin/bash

# ===== Colors =====
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
CYAN="\033[1;36m"
RESET="\033[0m"

log() { echo -e "${CYAN}[INFO]${RESET} $1"; }
done_msg() { echo -e "${GREEN}[DONE]${RESET} $1"; }

clone_or_update() {
    local dir=$1
    local repo=$2
    local branch=$3

    if [ -d "$dir/.git" ]; then
        log "Updating existing repo in $dir ..."
        git -C "$dir" remote set-url origin "$repo"
        git -C "$dir" fetch --depth=1 origin "$branch"
        git -C "$dir" reset --hard origin/"$branch"
        done_msg "Updated $dir"
    else
        log "Cloning $repo into $dir ..."
        git clone --depth=1 -b "$branch" "$repo" "$dir"
        done_msg "Cloned into $dir"
    fi
}

# Vendor Tree
clone_or_update vendor/xiaomi/daisy https://github.com/msm8953F/vendor_xiaomi_daisy 14-new
clone_or_update vendor/xiaomi/msm8953-common https://github.com/msm8953F/vendor_xiaomi_msm8953-common 14-new

# Kernel Tree
clone_or_update kernel/xiaomi/msm8953 https://github.com/msm8953F/kernel_xiaomi_msm8953 14

# HALs
clone_or_update hardware/xiaomi https://github.com/LineageOS/android_hardware_xiaomi lineage-21
