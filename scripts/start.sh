cd /minecraft/data

PAPER_VERSION="1.20.1"
PAPER_BUILD="196"
SERVER_JAR="paper-server.jar"
PAPER_URL="https://api.papermc.io/v2/projects/paper/versions/${PAPER_VERSION}/builds/${PAPER_BUILD}/downloads/paper-${PAPER_VERSION}-${PAPER_BUILD}.jar"

echo "=== Запуск Minecraft Server ==="

if [ ! -f "$SERVER_JAR" ]; then
    echo "Скачиваем Paper ${PAPER_VERSION} build ${PAPER_BUILD}..."
    if wget -q --show-progress -O "$SERVER_JAR" "$PAPER_URL"; then
        echo "Paper успешно скачан"
    else
        echo "Ошибка при скачивании Paper"
        echo "URL: $PAPER_URL"
        exit 1
    fi
fi

if [ ! -s "$SERVER_JAR" ]; then
    echo "Ошибка: JAR файл пустой"
    rm -f "$SERVER_JAR"
    exit 1
fi

if [ ! -f eula.txt ]; then
    echo "eula=true" > eula.txt
    echo "EULA принята автоматически"
fi

if [ ! -f ops.json ]; then
    echo '[]' > ops.json
    echo "Создан пустой файл ops.json"
fi

if [ ! -f banned-players.json ] || [ ! -s banned-players.json ]; then
    echo '[]' > banned-players.json
    echo "Исправлен banned-players.json"
fi

if [ ! -f banned-ips.json ] || [ ! -s banned-ips.json ]; then
    echo '[]' > banned-ips.json
    echo "Исправлен banned-ips.json"
fi

if [ ! -f whitelist.json ] || [ ! -s whitelist.json ]; then
    echo '[]' > whitelist.json
    echo "Исправлен whitelist.json"
fi

if [ ! -f server.properties ]; then
    echo "# Minecraft Server Properties" > server.properties
    echo "motd=My Docker Minecraft Server" >> server.properties
    echo "gamemode=survival" >> server.properties  
    echo "level-type=default" >> server.properties
    echo "Создан базовый server.properties"
fi

echo "Запускаем Minecraft Server..."
echo "Используемая память: -Xms1G -Xmx2G"
exec java -Xms2G -Xmx8G -jar "$SERVER_JAR" --nogui