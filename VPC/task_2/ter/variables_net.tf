variable "vpc_name" {
  type = string
  default = "vpc1"
}

variable "vpc_sub_name" {
  type = map(object({
    sub_public  =string
  }))
}
variable "zone" {
  type = string
  default = "ru-central1-a"
}
variable "ipmask" {
  type = string
  default = "192.168.10.0/24"
}