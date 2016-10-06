# nicknames

## Compiling the source code

### Docker image

The Dockerfile shows steps needed to build under a clean Ubuntu 16.10
install. To build the Docker image:

``` shell
sudo docker build -t nn .
```

Alternatively, see the steps below for a native build.

### System build

Install dependencies (minimum version):

1. GCC (5)
2. git
3. cmake (3)
4. GSL (2.2)
5. boost (1.6)

Build using CMake:

``` shell
$ mkdir build
$ cd build
$ cmake ..
$ make -j `grep -c ^processor /proc/cpuinfo`
```

Add the resulting executable `nname` to your path:

``` shell
export PATH=$PATH:`pwd`/build/src/cli
```

or move `nname` to a location already on the path. Check you can
run it:

``` shell
nname --help
```

## Example usage

### Basic supervised training

The `run_expt_smc.sh` script demonstrates basic supervised
training. This script simply serves a convenience wrapper around
`nname`:

``` shell
scripts/run_expt_smc.sh data/conll/eng/train.utf8 data/conll/eng/valid.utf8 /dev/null
```

The final optional argument is a gazetteer (also in CoNLL format),
which is an empty file above. The command-line interface `nname` may
also be used directly; see `nname --help` for options.

### Training with randomized token- and type-level annotation

*Prerequisites*: Python 3 along with the following Python packages:

1. seaborn
2. NLTK
3. progressbar2
4. numpy
5. scipy

We now give a more involved example which compares generative and
discriminative approaches to incorporating gazetteers. This experiment
requires a discriminative baseline; we use the Stanford NER toolkit
for this purpose. To download the toolkit:

``` shell
$ wget http://nlp.stanford.edu/software/stanford-ner-2015-12-09.zip && unzip *.zip
```

An example properties file is provided under `config/features.prop`,
copy this to the baseline path:

``` shell
$ cp config/features.prop stanford-ner-2015-12-09/
```

Now run the experimental suite via `scripts/gen_gaz_plots.sh`, which
calls `scripts/replications.py` with the English CoNLL data. This will
save plots summarizing the results in PNG format.
