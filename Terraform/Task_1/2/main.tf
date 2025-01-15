terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}
   

provider "docker" {}

resource "docker_context" "remote_ssh_docker_host" {
  name = "remout_doc"
  description = "SSH_docker"
  default = true

  endpoints {
    docker_host = {
      host = "ssh://ubuntu@130.193.44.56"
      ssh_key       = file("/home/Ioan/.ssh/id_ed25519")
    }
  }
}

resource "docker_image" "mysql" {
  name          = "mysql:latest"
  keep_locally  = false
  pull_triggers = ["always"]
}

resource "docker_container" "sql" {
  image = docker_image.name
  name  = "mysql-container"
  env   = [
    "MYSQL_ROOT_PASSWORD=rootpassword",
    "MYSQL_DATABASE=mydb",
    "MYSQL_USER=myadmin",
    "MYSQL_PASSWORD=mypassword"
  ]
  ports {
    internal = 3306
    external = 3306
  }
}
