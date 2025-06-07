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

<p align="center">
  <img src="https://github.com/exeleron07/docker-web/blob/371a9cb138db046a9b2582c7b0b26335545f9c4b/img/1-1.png" alt="Header">
</p>

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

<p align="center">
  <img src="https://github.com/exeleron07/docker-web/blob/ca8cdca113d28741e4d0c0169f8cf5a6d9ea06b1/img/2-2.png" alt="Header">
</p>

Команда sudo usermod -aG docker $USER добавляет текущего пользователя в группу docker, чтобы можно было управлять Docker без постоянного использования sudo:

```bash
sudo usermod -aG docker $USER
```

---

<p align="center">
  <img src="https://github.com/exeleron07/docker-web/blob/887986b29a480f3dc94e6c0988ceca42e8d3797b/img/3.png" alt="Header">
</p>
<p align="center">
  <img src="https://github.com/exeleron07/docker-web/blob/887986b29a480f3dc94e6c0988ceca42e8d3797b/img/4.png" alt="Header">
</p>


Команда docker search tomcat ищет официальные и сторонние образы Apache Tomcat в Docker Hub (публичном репозитории Docker). Команда docker pull tomcat загружает официальный образ Apache Tomcat из Docker Hub на ваш локальный компьютер (что нам и нужно):


```bash
docker search tomcat
docker pull tomcat
```

---

<p align="center">
  <img src="https://github.com/exeleron07/docker-web/blob/a0b66b741f613853bb25009f29fb1e9e86cf3958/img/5.png" alt="Header">
</p>

Команда docker images выводит список всех Docker-образов, которые есть в локальном хранилище вашей системы. Проверяем наличие tomcat

```bash
docker images
```

![image_alt](https://github.com/exeleron07/docker-web/blob/488d243e4a55d8eac979d5ecf023b31fb575eb20/img/6.png)
![image_alt](https://github.com/exeleron07/docker-web/blob/488d243e4a55d8eac979d5ecf023b31fb575eb20/img/7.png)

Команда docker run -itd --name webapp -p 8080:8080 tomcat запускает контейнер из образа Tomcat в фоновом режиме с пробросом порта. На данном этапе я столкнулся с первой проблемой, а именно с ошибкой "HTTP Status 404 - Not Found". Пробовал многое, но оказалось всё очень просто. Дело в том, что TomCat не может найти каталог webapps.dist, соответственно доступ к веб-странице невозможен. Чтобы решить данную проблему, нужно переместить веб-приложение на webapps.dist.

```bash
docker run -itd --name webapp -p 8080:8080 tomcat
docker ps
docker exec -it 38330ad620e1 /bin/bash
ls
cd webapps.dist/
ls
cp -R * ../webapps
cd ..
cd webapps
ls
exit
```

---

![image_alt](https://github.com/exeleron07/docker-web/blob/488d243e4a55d8eac979d5ecf023b31fb575eb20/img/9.png)

Можно увидеть готовый результат странички Apache

![image_alt](https://github.com/exeleron07/docker-web/blob/488d243e4a55d8eac979d5ecf023b31fb575eb20/img/10.png)

NGINX запускается без проблем

---

Результат:

```
REPOSITORY   TAG       IMAGE ID       CREATED        SIZE
tomcat       latest    c457807be805   5 days ago     462MB
nginx        latest    7f553e8bbc89   13 days ago    192MB
hello-world  latest    d2c94e258dcb   17 months ago  13.3kB
```
