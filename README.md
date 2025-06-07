# Docker-практика на Ubuntu

В этом проекте демонстрируется работа с Docker: запуск, создание собственных образов, изменение контейнеров, commit, tag и прочее.

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

---

## Изображения и примеры из практики

![1](https://raw.githubusercontent.com/exeleron01/docker-web/commit/1.png)

Добавление пользователя в группу docker:

```bash
sudo usermod -aG docker SUSER
```

---

### 📸 Изображение 2

Вывод списка локальных Docker-образов:

```bash
docker images
```

Результат:

```
REPOSITORY   TAG       IMAGE ID       CREATED        SIZE
tomcat       latest    c457807be805   5 days ago     462MB
hello-world  latest    d2c94e258dcb   17 months ago  13.3kB
```
