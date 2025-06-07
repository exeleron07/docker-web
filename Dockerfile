#базовый образ (последняя стабильная версия Nginx из официального репозитория)
FROM nginx:latest

#добавляет строку "New Version v2" в конец стандартного файла index.html Nginx
RUN echo "New Version v2" >> /usr/share/nginx/html/index.html