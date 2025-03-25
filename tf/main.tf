terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.84.0"
    }
  }
}

provider "yandex" {
  token     = "y0_AgAAAAAK6UO8AATuwQAAAAEU0A7ZAADI2RX5aP5F6oRG3XBnbiK6foVIOQ"  
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
}

resource "yandex_vpc_network" "default" {
  name = "devops-network"
}

resource "yandex_vpc_subnet" "default" {
  name           = "devops-subnet"
  zone           = var.zone
  network_id     = yandex_vpc_network.default.id
  v4_cidr_blocks = ["10.128.0.0/24"]
}

resource "yandex_compute_instance" "master" {
  name        = "k8s-master"
  platform_id = "standard-v1"
  zone        = var.zone

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd866d9q7rcg6h4udadk"  
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.default.id
    nat       = true
  }

  metadata = {
    ssh-keys = <<EOF
ubuntu:${file("~/.ssh/id_rsa.pub")}
EOF
  }
}

resource "yandex_compute_instance" "node" {
  name        = "k8s-node"
  platform_id = "standard-v1"
  zone        = var.zone

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd866d9q7rcg6h4udadk"  
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.default.id
    nat       = true
  }

  metadata = {
    ssh-keys = <<EOF
ubuntu:${file("~/.ssh/id_rsa.pub")}
EOF
  }
}

resource "yandex_compute_instance" "srv" {
  name        = "ci-server"
  platform_id = "standard-v1"
  zone        = var.zone

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd866d9q7rcg6h4udadk"  
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.default.id
    nat       = true
  }

  metadata = {
    ssh-keys = <<EOF
ubuntu:${file("~/.ssh/id_rsa.pub")}
EOF
  }
}
