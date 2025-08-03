resource "yandex_kms_symmetric_key" "key-monkey" {
  name = "symetric-monkey"
  description = "https://yandex.cloud/ru/docs/kms/"
  default_algorithm = "AES_128"  
}