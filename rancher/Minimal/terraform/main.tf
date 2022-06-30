resource "rke_cluster" "cluster" {
  nodes {
    address = "192.168.56.4"
    user    = "vagrant"
    role    = ["controlplane", "worker", "etcd"]
    ssh_key = "${file("/home/zaz/rancher/Minimal-0/Infra/.vagrant/machines/default/virtualbox/private_key")}"
  }
}

resource "local_file" "kube_cluster_yaml" {
  filename = "${path.root}/kube_config_cluster.yml"
  sensitive_content  = "${rke_cluster.cluster.kube_config_yaml}"
}

provider "kubernetes" {
  host     = rke_cluster.cluster.api_server_url
  username = rke_cluster.cluster.kube_admin_user

  client_certificate     = rke_cluster.cluster.client_cert
  client_key             = rke_cluster.cluster.client_key
  cluster_ca_certificate = rke_cluster.cluster.ca_crt
}

resource "kubernetes_namespace" "jenkins" {
  metadata {
    name = "jenkins"
  }
}

