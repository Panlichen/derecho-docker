#! /bin/bash
for ip in $(cat /home1/root/derecho-docker/tools/ip_nodes)
do
    for image in $(cat /home1/root/derecho-docker/tools/images)
    do
        ssh $ip "hostname && echo $image"
        ssh $ip "docker pull $image" &
    done
    echo "======================="
    echo "***********************"
    echo "======================="
done