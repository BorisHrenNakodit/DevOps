resource "yandex_iam_service_account" "group_edit" {
  name        = "group-edit"
  description = "Сервисный аккаунт для управления GP_VM"
  folder_id = var.folder_id
}

resource "yandex_resourcemanager_folder_iam_member" "group_editor" {
  folder_id = var.folder_id
  role = "editor"
  member = "serviceAccount:${yandex_iam_service_account.group_edit.id}"
  depends_on = [ yandex_iam_service_account.group_edit ]
}

resource "yandex_compute_instance_group" "web_group" {
  name       = "wem"
  #deletion_protection = true # ОТСЛУЧАЙНОГО УДАЛЕНИЯ
  depends_on = [ yandex_storage_bucket.bucket_image,yandex_resourcemanager_folder_iam_member.group_editor ]
  
  instance_template {
    platform_id = "standard-v2"
    resources {
      core_fraction = 5
      cores         = 2
      memory        = 2
    }
    boot_disk {
      initialize_params {
        image_id         = "fd827b91d99psvq5fjit"
      }
    }

    network_interface{
      subnet_ids         = [yandex_vpc_subnet.test_vps_subnet.id]
      nat                = "true"
    }
    metadata ={
      serial-port-enable = var.ssh_all.ssh_vm.serial_port
      ssh-keys           = local.ssh_connect
      user-data  = <<EOF
#!/bin/bash
cd /var/www/html
echo "<html><body><h1>$(hostname -I)</h1>" | sudo tee /var/www/html/index.html
echo '<img src="http://${yandex_storage_bucket.bucket_image.bucket_domain_name}/${yandex_storage_object.monkey.key}"/></body></html>' | sudo tee -a index.html
EOF
    }
    

    scheduling_policy {
      preemptible        = true
    }
  }
  scale_policy {
    fixed_scale {
      size = 3
    }
  }
  allocation_policy {
    zones               = [var.zone]
  }
  deploy_policy {
    max_unavailable     =1
    max_expansion       =2
  }
  service_account_id = yandex_iam_service_account.group_edit.id

  application_load_balancer {
    target_group_name = "bl-monkey"
    target_group_description = "Target group for load-balancer"
  }
}
