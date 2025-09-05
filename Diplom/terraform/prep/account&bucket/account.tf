## создание сервисного аккауна 
resource "yandex_iam_service_account" "account-editor" {
  name = "terraform-editor"
  folder_id = var.folder_id
  description = "service-account for terraform "
}


## Добавление роли
resource "yandex_resourcemanager_folder_iam_member" "role-editor" {
  folder_id = var.folder_id
  role = "editor"
  member = "serviceAccount:${yandex_iam_service_account.account-editor.id}"
}

resource "yandex_iam_service_account_static_access_key" "sa_key_editor" {
  service_account_id = yandex_iam_service_account.account-editor.id
  description = "Ключ доступа в bucket"
}


resource "yandex_iam_service_account_key" "sa_key_file" {
  service_account_id = yandex_iam_service_account.account-editor.id
  key_algorithm = "RSA_2048"
  description = "ключ авторизации в клауд"
}

### создание service_account_key_file
resource "local_file" "get_key" {
  filename = "/home/Ioan/Git_repository/DevOps/Diplom/main/key.json"
  content  = jsonencode({
    id              = yandex_iam_service_account_key.sa_key_file.id
    service_account_id = yandex_iam_service_account.account-editor.id
    created_at      = yandex_iam_service_account_key.sa_key_file.created_at
    key_algorithm   = yandex_iam_service_account_key.sa_key_file.key_algorithm
    public_key      = yandex_iam_service_account_key.sa_key_file.public_key
    private_key     = yandex_iam_service_account_key.sa_key_file.private_key
  })
}