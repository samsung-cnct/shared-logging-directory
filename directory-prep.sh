#!/bin/sh

set -x

#  this script assumes it is being used as part of the samsung logging system.
#  it doesn't make a lot of sense otherwise

#  this script will create a pod specific directory in /var/log
#  it will then create a symlink from /var/log/application to the unique directory
#  this will prevent name collisions and allow us to collect named log files and
#  add metadata

#  we are adding unknowns to the end of the directory because convention would put container name and docker id there 
#  when this data becomes available through downward API we will add it in, but for now it it necessary to include these
#  items so we can pass the logs to the kubernetes metadata filter, which requires them

#  assumes the host log directory is mounted to /hostlogs
mkdir /hostlogs/${POD_NAME:-no_pod_name_set}_${POD_NAMESPACE:-no_pod_namespace_set}_${POD_IP:-no_pod_ip_set}_unknown_unknown

#  assumes /log-pointer is an emptyDir mount shared between the containers
ln -s /hostlogs/${POD_NAME:-no_pod_name_set}_${POD_NAMESPACE:-no_pod_namespace_set}_${POD_IP:-no_pod_ip_set}_unknown_unknown /log-pointer/application
