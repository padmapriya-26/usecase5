provider "google" {
    project = "spm-507905"
    region  = "asia-south1"
}   

resource "google_compute_instance" "instance1" {
    name = "vm-1"
    zone =  "asia-south1-b" 
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
   
}
