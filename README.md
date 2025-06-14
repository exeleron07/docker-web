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
#базовый образ (последняя стабильная версия Nginx из официального репозитория)
FROM nginx:latest

#добавляет строку "New Version v2" в конец стандартного файла index.html Nginx
RUN echo "New Version v2" >> /usr/share/nginx/html/index.html
```

Контейнер запускает NGINX и модифицирует стартовую страницу.

---

## Пример Dockerfile (Apache)

```Dockerfile
# Dockerfile создает образ на основе Ubuntu 16.04 с веб-сервером Apache2, который отображает простое сообщение "Hello World from Docker!"

#базовый образ, на основе которого строится контейнер (в данном случае Ubuntu 16.04)
FROM ubuntu:16.04

#обновление списка пакетов (выполняется внутри контейнера)
RUN apt-get -y update
#установка веб-сервера Apache2 (флаг -y автоматически подтверждает установку)
RUN apt-get -y install apache2
#создает файл index.html с простым содержимым в стандартной директории Apache
RUN echo 'Hello World from Docker!' > /var/www/html/index.html
#команда, которая будет выполнена при запуске контейнера (запуск Apache в foreground режиме)
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
#указывает, что контейнер прослушивает 80 порт (но не открывает его автоматически на хосте)
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
<p align="center">
  <img src="https://github.com/exeleron07/docker-web/blob/488d243e4a55d8eac979d5ecf023b31fb575eb20/img/6.png" alt="Header">
</p>
<p align="center">
  <img src="https://github.com/exeleron07/docker-web/blob/488d243e4a55d8eac979d5ecf023b31fb575eb20/img/7.png" alt="Header">
</p>

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

<p align="center">
  <img src="https://github.com/exeleron07/docker-web/blob/488d243e4a55d8eac979d5ecf023b31fb575eb20/img/9.png" alt="Header">
</p>

Можно увидеть готовый результат странички Apache

<p align="center">
  <img src="https://github.com/exeleron07/docker-web/blob/488d243e4a55d8eac979d5ecf023b31fb575eb20/img/10.png" alt="Header">
</p>

NGINX запускается без проблем

---

Результат:

```
REPOSITORY   TAG       IMAGE ID       CREATED        SIZE
tomcat       latest    c457807be805   5 days ago     462MB
nginx        latest    7f553e8bbc89   13 days ago    192MB
hello-world  latest    d2c94e258dcb   17 months ago  13.3kB
```
## Создание своего Docker image

<p align="center">
  <img src="https://github.com/exeleron07/docker-web/blob/66b51e3aa9ba670ec621a07d7800030264c6849f/img/11.png" alt="Header">
</p>

Создаём директорию mydocker, переходим в неё и после чего редактируем файл через nano и вставляем код, который был в начале (продублирую ниже также):

```bash
mkdir mydocker
cd mydocker
nano Dockerfile
```

```Dockerfile
FROM ubuntu:16.04

RUN apt-get -y update
RUN apt-get -y install apache2
RUN echo 'Hello World from Docker!' > /var/www/html/index.html
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
EXPOSE 80
```
<p align="center">
  <img src="https://github.com/exeleron07/docker-web/blob/f7dac3e3e907136cd5d23d19ec7e74a200282a7d/img/12.png" alt="Header">
</p>
<p align="center">
  <img src="https://github.com/exeleron07/docker-web/blob/f7dac3e3e907136cd5d23d19ec7e74a200282a7d/img/13.png" alt="Header">
</p>

Команда docker build -t vlad:v1 . собирает Docker-образ из текущей директории и присваивает ему имя (vlad) и тег (v1). Команда docker run -d -p 7777:80 vlad:v1 запускает контейнер из вашего собственного образа vlad:v1 в фоновом режиме с пробросом порта.

```bash
docker build -t vlad:v1
docker run -d -p 7777:80 vlad:v1
```
<p align="center">
  <img src="https://github.com/exeleron07/docker-web/blob/c057875d3c414e2bf4d07aa0883fd2190a221a09/img/14.png" alt="Header">
</p>

Готовый результат
