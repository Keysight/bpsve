#!/bin/bash

# Input Argument Processing
ARGV_REGION_NAME="us-central1"
ARGV_LOGIN_ID_TAG="gcp-ixia"
ARGV_PROJECT_TAG="open-ixia-gcp-bps"
ARGV_VERBOSE_OUTPUT="true"
ARGV_OTHER_ARGUMENTS=()


# Loop through arguments and process them
for arg in "$@"
do
    case $arg in
        --region-name=*)
        ARGV_REGION_NAME="${arg#*=}"
        shift # Remove from processing
        ;;
        --login-id-tag=*)
        ARGV_LOGIN_ID_TAG="${arg#*=}"
        shift # Remove from processing
        ;;
        --project-tag=*)
        ARGV_PROJECT_TAG="${arg#*=}"
        shift # Remove from processing
        ;;        --verbose-output=*)
        ARGV_VERBOSE_OUTPUT="${arg#*=}"
        shift # Remove from processing
        ;;
        *)
        ARGV_OTHER_ARGUMENTS+=("$1")
        shift # Remove from processing
        ;;
    esac
done


# Variable Initialization
GCP_REGION_NAME=$ARGV_REGION_NAME
GCP_ZONE_NAME="$GCP_REGION_NAME-a"
GCP_LOGIN_ID_TAG=$ARGV_LOGIN_ID_TAG
GCP_PROJECT_TAG=$ARGV_PROJECT_TAG

GCP_VERBOSE_OUTPUT=$ARGV_VERBOSE_OUTPUT
#
GCP_TEST1_VPC_NETWORK_NAME="$GCP_LOGIN_ID_TAG-$GCP_PROJECT_TAG-test-01-vpc-network"
GCP_TEST1_VPC_NETWORK_PEER_NAME="$GCP_LOGIN_ID_TAG-$GCP_PROJECT_TAG-test-01-vpc-network-peer"
#
GCP_TEST2_VPC_NETWORK_NAME="$GCP_LOGIN_ID_TAG-$GCP_PROJECT_TAG-test-02-vpc-network"
GCP_TEST2_VPC_NETWORK_PEER_NAME="$GCP_LOGIN_ID_TAG-$GCP_PROJECT_TAG-test-02-vpc-network-peer"


# Variable Logging
if [ "$GCP_VERBOSE_OUTPUT" == "true" ];
then
echo "% GCP_REGION_NAME=$GCP_REGION_NAME"
echo "% GCP_ZONE_NAME=$GCP_ZONE_NAME"
echo "% GCP_LOGIN_ID_TAG=$GCP_LOGIN_ID_TAG"
echo "% GCP_PROJECT_TAG=$GCP_PROJECT_TAG"
echo "%"
echo "% GCP_TEST1_VPC_NETWORK_NAME=$GCP_TEST1_VPC_NETWORK_NAME"
echo "% GCP_TEST1_VPC_NETWORK_PEER_NAME=$GCP_TEST1_VPC_NETWORK_PEER_NAME"
echo "%"
echo "% GCP_TEST2_VPC_NETWORK_NAME=$GCP_TEST2_VPC_NETWORK_NAME"
echo "% GCP_TEST2_VPC_NETWORK_PEER_NAME=$GCP_TEST2_VPC_NETWORK_PEER_NAME"
echo "%"
fi


# VPC Network Peering Cleanup
if [ "$GCP_VERBOSE_OUTPUT" == "true" ];
then
echo -e "% gcloud compute networks peerings delete $GCP_TEST1_VPC_NETWORK_PEER_NAME\n\
%	--network=$GCP_TEST1_VPC_NETWORK_NAME\n\
%	--quiet\n"
fi
gcloud compute networks peerings delete $GCP_TEST1_VPC_NETWORK_PEER_NAME \
	--network=$GCP_TEST1_VPC_NETWORK_NAME \
	--quiet

if [ "$GCP_VERBOSE_OUTPUT" == "true" ];
then
echo -e "% gcloud compute networks peerings delete $GCP_TEST2_VPC_NETWORK_PEER_NAME\n\
%	--network=$GCP_TEST2_VPC_NETWORK_NAME\n\
%	--quiet\n"
fi
gcloud compute networks peerings delete $GCP_TEST2_VPC_NETWORK_PEER_NAME \
	--network=$GCP_TEST2_VPC_NETWORK_NAME \
	--quiet
#eof