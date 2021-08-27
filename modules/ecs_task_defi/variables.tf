variable "NAME" {
  type = string
}
variable "IMAGE_ID" {
  type = string
}

variable "IS_ESSENTIAL" {
  type    = bool
  default = true
}

variable "WORKDIR" {
  type    = string
  default = "/App/QuickApp"
}
variable "ENTRYPOINT" {
  type    = list(string)
  default = ["dotnet", "/App/QuickApp/bin/Release/net5.0/publish/QuickApp.dll"]s
}

variable "ENV" {
  type = string
}

variable "RAM" {
  type    = number
  default = 1024
}

variable "CPU" {
  type    = number
  default = 512
}

variable "NETWORK_MODE" {
  type    = string
  default = "awsvpc"
}
variable "IAM_ROLE_ID" {
  type = string
}

variable "DB_ENDPOINT" {
  type = string
}

variable "DB_USER" {
  type = string
}
variable "DB_PWD" {
  type = string
}

variable "DB_NAME" {
  type    = string
  default = "quickapp"
}
