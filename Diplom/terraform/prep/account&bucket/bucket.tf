#создание бакетаы
resource "yandex_storage_bucket" "backend-ter" {
  bucket = "backend-1"
  folder_id = "${var.folder_id}"
  max_size = 536870913
  # Ключи доступа к бакету  передававть через  
  # terraform init -backend-config="access_key=YCA******" -backend-config="secret_key=YCN****"
  access_key = yandex_iam_service_account_static_access_key.sa_key_editor.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa_key_editor.secret_key
  anonymous_access_flags {
    read = false
    list = false
    config_read = false
  }
}