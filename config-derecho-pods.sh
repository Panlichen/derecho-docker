#! /bin/bash

# get pod ips and names
kubectl -n derecho-workspace get pod -o wide | cat > info.txt 
IPs=`awk '/derecho/ {print $6}' info.txt`
PODs=`awk '/derecho/ {print $1}' info.txt`
IP_ARRAY=()
POD_ARRAY=()

LEADER_IP=""
# add support to config provider
echo "Usage: $0 <leader ip> <local ip> <local id> [provider,default to 'sockets', can also use 'verbs'] [domain,default to 'eth0']"

PROVIDER=$1
if [ -z $PROVIDER ]; then
  PROVIDER='sockets'
fi
DOMAIN=$2
if [ -z $DOMAIN ]; then
  DOMAIN='eth0'
fi

# set first pod to be leader; store pod ips and names into array
idx=0
for IP in ${IPs}
do 
  if [ ${idx} = 0 ]; then
    LEADER_IP=${IP}
  fi
  IP_ARRAY[${idx}]=$IP
  idx=$[idx+1]
done
idx=0
for POD in ${PODs}
do 
  POD_ARRAY[${idx}]=$POD
  idx=$[idx+1]
done

for (( i=0; i<${#IP_ARRAY[*]}; i++ )); do
  echo "provider is ${PROVIDER}"
  echo "domain is ${DOMAIN}"
  echo "kubectl -n derecho-workspace exec -it ${POD_ARRAY[${i}]} \
  -- /root/config/config-derecho.sh ${LEADER_IP} ${IP_ARRAY[${i}]} ${i} ${PROVIDER} ${DOMAIN}"
  kubectl -n derecho-workspace exec -it ${POD_ARRAY[${i}]} \
  -- /root/config/config-derecho.sh ${LEADER_IP} ${IP_ARRAY[${i}]} ${i} ${PROVIDER} ${DOMAIN}
done

rm info.txt