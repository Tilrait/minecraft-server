# URL для скачивания Paper 1.20.1
PAPER_URL="https://api.papermc.io/v2/projects/paper/versions/1.20.1/builds/196/downloads/paper-1.20.1-196.jar"
SERVER_JAR="paper-1.20.1-196.jar"

# Переходим в директорию с данными
cd /minecraft/data

# Скачиваем Paper, если серверный jar-файл отсутствует
if [ ! -f $SERVER_JAR ]; then
    echo "Скачиваем Paper Server Jar..."
    wget -O $SERVER_JAR $PAPER_URL
fi

# Соглашаемся с EULA (Лицензионное соглашение)
if [ ! -f eula.txt ]; then
    echo "eula=true" > eula.txt
fi

# Запускаем сервер
echo "Запускаем Minecraft Server..."
java -Xms2G -Xmx8G -jar $SERVER_JAR --nogui