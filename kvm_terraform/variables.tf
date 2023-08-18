variable "POOL_NAME" {
    type    = string
    default = "kvm_pool"

}

variable "VOL_NAME" {
    type    = string
    default = "sda1"

}

variable "VOL_DESTINY" {
   type    = string
   default = "/modelos/libvirt-volumes/"
}

variable "NFS_DESTINY" {
   type    = string
   default = "/storage/libvirt-volumes/"
}


variable "IMG_SOURCE" {
   type    = string
   #default = "/storage/ubuntu_core/focal-server-cloudimg-amd64.img"
   default = "/tfdata/ubuntu-core/jammy-server-cloudimg-amd64.img"
}

variable "MEMORY_SIZE" {
    type = string  
    default = 1024*2 
}
variable "VCPU_SIZE" {
    type = number
    default = 2
}

variable "VM_USER" {
    type = string 
    default = "suporte"
}

variable "vms" {
    type = list
    default = ["node-1", "node-2"]
}

variable "VM_IMG_URL" {
    type    = string
    default = "https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img"
}
variable "VM_VOLUME_SIZE" {
    type    = number
    default = 1024*1024*1024*5
}

variable "VM_IMG_FORMAT" {
    type = string
    default = "qcow2"
}

variable "VM_CIDR_RANGE" {
    type = string
    default = "192.168.1.0/24"
}


variable "ssh_key" {
    type    = string
    default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCeLRfOtHYsWVXbkU/3+7VUE5J024YS6fTAkzAaFuwWlln9za5EQ4kzoSJmcsY+53WsLJZY7VUG4vNQiHvGh4Qb5mmQm+oj1Unr2eZ8rqTfCwgO8NWeQfSjAveB9IDGENXhKvB/OgG9MtGXFdvMaDs0scfa/0k6q08UgL35yG/F++LU5vW/jUzuIWaH9S92rnwR8/mMToEnS1Yc9XZlVCaxU3IKzdeQZO45dYWLfkHL7mQwFMK8xAtTqzwKt/fnmX17EHvTyMtVYZC8HR5V41IXMTBuhBaFDupE5tNcQzM46o5dabR/dWIReejYoL3Dm28ZVUcE6jsgqG+2bvBvzKD0E1EuQg9/OHTyNDmM3qafFZsOx1SqGoBP2JR5laYbCSB1WEyfXuc4+rHV7k+2nTcHNAQFYIwhsxKKPxTuxvAgJv8Qoz7bbHHLlfoEpAn5fDth+2s/yobDTB+pO4J1Bd8YY7xMS0ZMX2fJLf5j9HCe5safKFszOpMMIF3zGAkUWMk= ekarani@laptop-ekarani"
}

variable "auth_access" {
    type    = bool
    default = true 
}

variable "network" {
  type    = string
  default = "network-name"
}

variable "interface" {
  type    = string
  default = "ens3"
}


variable "disk" {
  type    = number
  default = 10737418240
}


variable "mac-address" {

  type    = list
  default = ["52:54:00:02:d9:80", "52:54:00:5e:04:67"]

}


