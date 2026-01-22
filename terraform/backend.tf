terraform {
  backend "s3" {
    bucket       = "gatus-project-0ed74643"
    key          = "gatusproject.tfstate"
    region       = "eu-west-2"
    encrypt      = true
    use_lockfile = true

  }
}
