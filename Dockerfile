# Используем официальный образ Java 17 (требуется для Minecraft 1.17+)
FROM eclipse-temurin:17-jre-alpine

# Устанавливаем рабочую директорию внутри контейнера
WORKDIR /minecraft

# Копируем скрипт запуска в контейнер
COPY scripts/start.sh /minecraft/start.sh

# Делаем скрипт исполняемым
RUN chmod +x /minecraft/start.sh

# Создаем пользователя 'minecraft' для безопасности (не запускать от root)
RUN addgroup -S minecraft && adduser -S minecraft -G minecraft
USER minecraft

# Открываем порт Minecraft
EXPOSE 25565

# Объявляем том для данных сервера
VOLUME ["/minecraft/data"]

# Запускаем скрипт при старте контейнера
CMD ["./start.sh"]