variable "name" {
  description = "The name of the ELB"
  type        = string
  default     = null
}


variable "internal" {
  description = "If true, ELB will be an internal ELB"
  type        = bool
  default     = false
}



variable "instances" {
  description = "List of instances ID to place in the ELB pool"
  type        = list(string)
  default     = []
}