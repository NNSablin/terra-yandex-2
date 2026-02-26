###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}
variable "each_vm" {
  description = "Параметры виртуальных машин для баз данных"
  type = map(object({
    vm_name     = string
    cpu         = number
    ram         = number
    disk_volume = number
    core_fraction = number
  }))
  default = {
    "main" = {
      vm_name      = "main"
      cpu          = 2
      ram          = 4
      disk_volume  = 15
      core_fraction = 20
    }
    "replica" = {
      vm_name      = "replica"
      cpu          = 4
      ram          = 8
      disk_volume  = 30
      core_fraction = 50
    }
  }
}
variable "ssh_public_key" {
  type    = string
  default = ""
}
