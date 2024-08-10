#!/bin/bash

#set -x

while true; do
clear
# Имя пакета
#package_name="$(apt list | grep '/' | cut -d'/' -f1 | peco --prompt "Выбери пакет для созд. модуля:")"
package_name="$(apt-cache pkgnames | sort  | peco --prompt 'Выбери пакет для созд. модуля:')"
            if [ "$package_name" = "" ]; then
                echo "Выход из скрипта."
                break
            fi
cd ~/portapps
rm -rf ./"$package_name"
# Каталог для создания портативного приложения
app_dir=~/portapps/"$package_name"

# Создание каталога
mkdir -p "$app_dir"

# Файл для хранения ссылок
url_file="$(mktemp)"

# Скачивание deb-пакетов и зависимостей
apt-get install --download-only --print-uris $package_name | grep -o 'https\?://\S*\.deb' > "$url_file"

# Скачивание файлов из списка
wget -P "$app_dir" -i "$url_file"

# Удаление файла со списком ссылок
rm "$url_file"

# Распаковка deb-пакетов
for deb in "$app_dir"/*.deb; do
    dpkg-deb -x "$deb" "$app_dir"
done

# Удаление deb-пакетов
rm "$app_dir"/*.deb

echo "Портативное приложение $package_name создано в $app_dir"
cd "$app_dir/usr/share/"
rm -rf ./fonts
#rm -rf ./locale
rm -rf ./doc
rm -rf ./man

cd $HOME/portapps/

mksquashfs ./"$package_name" ./"$package_name".sb -comp gzip -b 256K -Xcompression-level 9

done
