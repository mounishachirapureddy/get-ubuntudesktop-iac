resource "google_compute_address" "jenkins_box_static_ip" {
  name         = var.jenkins_box_static_ip_name 
  address_type = "EXTERNAL"
  network_tier = "PREMIUM"
  region      = var.project_region
}

resource "google_compute_instance" "get_jenkins_box" {
  name         = var.get_jenkins_name
  machine_type = var.get_jenkins_machine_type
  zone         = var.get_jenkins_zone

  boot_disk {
    initialize_params {
      image = var.get_jenkins_image
      size  = var.get_jenkins_boot_size
      labels = {
        my_label = "jenkins-server"
      }
    }
  }

  scratch_disk {
    interface = "NVME"
  }

  network_interface {
    network    = var.network
    subnetwork = var.subnetwork

    access_config {
      nat_ip = google_compute_address.jenkins_box_static_ip.address
    }
  }

  labels = {
    jenkins-server = "true"
  }

  service_account {
    email  = var.svc_email
    scopes = ["cloud-platform"]
  }

  tags = [var.get_jenkins_network_tag]

  metadata_startup_script = <<-EOF
  #! /bin/bash
    sudo apt-get update
    sudo apt install git -y
    sudo apt install -y openjdk-17-jre wget vim

    # Install Jenkins
    curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
    /usr/share/keyrings/jenkins-keyring.asc > /dev/null
    echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
    https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null
    sudo apt-get update
    sudo apt-get install jenkins -y
    sudo systemctl start jenkins
    sudo systemctl enable jenkins

    # Installing Docker
    sudo apt install docker.io -y
    sudo sed -i '14s|.*|ExecStart=/usr/bin/dockerd -H tcp://0.0.0.0:4243 -H unix:///var/run/docker.sock|' /lib/systemd/system/docker.service
    sudo systemctl daemon-reload
    sudo systemctl restart docker
  EOF
}

resource "google_compute_firewall" "jenkins_box_firewall" {
  name    = var.jenkins_box_firewall_name
  network = var.network

  allow {
    protocol = "tcp"
    ports    = ["22", "8080", "32768-60999", "4243"]
  }

  allow {
    protocol = "icmp"
  }

  target_tags   = [var.get_jenkins_network_tag]
  source_ranges = ["0.0.0.0/0"]
}

