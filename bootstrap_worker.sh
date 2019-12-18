#!/bin/bash
swapoff -a
cp kubernetes.repo /etc/yum.repos.d/
yum -y install docker kubeadm
systemctl start docker && systemctl enable docker
systemctl start kubelet && systemctl enable kubelet
firewall-cmd --permanent --add-port=6443/tcp
firewall-cmd --permanent --add-port=10250/tcp
firewall-cmd --reload
echo '1' > /proc/sys/net/bridge/bridge-nf-call-iptables

kubeadm join 192.168.2.1:6443 --token pxavv6.zwqgdlivwfgbaaud --discovery-token-ca-cert-hash sha256:0cd1e77fd1514a6ec60e3c67c678c0d88ac80b18ff8184271ecef1ccdc01ee55

