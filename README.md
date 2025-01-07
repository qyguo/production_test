SampleName=AAAA
outputPath=/A/B/C/

export SCRAM_ARCH=slc7_amd64_gcc700

source /cvmfs/cms.cern.ch/cmsset_default.sh
if [ -r CMSSW_10_6_17_patch1/src ] ; then
  echo release CMSSW_10_6_17_patch1 already exists
else
  scram p CMSSW CMSSW_10_6_17_patch1
fi
cd CMSSW_10_6_17_patch1/src
eval `scram runtime -sh`

mv ../../Configuration .
scram b
cd ../..


EVENTS=500


# cmsDriver command
# wmLHEGEN
cmsDriver.py Configuration/GenProduction/python/${SampleName}_wmLHEGEN-fragment.py --python_filename ${SampleName}_wmLHEGEN_cfg.py --eventcontent RAWSIM,LHE --customise Configuration/DataProcessing/Utils.addMonitoring --datatier GEN,LHE --fileout file:${outputPath}${SampleName}_20UL18wmLHEGEN.root --conditions 106X_upgrade2018_realistic_v4 --beamspot Realistic25ns13TeVEarly2018Collision --step LHE,GEN --geometry DB:Extended --era Run2_2018 --no_exec --mc -n $EVENTS || exit $? ;
#####seed random number adding in case the duplicated production
printf "from IOMC.RandomEngine.RandomServiceHelper import RandomNumberServiceHelper\nrandSvc = RandomNumberServiceHelper(process.RandomNumberGeneratorService)\nrandSvc.populate()\n" >> ${SampleName}_wmLHEGEN_cfg.py 
#from IOMC.RandomEngine.RandomServiceHelper import RandomNumberServiceHelper
#randSvc = RandomNumberServiceHelper(process.RandomNumberGeneratorService)
#randSvc.populate()

# SIM
cmsDriver.py  --python_filename ${SampleName}_SIM_cfg.py --eventcontent RAWSIM --customise Configuration/DataProcessing/Utils.addMonitoring --datatier GEN-SIM --fileout file:${outputPath}${SampleName}_20UL18SIM.root --conditions 106X_upgrade2018_realistic_v11_L1v1 --beamspot Realistic25ns13TeVEarly2018Collision --step SIM --geometry DB:Extended --filein file:${outputPath}${SampleName}_20UL18wmLHEGEN.root  --era Run2_2018 --runUnscheduled --no_exec --mc -n $EVENTS || exit $? ;
# DIGIPremix
cmsDriver.py  --python_filename ${SampleName}_DIGIPremix_cfg.py --eventcontent PREMIXRAW --customise Configuration/DataProcessing/Utils.addMonitoring --datatier GEN-SIM-DIGI --fileout file:${outputPath}${SampleName}_20UL18DIGIPremix.root --pileup_input "dbs:/Neutrino_E-10_gun/RunIISummer20ULPrePremix-UL18_106X_upgrade2018_realistic_v11_L1v1-v2/PREMIX" --conditions 106X_upgrade2018_realistic_v11_L1v1 --step DIGI,DATAMIX,L1,DIGI2RAW --procModifiers premix_stage2 --geometry DB:Extended --filein file:${outputPath}${SampleName}_20UL18SIM.root --datamix PreMix --era Run2_2018 --runUnscheduled --no_exec --mc -n $EVENTS || exit $? ;


# HLT
export SCRAM_ARCH=slc7_amd64_gcc700

source /cvmfs/cms.cern.ch/cmsset_default.sh
if [ -r CMSSW_10_2_16_UL/src ] ; then
  echo release CMSSW_10_2_16_UL already exists
else
  scram p CMSSW CMSSW_10_2_16_UL
fi
cd CMSSW_10_2_16_UL/src
eval `scram runtime -sh`

mv ../../Configuration .
scram b
cd ../..

# HLT
cmsDriver.py  --python_filename ${SampleName}_HLT_cfg.py --eventcontent RAWSIM --customise Configuration/DataProcessing/Utils.addMonitoring --datatier GEN-SIM-RAW --fileout file:${outputPath}${SampleName}_20UL18HLT.root --conditions 102X_upgrade2018_realistic_v15 --customise_commands 'process.source.bypassVersionCheck = cms.untracked.bool(True)' --step HLT:2018v32 --geometry DB:Extended --filein file:${outputPath}${SampleName}_20UL18DIGIPremix.root --era Run2_2018 --no_exec --mc -n $EVENTS || exit $? ;

# RECO CMSSW_10_6_17_patch1
cmsDriver.py  --python_filename ${SampleName}_RECO_cfg.py --eventcontent AODSIM --customise Configuration/DataProcessing/Utils.addMonitoring --datatier AODSIM --fileout file:${outputPath}${SampleName}_20UL18RECO.root --conditions 106X_upgrade2018_realistic_v11_L1v1 --step RAW2DIGI,L1Reco,RECO,RECOSIM,EI --geometry DB:Extended --filein file:${outputPath}${SampleName}_20UL18HLT.root --era Run2_2018 --runUnscheduled --no_exec --mc -n $EVENTS || exit $? ;


# MiniAODv2
export SCRAM_ARCH=slc7_amd64_gcc700

source /cvmfs/cms.cern.ch/cmsset_default.sh
if [ -r CMSSW_10_6_20/src ] ; then
  echo release CMSSW_10_6_20 already exists
else
  scram p CMSSW CMSSW_10_6_20
fi
cd CMSSW_10_6_20/src
eval `scram runtime -sh`

mv ../../Configuration .
scram b
cd ../..

# MiniAODv2
cmsDriver.py  --python_filename ${SampleName}_MiniAODv2_cfg.py --eventcontent MINIAODSIM --customise Configuration/DataProcessing/Utils.addMonitoring --datatier MINIAODSIM --fileout file:${outputPath}${SampleName}_20UL18MiniAODv2.root --conditions 106X_upgrade2018_realistic_v16_L1v1 --step PAT --procModifiers run2_miniAOD_UL --geometry DB:Extended --filein file:${outputPath}${SampleName}_20UL18RECO.root --era Run2_2018 --runUnscheduled --no_exec --mc -n $EVENTS || exit $? ;

# NanoAODv9
export SCRAM_ARCH=slc7_amd64_gcc700

source /cvmfs/cms.cern.ch/cmsset_default.sh
if [ -r CMSSW_10_6_26/src ] ; then
  echo release CMSSW_10_6_26 already exists
else
  scram p CMSSW CMSSW_10_6_26
fi
cd CMSSW_10_6_26/src
eval `scram runtime -sh`

mv ../../Configuration .
scram b
cd ../..

# NanoAODv9
cmsDriver.py  --python_filename ${SampleName}_NanoAODv9_cfg.py --eventcontent NANOAODSIM --customise Configuration/DataProcessing/Utils.addMonitoring --datatier NANOAODSIM --fileout file:${outputPath}${SampleName}_20UL18NanoAODv9.root --conditions 106X_upgrade2018_realistic_v16_L1v1 --step NANO --filein file:${outputPath}${SampleName}_20UL18MiniAODv2.root --era Run2_2018,run2_nanoAOD_106Xv2 --no_exec --mc -n $EVENTS || exit $? ;




######Based on the produced cfg file
run the Zp.sh please remember to change the name inside~
so that would generate the dir and cfg for the condor for seperate production

