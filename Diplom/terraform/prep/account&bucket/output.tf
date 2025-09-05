## Получение ключей через output
output "sa_statick_key" {
    sensitive = true
  value = <<EOT
    account_id = ${yandex_iam_service_account.account-editor.id}
    access_key = "${yandex_iam_service_account_static_access_key.sa_key_editor.access_key}"
    secret_key = "${yandex_iam_service_account_static_access_key.sa_key_editor.secret_key}"
  EOT
}