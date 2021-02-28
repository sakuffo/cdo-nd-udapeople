variable "udc_default_tags" {
  type = map(any)
  default = {
    "courseWork" : "true",
    "entity" : "udacity",
    "program" : "cdo-nd"
  }
  description = "Tags to mark all resources for the course"


}

variable "ssh_path" {
  type    = string
  default = "~/.ssh/udacity.pem"
}

variable "http-traffic-port" {
  type    = number
  default = 80
}

variable "ssh-traffic-port" {
  type    = number
  default = 22
}

variable "database-traffic-port" {
  type    = number
  default = 5432
}

variable "public_subnet_count" {
  type    = number
  default = 2
}

variable "primary" {
  type = object({
    region            = string
    public-subnet-01  = string
    public-subnet-02  = string
    s3-bucket-01      = string
  })
  default = {
    region            = "us-east-1"
    public-subnet-01  = "us-east-1a"
    public-subnet-02  = "us-east-1b"
    s3-bucket-01      = "saa-udc-primary-bucket-task-5"
  }
}

variable "primary-web" {
  type = object({
    instance-type = string
    count         = number
    storage-type  = string
    storage-size  = number
  })
  default = {
    instance-type = "t2.micro"
    count         = 1
    storage-type  = "gp2"
    storage-size  = 10
  }
}

