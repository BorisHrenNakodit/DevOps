###cloud vars


variable "cloud_id" {
  type        = string
  sensitive   = true
  default     = "your cloud id"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  sensitive   = true
  default     = "your folder id"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}

variable "path_servis_key" {
  type = string
  default = "your path"
  sensitive = true
}

#Конфиг систем
variable "vms_resources" {

  type = map(object({
    core          = number
    ram           = number
    core_fraction = number
    }))

    default = {
      web = {
        core          = 2
        ram           = 1
        core_fraction = 5
        
      }
      db ={
        core          = 2
        ram           = 2
        core_fraction = 20
      }
    }
}


variable "vm_metadata" {
  type = map(object({
    serial_port_enable  = number
    ssh_user            = string
    ssh_path            = string
  }))  
  default = {
    "ssh_key" = {
      serial_port_enable  =1
      ssh_user            ="your_user"    
      ssh_path            ="your_path"
    }
  }
}


