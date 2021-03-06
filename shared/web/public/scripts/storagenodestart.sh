#!/bin/bash
# This script starts storagenode 
function setupEnv() {
    dirpath=$(dirname "$0")
    export PATH=$PATH:$dirpath
    . common.sh
}
setupEnv 

LOG=$LOGFILE

if [[ $# -lt 5 ]]
then
    msg="Not sufficient parameters to start storage node"
    echo "$msg"
    echo "$msg" >> "$LOG"
    exit 1
fi

#export PATH=$PATH:${SYS_QPKG_INSTALL_PATH}/container-station/bin
export PATH=$PATH:/share/CACHEDEV1_DATA/.qpkg/container-station/bin
IPADDR=$(ip -4 -o addr show eth0 | awk '{print $4}' | cut -d "/" -f 1)
PORTADDR=$(sed -e 's#.*:\(\)#\1#' <<< "${1}")
CONTAINER_NAME=storjlabsSnContainer

echo "$(date)" " Starting Storagenode ${CONTAINER_NAME} ---> " >> "$LOG"
docker ps -a  >> "$LOG"

if [[ $# -ge 6 ]]
then
    cmd="docker run -d --restart unless-stopped --stop-timeout 300 -p ${PORTADDR}:28967 -p ${IPADDR}:14002:14002 -p ${IPADDR}:9000:9000 -e WALLET=${2} -e EMAIL=${6} -e ADDRESS=${1} -e STORAGE=${3}GB --mount type=bind,source=${4},destination=/app/identity --mount type=bind,source=${5},destination=/app/config --name ${CONTAINER_NAME} storjlabs/storagenode:latest "
else
    cmd="docker run -d --restart unless-stopped --stop-timeout 300 -p ${PORTADDR}:28967 -p ${IPADDR}:14002:14002 -p ${IPADDR}:9000:9000 -e WALLET=${2} -e ADDRESS=${1} -e STORAGE=${3}GB --mount type=bind,source=${4},destination=/app/identity --mount type=bind,source=${5},destination=/app/config --name ${CONTAINER_NAME} storjlabs/storagenode:latest "
fi

if [ "$(ls -A ${5})" ]; 
then
     echo "${5} have data" >> "$LOG"
else
    cmd_run="docker run --rm -e SETUP="true"  --mount type=bind,source=${4},destination=/app/identity --mount type=bind,source=${5},destination=/app/config --name ${CONTAINER_NAME} storjlabs/storagenode:latest"
    echo "$cmd_run" >> "$LOG"
    $cmd_run >> "$LOG" 2>&1 
fi

echo "$cmd" >> "$LOG"
$cmd >> "$LOG" 2>&1 
echo "$output" >> "$LOG" 
echo "$output" 
output=$(docker ps -a | grep "${CONTAINER_NAME}" )
echo "$output" >> "$LOG" 
cat <<< "$output"