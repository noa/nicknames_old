# nicknames

## Compiling the source code

### Docker image

``` shell
sudo docker build -t nn .
```

### System build

First, install dependencies (minimum version shown):

1. GCC (5)
2. git
3. cmake (3)
4. GSL (2.2)
5. boost (1.6)

Then build using CMake:

``` shell
$ mkdir build
$ cd build
$ cmake ..
$ make -j `grep -c ^processor /proc/cpuinfo`
```

To add the resulting executable `nname` to your path, run

``` shell
export PATH=$PATH:`pwd`/build/src/cli
```

or move `nname` to a location already on the path. Then check you can
run it:

``` shell
nname --help
```

## Example usage
