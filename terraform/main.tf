terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

# Create a Docker network
resource "docker_network" "app_network" {
  name = "startify_network"
}

# Create a directory for PostgreSQL data
resource "null_resource" "create_db_dir" {
  provisioner "local-exec" {
    command = "mkdir -p ${path.cwd}/postgres-data"
  }
}

# PostgreSQL container
resource "docker_image" "postgres" {
  name         = "postgres:14"
  keep_locally = true
}

resource "docker_container" "postgres" {
  name  = "startify_dbase"
  image = docker_image.postgres.image_id
  env = [
    "POSTGRES_USER=startify_user",
    "POSTGRES_PASSWORD=startify_pass",
    "POSTGRES_DB=startify_dbase"
  ]
  networks_advanced {
    name = docker_network.app_network.name
  }
  ports {
    internal = 5432
    external = 5433
  }
  volumes {
    container_path = "/var/lib/postgresql/data"
    host_path      = "${abspath(path.cwd)}/postgres-data" # Absolute path
  }
  depends_on = [null_resource.create_db_dir]
}

# FastAPI container
resource "docker_image" "app" {
  name = "startify-app"
  build {
    context = abspath("${path.module}/../backend")
    dockerfile = "Dockerfile"
  }
}

resource "docker_container" "app" {
  name  = "startify_api"
  image = docker_image.app.image_id
  env = [
    "DATABASE_URL=postgresql://startify_user:startify_pass@startify_dbase:5432/startify_dbase"
  ]
  networks_advanced {
    name = docker_network.app_network.name
  }
  ports {
    internal = 8000
    external = 8000
  }
  depends_on = [docker_container.postgres]
}