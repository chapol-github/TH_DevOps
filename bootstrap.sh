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
kubeadm init --apiserver-advertise-address $(hostname -i)
mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

 kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

