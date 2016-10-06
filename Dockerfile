FROM ubuntu:16.10

RUN apt-get update -y && apt-get install -y build-essential git cmake libgsl0-dev libboost-dev libboost-serialization-dev libboost-iostreams-dev libboost-program-options-dev libboost-filesystem-dev libboost-system-dev libboost-thread-dev libboost-timer-dev libboost-date-time-dev libgflags-dev libgoogle-glog-dev

RUN git clone https://github.com/noa/nicknames.git

RUN cd nicknames && git submodule init && git submodule update && mkdir build && cd build && cmake .. && make
