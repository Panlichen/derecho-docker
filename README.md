# derecho-docker
This project provides a docker container image for testing and developing software with (Derecho)[https://github.com/Derecho-Project/derecho-unified]. Derecho is an open-source C++ distributed computing toolkit that provides strong forms of distributed coordination and consistency at RDMA speeds. Thanks to hardware compatible design in Derecho, you can develop or test it without real RDMA hardware.

# To build the image :

clone the repo at: https://github.com/songweijia/derecho-docker.git.
cd into the directory derecho-dev and give command [It may take around 3~5 min depending on network throughput]
```
$ docker build -t derecho-dev .
```
or 
```
$ docker build -t derecho-dev https://github.com/songweijia/derecho-docker.git#:derecho-dev
```
# To run the image and build Derecho source code:
```
$ docker run -it derecho-dev /bin/bash
```
Then, move to home directory(/root/)
```
$ cd ~
```
Now, pull the derecho source code and buid it [It may take around 6~10 min depending on computer performance]:
```
$ build-derecho.sh Release
```
By default, `build-derecho.sh` build a pre-release commit in master branch. You can specify another branch, e.g. `persistent-delta` as following:
```
$ build-derecho.sh Release persistent-delta
```
Please check (derecho project website)[https://github.com/Derecho-Project/derecho-unified] for available branches.

# To configure and run Derecho
A Derecho application composed of multiple nodes talk to each other. Each node is assigned with an integer identifier(ID). One of the nodes, usually node `0`, is designated as the leader when system starts. To start a Derecho node, the Derecho component needs to know who am I and who is the leader. In addition, it needs to know which communication protocol, e.g. TCP/IP or verbs RDMA, and which interfaces to use for talking with other nodes. There are many configuration knobs but
`config-derecho.sh` helps with the minimum configurations to run derecho.

Let's start with the `bandwith_test`, which evaluates the data throughput of a Derecho group. We want to test a small group with two nodes talking to each other using TCP/IP. Let's repeat the previous step to create another container. Now, we `cd` to `/root` in both of the containers. Run `ifconfig` to find their network interface and ip address.
```
# ifconfig eth0
eth0      Link encap:Ethernet  HWaddr 02:42:ac:11:00:02  
          inet addr:172.17.0.2  Bcast:172.17.255.255  Mask:255.255.0.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:651809 errors:0 dropped:0 overruns:0 frame:0
          TX packets:636540 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 
          RX bytes:23729106695 (23.7 GB)  TX bytes:152899589 (152.8 MB)
```
Let's assume that the two containers A and B both use interface `eth0`. A's IP address is `172.17.0.2` and B's IP address is `172.17.0.3`. Let's assign node id `0` to A, and '1' to B. And we designate A as the leader. Then issue the following commond to configure node A:
```
# config-derecho.sh
Usage: /usr/local/bin/config-derecho.sh <leader ip> <local ip> <local id> [provider,default to 'sockets'] [domain,default to 'eth0']
# config-derecho.sh 172.17.0.2 172.17.0.2 0 sockets eth0
Configuration is successfully generated in file: derecho.cfg.
To use this configuration for your experiment, you can either
- copy this file side-by-side to the binary, or
- set the 'DERECHO_CONF_FILE' environment variable to this file:
     # export DERECHO_CONF_FILE=/root/derecho.cfg
```
A configuration file:`derecho.cfg` will be generated in the current folder. Then, let's set the environment variable `DERECHO_CONF_FILE` to point to it:

```
# export DERECHO_CONF_FILE=/root/derecho.cfg
```

Configure B in a similar way:
```
# config-derecho.sh 172.17.0.2 172.17.0.3 1 sockets eth0
Configuration is successfully generated in file: derecho.cfg.
To use this configuration for your experiment, you can either
- copy this file side-by-side to the binary, or
- set the 'DERECHO_CONF_FILE' environment variable to this file:
     # export DERECHO_CONF_FILE=/root/derecho.cfg
# export DERECHO_CONF_FILE=/root/derecho.cfg
```

Now, we are ready to run the experiments. In both A and B, go to the folder containing the binary:
```
# cd derecho-unified/Release/applications/tests/performance_tests/
```
run `bandwidth_test` in both containers:
```
# ./bandwidth_test
Insufficient number of command line arguments
Enter num_nodes, num_senders_selector (0 - all senders, 1 - half senders, 2 - one sender), num_messages, delivery_mode (0 - ordered mode, 1 - unordered mode)
Thank you
[139925796948032] shutdown_polling_thread() begins.
[139925796948032] done with shutdown_polling_thread().
# ./bandwidth_test 2 0 10000 0
[139900766643968] polling thread starts.
Initialized SST and Started Threads
Initialization complete
Finished constructing/joining Group
The order of members is :
0 1 
The persist thread started
Initialized SST and Started Threads
DerechoGroup send thread shutting down
The persist thread is exiting
Failed polling the completion queuePoll completion error with node (id=1). Freezing row 1
Exception in the failure upcall: Potential partitioning event: this node is no longer in the majority and must shut down!
timeout_thread shutting down
Connection listener thread shutting down.
Old View cleanup thread shutting down.
[139900977338432] shutdown_polling_thread() begins.
[139900977338432] joining polling thread.
[139900766643968] polling thread stops.
[139900977338432] done with shutdown_polling_thread().
# 
```
_Plesae ignore the above exception message. This is because one node quits a little bit earlier than the other node, which is detected by the other node._

On the leader node, you can see a file called `data_derecho_bw`, which contains the test results:
```
# cat data_derecho_bw
2 0 10240 16 10000 0 0.0456381
```
The last number is the tested throughput in GByte/Sec. Other numbers are parameters: <number of nodes> <sender selector> <message size> <window size> <number of messages> <delivery_mode>
  
_We are working on adding explanation on the tests._

Note: (Derecho will write group meta data, which we call `views` to disk for fault-tolerance purpose)[https://github.com/Derecho-Project/derecho-unified/issues/82]. For small tests like `bandwidth_test`, we don't need that and it will cause an exception if the old view exists. So, please delete the states (in `.plog` folder) on each node before run a new test.
```
rm -r .plog
```

For more experiments and details on Derecho, please refer to the (Derecho project)[https://github.com/Derecho-Project/derecho-unified].
