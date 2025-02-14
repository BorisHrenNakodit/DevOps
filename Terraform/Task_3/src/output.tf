# В виде списка словарей
output "info_vm_copy" {
  value = [for vm in yandex_compute_instance.vms_copy.*:{ id = vm.id, name = vm.name, fqdn = vm.fqdn }]
}

output "info_vm_db" {
  value = [for vm in yandex_compute_instance.vms_dataBase : {id = vm.id, name = vm.name, fqdn = vm.fqdn} ] 
}

output "ip" {
  value = yandex_compute_instance.vms_copy[0].fqdn
}