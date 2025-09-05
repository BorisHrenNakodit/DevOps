#создание бакетаы
resource "yandex_storage_bucket" "backend-ter" {
  bucket = "backend-1"
  folder_id = "${var.folder_id}"
  max_size = 536870913
  access_key = yandex_iam_service_account_static_access_key.sa_key_editor.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa_key_editor.secret_key
  anonymous_access_flags {
    read = false
    list = false
    config_read = false
  # } //Шифрование в bucket
  # server_side_encryption_configuration {
  #   rule {
  #     apply_server_side_encryption_by_default {
        
  #       kms_master_key_id = ""
  #       sse_algorithm = "aws:kms"
  #     }
  #   }
  }
}