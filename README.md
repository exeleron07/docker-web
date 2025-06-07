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

![image_alt](https://github.com/exeleron07/docker-web/blob/371a9cb138db046a9b2582c7b0b26335545f9c4b/img/1-1.png)

Команда sudo systemctl status docker сообщает о состоянии докера. Перед этим не забудьте установить его для Ubuntu (команды прикрепляю):

```bash
sudo systemctl status docker
sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt install docker-ce -y
sudo systemctl start docker
sudo systemctl enable docker
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
