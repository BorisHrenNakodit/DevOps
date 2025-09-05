variable "cloud_id" {
  type = string
  sensitive = true
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type = string
  sensitive = true
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "vps" {
  type = map(object({
    v4_cidr_blocks    = list(string)
    zone  = string
  }))
  default = {
    "yuor_name_subnet" = {
      v4_cidr_blocks= ["your_ip/mask"]
      zone          =  "your_zone"    
    }
  }
}

variable "vm" {
  type = map(object({
    cores         = number
    memory        = number
    core_fraction = number 
    subnet        = string
    platform_id   = string
    hdd_type      = string
    hdd_size      = number
  }))
}
variable "ssh_all" {
  type = map(object({
    serial_port = number
    ssh_user    = string
    ssh_path    = string
    }))
}