resource "google_project_service" "dns" {
  service = "dns.googleapis.com"
}

resource "google_compute_address" "get_ubuntudesktop_static_ip" {
  name         = var.get_ubuntudesktop_static_ip_name
  address_type = "EXTERNAL"
  network_tier = "PREMIUM"
  region       = var.project_region
}

resource "google_compute_network" "get_network" {
  name           = var.network_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet01" {    
  name          = var.subnet01_name
  region        = var.subnet01_region
  network       = google_compute_network.get_network.self_link
  ip_cidr_range = var.subnet01_cidr
}

resource "google_compute_firewall" "firewall01" { 
  name    = var.firewall01_name
  network = google_compute_network.get_network.self_link

  # Allow rules
  allow {
    protocol = "tcp"
    ports    = ["22", "3389", "80", "8080"]
  }
  
  allow {
    protocol = "icmp"
  }

  target_tags = [var.firewall01_network_tags] # Apply to VMs with this tag
  source_ranges = ["0.0.0.0/0"]  # Allow traffic from any source
}

resource "google_compute_firewall" "firewall02" { 
  name    = var.firewall02_name
  network = google_compute_network.get_network.self_link

  # Allow rules
  allow {
    protocol = "tcp"
    ports    = ["22", "8080"]
  }
  
  allow {
    protocol = "icmp"
  }

  target_tags = [var.firewall02_network_tags] # Apply to VMs with this tag
  source_ranges = ["0.0.0.0/0"]  # Allow traffic from any source
}

resource "google_compute_firewall" "firewall03" { 
  name    = var.firewall03_name
  network = google_compute_network.get_network.self_link

  # Allow rules
  allow {
    protocol = "tcp"
    ports    = ["22", "80"]
  }
  
  allow {
    protocol = "icmp"
  }

  target_tags = [var.firewall03_network_tags] # Apply to VMs with this tag
  source_ranges = ["0.0.0.0/0"]  # Allow traffic from any source
}
