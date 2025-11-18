provider "google" {
    project = "siva-477505" 
    credentials = file("/var/lib/jenkins/5a.json")
}
resource "google_compute_instance" "instance1" {
    name = "vm-1"
    zone =  "us-west1-b" 
    machine_type = "e2-micro"
    boot_disk {
      initialize_params {
        image = "debian-cloud/debian-12"        
      }
    }
    network_interface {
        network = "default"
        access_config {
           //
        }
    }
    metadata = {
      ssh-keys = "padmapriyadev2:${file("/var/lib/jenkins/.ssh/id_ed25519.pub")}"
    }
}

resource "local_file" "file1" {
  content  = "padmapriyadev2@${google_compute_instance.instance1.network_interface[0].access_config[0].nat_ip}"
  filename = "/var/lib/jenkins/workspace/ip.txt"
}
