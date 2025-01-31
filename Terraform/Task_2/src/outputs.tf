output "out_db_inst_name" {
  value     = var.vm_db_inst_name    
}
output "out_db_ip" {
  value     =yandex_compute_instance.vm_db_platform.network_interface
}
output "out_db_fqdn" {
  value     = yandex_compute_instance.vm_db_platform.fqdn
}

output "out_web_inst_name" {
  value     = var.vm_web_inst_name    
}
output "out_web_ip" {
  value     =yandex_compute_instance.vm_web_platform.network_interface
}
output "out_web_fqdn" {
  value     = yandex_compute_instance.vm_web_platform.fqdn
}