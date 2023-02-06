#!/bin/bash
set -x

export PREVIOUS_CLUSTER=""
export IBMCLOUD_API_KEY=""
for i in 9
do
        #sleep 30
        #TF_LOG=debug openshift-install destroy  cluster --log-level=debug --dir $PREVIOUS_CLUSTER  | tee log.log

        ibmcloud login

        #lon06 instance
        ibmcloud pi st <instance crn>

        CLOUD_CONNECTION=$(ibmcloud pi cons | awk "(NR>1)" | tail -n 1 | awk '{print $1}')

        if [ -n "$CLOUD_CONNECTION" ]
        then
                ibmcloud pi cond $CLOUD_CONNECTION
        fi

        ic pi nets |awk "(NR>1)"  |awk '{print $1}' > networks.txt
        while read p ; do ibmcloud pi netd $p; done< networks.txt

        ic pi cons

        ic pi nets

        export IBMCLOUD_API_KEY=""
        export IBMCLOUD_OCCMICCC_API_KEY=""
        export IBMCLOUD_OIOCCC_API_KEY=""
        export IBMCLOUD_OMAPCC_API_KEY=""
        export IBMCLOUD_OCCDIPCCC_API_KEY=""
        export CLUSTER_DIR="/root/qe-account/ocp-syd-jan31-ATTEMPT-${i}"
        export IBMID=""
        export CLUSTER_NAME="rdr-ipi-ocp${i}-pravin"
        export POWERVS_REGION=""
        export POWERVS_ZONE=""
        export SERVICE_INSTANCE_GUID=""
        export VPCREGION=""
        export RESOURCE_GROUP=""
        export BASEDOMAIN="rdr-pravin-dns.com"
        export JENKINS_TOKEN=""

        /root/powervs-hack/scripts/create-cluster-internal.sh 2>&1 | tee output-errors-syd-ATTEMPT-${i}.txt

        PREVIOUS_CLUSTER=$CLUSTER_DIR
        rm -rf networks.txt
done
