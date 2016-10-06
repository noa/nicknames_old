#! /usr/bin/env bash

set -e

TRAIN="data/conll/eng/train.utf8"
VALID="data/conll/eng/valid.utf8"

NTRAIN="--nTrain 50"
NVALID="--nValid 250"
NFOLD="--nTrainFold 5"
NREPL="--nReplication 3"

export MPLBACKEND="Agg"

FILE="en_nogaz.png"
if [ ! -f $FILE ]; then
    scripts/replications.py $TRAIN $VALID --baseline $NTRAIN $NVALID --nGaz 1 $NFOLD $NREPL
    scripts/plot_f1_seaborn.py baseline.dat model.dat --output $FILE
fi

#declare -a arr=(1 10 100)
declare -a arr=(10)
for size in "${arr[@]}"
do
    echo "gazetteer size: $size"
    scripts/replications.py $TRAIN $VALID --delta $NTRAIN $NVALID --nGaz $size $NFOLD $NREPL
    cp delta.dat en_delta_$size.dat
    cp model.dat en_model_$size.dat
done

scripts/plot_f1_seaborn.py en_delta_*.dat --output en_gaz_delta.png

# eof
