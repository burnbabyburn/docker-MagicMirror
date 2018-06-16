#!/bin/bash
if [ ! -f /opt/magic_mirror/config ]; then
    cp -Rn /opt/default_config/. /opt/magic_mirror/config
fi

$1
