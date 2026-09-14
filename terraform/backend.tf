terraform {
  backend "s3" {
    bucket       = "jenkins-cicd-terraform-state-505464394496"
    key          = "jenkins-aws-cicd/terraform.tfstate"
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true
  }
}
