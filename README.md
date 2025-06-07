# Docker-Web на Ubuntu

В этом проекте демонстрируется работа с Docker: поднятие Web
---

## Основные команды Docker

- `docker –v` — версия Docker
- `docker ps` — список запущенных контейнеров
- `docker ps -a` — все контейнеры
- `docker images` — список локальных образов
- `docker build -t myimage:latest .` — сборка образа из Dockerfile
- `docker run -d -p 80:80 myimage:latest` — запуск контейнера
- `docker exec -it <container_id> /bin/bash` — доступ в контейнер
- `docker commit <container_id> newimage_v2:latest` — создание нового образа из контейнера

---

## Пример Dockerfile (NGINX)

```Dockerfile
FROM nginx:latest
RUN echo "New Version v2" >> /usr/share/nginx/html/index.html
```

Контейнер запускает NGINX и модифицирует стартовую страницу.

---

## Пример Dockerfile (Apache)

```Dockerfile
# Dockerfile to build Docker Image of Apache WebServer running on Ubuntu

FROM ubuntu:16.04

RUN apt-get -y update
RUN apt-get -y install apache2

RUN echo 'Hello World from Docker!' > /var/www/html/index.html

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
EXPOSE 80
```

Dockerfile создает образ на основе Ubuntu 16.04 с веб-сервером Apache2, который отображает простое сообщение "Hello World from Docker!"

---

## Подробный обзор поднятия Web на Ubuntu

![image_alt](https://github.com/exeleron07/docker-web/blob/47f5789baa2e1122a409248b73b3a6ed38da8b43/img/1.png)

Команда docker run hello-world запускает контейнер из официального образа hello-world, который предназначен для проверки корректной работы Docker:

```bash
docker run hello-world
```

---

![image_alt](https://github.com/exeleron07/docker-web/blob/8355692585723176a9b3c245f2a7f1a9db34f09a/img/2.png)

Команда docker images выводит список всех Docker-образов, которые есть в локальном хранилище вашей системы. В данном случае убедимся, что естьв images hello-world:

```bash
docker images
```

---

Результат:

```
REPOSITORY   TAG       IMAGE ID       CREATED        SIZE
tomcat       latest    c457807be805   5 days ago     462MB
hello-world  latest    d2c94e258dcb   17 months ago  13.3kB
```
