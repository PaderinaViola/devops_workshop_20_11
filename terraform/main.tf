terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "4.7.0"
    }
  }
}

provider "docker" {
  
}

resource "docker_image" "web" {
  name = "nginx:1.31.9"
}

resource "docker_image" "tasks-api" {
  name = "taska-api"
}

resource "docker_image" "tasks-api" {
  name = "taska-api"
}

resource "docker_image" "zoo" {
  name = "zoo"
  build {
    context = "../services/tasks-api"
    tag     = ["tasks-api:local"]
    build_args = {
      foo : "zoo"
    }
    label = {
      author : "PaderinaViola"
    }
  }
}


variable "normalizer_url" {
  description = "The URL for the normalizer service"
  type        = string
}


# Pulls the image
resource "docker_container" tasks-api" {
  name = docker_image.tasks-api.image.id
  image = tasks-api:local
  ports {
    internal = 5001
    external = 5001
  }
}

resource "docker_container" "title-normalizer" {
  name = "title-normalizer"
  image = title-normalizer:local
  ports {
    internal = 80
    external = 8080
  }
}

resource "docker container" "api" {
    name = "tasks-one-api"
    image = "tasks-api:local"
    env = ["NORMALIZER_URL=http://${docker_container.normalizer.name}:5001]
    ports {
    internal = 5000
    external = 8000
  }
  networks advanced {
    name = docker_network.app.name
  }
}