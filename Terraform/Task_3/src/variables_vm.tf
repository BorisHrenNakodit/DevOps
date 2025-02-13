variable "vm_image_Bubuntu" {
  type        = string
  default     = "ubuntu-2004-lts"
}
variable "disk_image" {
  type = string
  default = "your image"
}
variable "disk_type" {
  type = string
  default = "your type"
}
variable "count_vms" {
    type = map(object({
      cores         =number
      ram           =number
      core_fraction =number
    }))
    default = {
      vm={
        cores           =2
        ram             =2
        core_fraction   =5
      }      
    }  
}

variable "each_vm" {
  type = list(object({
    vm_name       = string
    cpu           = number
    ram           = number
    core_fraction = number
    disk_volume   = number
  }))
}

variable "ssh_all" {
  type = map(object({
    serial_port = number
    ssh_user    = string
    ssh_path    = string
    ssh_private = string
    }))
}

