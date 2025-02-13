resource "local_file" "hosts_templatefile" {
  depends_on = [ yandex_compute_instance.vm_storage,yandex_compute_instance.vms_copy,yandex_compute_instance.vms_dataBase ]

  filename = "${(path.module)}/hosts.cfg"

  content = templatefile("${path.module}/hosts.tftpl", {   
    webservers = yandex_compute_instance.vms_copy,
    bdservers  = yandex_compute_instance.vms_dataBase,
    storserver = [yandex_compute_instance.vm_storage]
  })

}

 