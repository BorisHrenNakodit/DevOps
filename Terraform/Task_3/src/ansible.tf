resource "local_file" "hosts_templatefile" {
  depends_on = [ yandex_compute_instance.vm_storage,yandex_compute_instance.vms_copy,yandex_compute_instance.vms_dataBase ]

  filename = "${(path.module)}/hosts.cfg"

  content = templatefile("${path.module}/hosts.tftpl", {   
    webservers = yandex_compute_instance.vms_copy,
    bdservers  = yandex_compute_instance.vms_dataBase,
    storserver = [yandex_compute_instance.vm_storage]
  })

}

resource "null_resource" "ansible_playbook" {
  depends_on = [ yandex_compute_instance.vm_storage,yandex_compute_instance.vms_copy,yandex_compute_instance.vms_dataBase ]

  provisioner "local-exec" {
    command = "ansible-playbook -i inventotory test.yml" 
  }
}

 