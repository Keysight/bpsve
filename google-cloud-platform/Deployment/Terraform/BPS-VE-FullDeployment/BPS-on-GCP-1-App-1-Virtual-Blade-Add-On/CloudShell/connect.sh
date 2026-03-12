#!/bin/bash

while getopts n:z:p: flag
do
    case "${flag}" in
        n) InstanceName=${OPTARG};;
		z) Zone=${OPTARG};;
		p) ProjectId=${OPTARG};;
    esac
done

# Connect
gcloud compute ssh $InstanceName \
  --zone=$Zone \
  --project=$ProjectId \
  --tunnel-through-iap