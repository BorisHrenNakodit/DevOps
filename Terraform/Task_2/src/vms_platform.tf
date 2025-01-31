variable "vms_ssh_root_key" {
  type        = string
  default     = "your path on root key"
  description = "ssh-keygen -t ed25519"
}



variable "vm_web_image_Bubuntu" {
  type        = string
  default     = "ubuntu-2004-lts"
}

variable "vm_web_inst_name" {
  type        = string
  default     = "netology-develop-platform-web"
}

variable "vm_web_inst_platfor_id" {
  type        = string
  default     = "standard-v1"
}

variable "vm_web_default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "vm_web_default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vm_web_vpc_name" {
  type        = string
  default     = "vm_web"
  description = "VPC network & subnet name"
}



variable "vm_db_image_Bubuntu" {
  type        = string
  default     = "ubuntu-2004-lts"
}

variable "vm_db_inst_name" {
  type        = string
  default     = "netology-develop-platform-db"
}

variable "vm_db_inst_platfor_id" {
  type        = string
  default     = "standard-v1"
}
variable "vm_db_default_zone" {
  type        = string
  default     = "ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "vm_db_default_cidr" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}
variable "vm_db_vpc_name" {
  type        = string
  default     = "vm_db"
  description = "VPC network & subnet name"
}




