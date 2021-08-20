#
# Variables Configuration
#

variable "cluster-name" {
  default = "eks-landmark-24testing"
  type    = string
}
variable "key_pair_name" {
  default = "key24"
}
variable "eks_node_instance_type" {
  default = "t2.micro"
}
