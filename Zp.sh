input_string=$1
echo "You are running with step", ${input_string}


# Check if the input argument is provided
if [ -z "$input_string" ]; then
    echo "No argument provided. Please provide an argument when running this script."
    echo "Step1 wmLHEGEN"
    echo "Step2 SIM"
    echo "Step3 DIGIPremix"
    echo "Step4 HLT"
    echo "Step5 RECO"
    echo "Step6 MiniAODv2"
    echo "Step7 NanoAODv9"
    echo "Running DIGIPremix, do not forget to init proxy in the job.sh"
    echo "Running HLT, CMSSW_10_2_16_UL"
    echo "Running MiniAODv2, CMSSW_10_6_20"
    echo "Running NanoAODv9, CMSSW_10_6_26"
    exit 1
fi

# Define allowed values
allowed_values=" 1 2 3 4 5 6 7 "

# Check if the provided argument is in the list of allowed values
if [[ ! $allowed_values =~ " $1 " ]]; then
    echo "Invalid input: $1. Allowed inputs are 1, 2, 3, 4, 5, 6, 7."
    exit 1
fi

# Declare an associative array
declare -A step_name

# Define mappings
step_name[1]="wmLHEGEN"
step_name[2]="SIM"
step_name[3]="DIGIPremix"
step_name[4]="HLT"
step_name[5]="RECO"
step_name[6]="MiniAODv2"
step_name[7]="NanoAODv9"

name=${step_name[$input_string]}

# Create directories based on the mappings
for key in "${!step_name[@]}"; do
    mkdir -p "${step_name[$key]}"
    echo "step ${key}: ${step_name[$key]}"
done


dir_name_0=Wp60_
dir_name_0=Wm60_
dir_name_0=Wm5_
if [ "$name" == "wmLHEGEN" ]; then
    for i in `seq 1 1 100`;
    do
        #mkdir VBFHto2Mu_M-125_powheg-Herwig7_1_${i}
        dir_name=${dir_name_0}wmLHEGEN_${i}
        #rm -rf ${dir_name}
        mkdir ${dir_name}
        file_name=${dir_name}_cfg.py
        echo "cp ${dir_name_0}wmLHEGEN.py ${file_name}"
        echo "sed -i \"57,67s/.root/_${i}.root/\" ${file_name}"
        #echo "sed -i \"88,98s|file:HIG|file:/eos/user/q/qguo/vbfhmm/production/HIG|\" ${file_name}"
    
        cp ${dir_name_0}wmLHEGEN.py ${file_name}
        sed -i "57,67s/.root/_${i}.root/" ${file_name}
    
        mv ${file_name} ${dir_name}/
    done
fi
#for i in $(seq 1 1 50); do     printf "input_name = WmToZpTotau2munu_M20_20UL18wmLHEGEN_%s\nQueue\n" "$i" >> Job_run3_2.sub ; done


if [ "$name" == "SIM" ]; then
    for i in `seq 1 1 100`;
    do
        #mkdir VBFHto2Mu_M-125_powheg-Herwig7_1_${i}
        dir_name=${dir_name_0}wmLHEGEN_${i}
        echo ${dir_name}
        #rm -rf ${dir_name}
        #mkdir ${dir_name}
        #file_name=${dir_name}_cfg.py
        #file_name=${dir_name/wmLHEGEN/SIM}_cfg.py
        file_name=${dir_name_0}${name}_${i}_cfg.py
        echo "cp ${dir_name_0}${name}.py ${file_name}"
        echo "sed -i \"31,56s/.root/_${i}.root/\" ${file_name}"
        #echo "sed -i \"88,98s|file:HIG|file:/eos/user/q/qguo/vbfhmm/production/HIG|\" ${file_name}"
    
        cp ${dir_name_0}${name}.py ${file_name}
        sed -i "31,56s/.root/_${i}.root/" ${file_name}
    
        mv ${file_name} ${dir_name}/
    done
fi

if [ "$name" == "DIGIPremix" ]; then
    for i in `seq 4 1 100`;
    do
        #mkdir VBFHto2Mu_M-125_powheg-Herwig7_1_${i}
        dir_name=${dir_name_0}wmLHEGEN_${i}
        echo ${dir_name}
        #rm -rf ${dir_name}
        #mkdir ${dir_name}
        #file_name=${dir_name}_cfg.py
        #file_name=${dir_name/wmLHEGEN/SIM}_cfg.py
        file_name=${dir_name_0}${name}_${i}_cfg.py
        echo "cp ${dir_name_0}${name}.py ${file_name}"
        echo "sed -i \"35,76s/.root/_${i}.root/\" ${file_name}"
    
        cp ${dir_name_0}${name}.py ${file_name}
        sed -i "35,76s/.root/_${i}.root/" ${file_name}
    
        mv ${file_name} ${dir_name}/
    done
fi

if [ "$name" == "HLT" ]; then
    for i in `seq 4 1 100`;
    do
        #mkdir VBFHto2Mu_M-125_powheg-Herwig7_1_${i}
        dir_name=${dir_name_0}wmLHEGEN_${i}
        echo ${dir_name}
        #rm -rf ${dir_name}
        #mkdir ${dir_name}
        #file_name=${dir_name}_cfg.py
        #file_name=${dir_name/wmLHEGEN/SIM}_cfg.py
        file_name=${dir_name_0}${name}_${i}_cfg.py
        echo "cp ${dir_name_0}${name}.py ${file_name}"
        echo "sed -i \"30,55s/.root/_${i}.root/\" ${file_name}"
    
        cp ${dir_name_0}${name}.py ${file_name}
        sed -i "30,55s/.root/_${i}.root/" ${file_name}
    
        mv ${file_name} ${dir_name}/
    done
fi

if [ "$name" == "RECO" ]; then
    for i in `seq 4 1 100`;
    do
        dir_name=${dir_name_0}wmLHEGEN_${i}
        echo ${dir_name}
        file_name=${dir_name_0}${name}_${i}_cfg.py
        echo "cp ${dir_name_0}${name}.py ${file_name}"
        echo "sed -i \"34,59s/.root/_${i}.root/\" ${file_name}"
        cp ${dir_name_0}${name}.py ${file_name}
        sed -i "34,59s/.root/_${i}.root/" ${file_name}
        mv ${file_name} ${dir_name}/
    done
fi

if [ "$name" == "MiniAODv2" ]; then
    for i in `seq 4 1 100`;
    do
        dir_name=${dir_name_0}wmLHEGEN_${i}
        echo ${dir_name}
        file_name=${dir_name_0}${name}_${i}_cfg.py
        echo "cp ${dir_name_0}${name}.py ${file_name}"
        echo "sed -i \"32,59s/.root/_${i}.root/\" ${file_name}"
        cp ${dir_name_0}${name}.py ${file_name}
        sed -i "32,59s/.root/_${i}.root/" ${file_name}
        mv ${file_name} ${dir_name}/
    done
fi

if [ "$name" == "NanoAODv9" ]; then
    for i in `seq 4 1 100`;
    do
        dir_name=${dir_name_0}wmLHEGEN_${i}
        echo ${dir_name}
        file_name=${dir_name_0}${name}_${i}_cfg.py
        echo "cp ${dir_name_0}${name}.py ${file_name}"
        echo "sed -i \"31,55s/.root/_${i}.root/\" ${file_name}"
        cp ${dir_name_0}${name}.py ${file_name}
        sed -i "31,55s/.root/_${i}.root/" ${file_name}
        mv ${file_name} ${dir_name}/
    done
fi


echo "Running DIGIPremix, do not forget to init proxy in the job.sh"
echo "Running HLT, CMSSW_10_2_16_UL"
echo "Running MiniAODv2, CMSSW_10_6_20"
echo "Running NanoAODv9, CMSSW_10_6_26"

