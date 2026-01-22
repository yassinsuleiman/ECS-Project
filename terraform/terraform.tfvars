aws_region        = "eu-west-2"
az_count          = 2
app_count         = 2
app_image         = "784607970889.dkr.ecr.eu-west-2.amazonaws.com/gatus-repo:1f941da9bbdc4fc27ae81d119b8338c6473d9266"
my_vpc_cidr       = "10.10.0.0/16"
app_port          = 8080
project_name      = "gatus"
health_check_path = "/health"
validation_method = "DNS"
domain_name       = "yassinsuleiman.com"
subdomain         = "tm"

