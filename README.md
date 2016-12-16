# shared-logging-directory
docker image that prepares a shared logging directory

## Usage
This docker image expects to be run as an init container as part of a kubernetes
pod specification.  

## Requirements
There should be two volumes mounted into this container. 

1. is an emptyDir volume mount that will be shared between this container and the application container. 
This volume should be mounted at /log-pointer. If it is not, the script directory-prep.sh will fail.  
This volume can be mounted anywhere that is convenient for the application.

2. is a hostVolume mount that will be shared between this container, the application
container, all other application pods on this host and the aggregator daemon set pod
on this node.  This volume should be mounted at /hostlogs.  If it is not, the script
directory-prep.sh will fail.  This volume also needs to be mounted into the
application container at /hostlogs.  

3. the following environment variables should be set from the downward API:
  a. POD_NAME = metadata.name
  b. POD_NAMESPACE = metadata.namespace
  c. POD_IP = status.podIP

## What does this image do
This image performs two actions:

1. creates a globally unique directory in the hostVolume mount that is specific for 
this application pod.

2. creates a symbolic link from the emtpyDir volume to the unique directory.  this 
symbolic link is the same for all applications, only its target is different.

## Why are we doing this
This indirection gives us two important attributes:

1. a globally unique location for a specific pod's application logs

2. a globally common location for a specific pod to write their application logs to
This combination of attributes is essential for a central logging system as it allows
us to build something which can easily differentiate logs between instances of an
application and allows us to configure all pods of an application the same way.  eg 
we don't need to build kubernetes logging awareness into each application.
