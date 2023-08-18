# Inicializando o terraform e indicando o provider do libvirt

terraform {
  required_providers {
    libvirt   = {
      source  = "dmacvicar/libvirt"
      version = "0.7.1"
    }
  }
}

provider "libvirt" {
   uri = "qemu:///system" #destino da vm
}


# Criando o diretório onde os volumes serão alocados

resource "libvirt_pool" "p-ubuntu" {
  name  = "${var.POOL_NAME}"
  type  = "dir"
  path  = "${var.VOL_DESTINY}"
}

# Criando o volume onde todas as vms serão conectadas

resource "libvirt_volume" "sda" {
  count   = length(var.vms)
  name    = "${var.vms[count.index]}_${count.index}"
  pool    = libvirt_pool.p-ubuntu.name
  source  = "${var.IMG_SOURCE}"
  format  = "qcow2"
}


resource "libvirt_volume" "ubuntu-qcow2-resized" {

  count          = length(var.vms)
  name           = "${var.VOL_NAME}_${var.vms[count.index]}-resized.qcow2"
  pool           = libvirt_pool.p-ubuntu.name
  base_volume_id = libvirt_volume.sda[count.index].id
  size           = var.disk
  
}


data "template_file" "user_data" {
  count      = length(var.vms)
  template   = templatefile("${path.module}/templates/user_data.tpl", {
    hostname = var.vms[count.index]
  })
}

resource "libvirt_cloudinit_disk" "cloud_init" {
  count     = length(var.vms) 
  name      = "commoninit_${var.vms[count.index]}.iso"
  pool      = libvirt_pool.p-ubuntu.name
  user_data = "${data.template_file.user_data[count.index].rendered}"

}

resource "libvirt_domain" "ubuntu" {
  count  = length(var.vms)
  name   = "${var.vms[count.index]}"
  memory = "${var.vms[count.index]}" == "modelos1-labsclim" || "${var.vms[count.index]}" == "analises-labsclim" ? 1024*64 : ("${var.vms[count.index]}" == "nfs" || "${var.vms[count.index]}" == "dados-labsclim" ? 1024*32 : "${var.MEMORY_SIZE}")
  vcpu   = "${var.vms[count.index]}" == "modelos1-labsclim" || "${var.vms[count.index]}" == "analises-labsclim" ? 40 : "${var.VCPU_SIZE}"

  network_interface {
    network_name = "default"
    hostname     = "${var.vms[count.index]}"
    mac          = "${var.mac-address[count.index]}"
}

  disk {
    volume_id = libvirt_volume.ubuntu-qcow2-resized[count.index].id
  }

  cloudinit = "${libvirt_cloudinit_disk.cloud_init[count.index].id}"

  console {
    type        = "pty"
    target_type = "serial"
    target_port = "0"
  }

  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }
}


