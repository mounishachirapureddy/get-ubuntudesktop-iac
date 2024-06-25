output "network_self_link" {
  value = google_compute_network.get_network.self_link
}

output "subnet01_self_link" {
  value = google_compute_subnetwork.subnet01.self_link
}
