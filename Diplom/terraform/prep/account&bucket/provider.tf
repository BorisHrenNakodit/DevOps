terraform {
    required_providers{        
        yandex = {
            source= "yandex-cloud/yandex"
        }
    }
}
provider "yandex" {
  service_account_key_file = "/home/Ioan/.ssh/authorized_key.json"
  cloud_id    = var.cloud_id
  folder_id   = var.folder_id
}