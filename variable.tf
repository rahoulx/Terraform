variable "region"{
    type=string
    default="ap-south-1"
}

variable "ami"{
    type=string
    default="ami-0b08bfc6ff7069aff"
}

variable "pub_ip"{
    type=bool
    default="true"
}

variable "key_pair"  {
    type=string
default="mumbai-awskey"
}

variable "tag"  {
    type=map
default={
    name="bsn"
    env="UAT"
    Dept="operation"
}
}

#variable "username" {
#  type = list(string)
#  default = ["tucker","annie","josh","sagar"]
#}
