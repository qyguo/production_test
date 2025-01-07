#!/bin/bash
#dir_used=loop_sm_g_induced_unweighted_events_xqcut20
echo "Starting job on `data`\n" #Data/time of start of job
echo "Running on: `uname -a`\n" #Condor job is running on this node
echo "System software: `cat /etc/redhat-release`\n" #Operating System on that node

#source /afs/cern.ch/cms/cmsset_default.sh
source /cvmfs/cms.cern.ch/cmsset_default.sh
#source /cvmfs/sft.cern.ch/lcg/views/LCG_102rc1/x86_64-centos7-gcc11-opt/setup.sh
#source /cvmfs/sft.cern.ch/lcg/releases/ROOT/6.26.00-165a8/x86_64-centos7-gcc11-opt/bin/thisroot.sh
#export SCRAM_ARCH=slc7_amd64_gcc10
#source /cvmfs/sft.cern.ch/lcg/views/LCG_105/x86_64-el9-gcc11-opt/setup.sh
#export SCRAM_ARCH=el8_amd64_gcc10
export SCRAM_ARCH=slc7_amd64_gcc700

cd /afs/cern.ch/work/q/qguo/check6/
pwd
cd ${2}/src/
cmssw-el7
#eval `scram runtime -sh`
cmsenv
#scram b

export X509_USER_PROXY=$4
voms-proxy-info -all
voms-proxy-info -all -file $4

cd ../../
cd ${1}
dir_name=${1}
file_name=${dir_name/wmLHEGEN/${3}}_cfg.py
cmsRun ${file_name}

#output_path=/eos/user/q/qguo/vbfhmm/production

#export X509_USER_PROXY=$1
#voms-proxy-info -all
#voms-proxy-info -all -file $1
#
#
#./vbfhmm_config_run3_Inc_data_2022 ${2}/${out_name} $3
