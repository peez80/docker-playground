#Prepare packeges etc.
apt-get update
sysctl net.bridge.bridge-nf-call-iptables=1
apt-get install -y ebtables ethtool
        sudo apt-get install -y apt-transport-https
        sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -                
        sudo /bin/su -c "echo 'deb http://apt.kubernetes.io/ kubernetes-xenial main' >/etc/apt/sources.list.d/kubernetes.list"
        sudo apt-get update
        sudo apt-get install -y kubelet kubeadm kubectl
        
#setup kubernetes with kubeadm                
# -------------------------------------------------------
kubeadm init
        
# Copy Kubernetes auth data to user home
sudo mkdir -p /home/ubuntu/.kube
sudo cp -i /etc/kubernetes/admin.conf /home/ubuntu/.kube/config
sudo chown -R ubuntu:ubuntu /home/ubuntu/.kube

# ------------------------------------------------

