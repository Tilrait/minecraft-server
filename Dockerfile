# Используем официальный образ Java 17
FROM eclipse-temurin:17-jre

# Устанавливаем рабочую директорию внутри контейнера
WORKDIR /minecraft

# Устанавливаем необходимые пакеты
RUN apt-get update && apt-get install -y wget && rm -rf /var/lib/apt/lists/*

# Копируем скрипт запуска в контейнер
COPY scripts/start.sh /minecraft/start.sh

# Делаем скрипт исполняемым
RUN chmod +x /minecraft/start.sh

# Создаем пользователя 'minecraft' для безопасности
RUN groupadd -r minecraft && useradd -r -g minecraft minecraft
USER minecraft

# Открываем порт Minecraft
EXPOSE 25565

# Объявляем том для данных сервера
VOLUME ["/minecraft/data"]

# Запускаем скрипт при старте контейнера
CMD ["./start.sh"]