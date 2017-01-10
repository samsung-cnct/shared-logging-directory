#!/bin/sh

set -x

#  this script assumes it is being used as part of the samsung logging system.
#  it doesn't make a lot of sense otherwise

#  this script will create a pod specific directory in /var/log
#  it will then create a symlink from /var/log/application to the unique directory
#  this will prevent name collisions and allow us to collect named log files and
#  add metadata

#  assumes the host log directory is mounted to /hostlogs
mkdir /hostlogs/${POD_NAME:-no_pod_name_set}_${POD_NAMESPACE:-no_pod_namespace_set}_${POD_IP:-no_pod_ip_set}

#  assumes /log-pointer is an emptyDir mount shared between the containers
ln -s /hostlogs/${POD_NAME:-no_pod_name_set}_${POD_NAMESPACE:-no_pod_namespace_set}_${POD_IP:-no_pod_ip_set} /log-pointer/application
