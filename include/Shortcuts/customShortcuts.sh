#!/bin/bash

if [ -f /usr/share/applications/org.gnome.Terminal.desktop ]; then
echo "Fixing Terminal's shortcut name..."
#$maysudo sed -i 's/^Name=" .*$/Name=" Witchcraft"/' /usr/share/applications/org.gnome.Terminal.desktop
cat > /usr/share/applications/org.gnome.Terminal.desktop <<EOF
[Desktop Entry]
# VERSION=3.36.2
Name=Witchcraft
Comment=Use the command line
Keywords=shell;prompt;command;commandline;cmd;
TryExec=gnome-terminal
Exec=gnome-terminal
Icon=org.gnome.Terminal
Type=Application
Categories=GNOME;GTK;System;TerminalEmulator;
StartupNotify=true
X-GNOME-SingleWindow=false
OnlyShowIn=GNOME;Unity;
Actions=new-window;preferences;
X-Ubuntu-Gettext-Domain=gnome-terminal

[Desktop Action new-window]
Name=New Window
Exec=gnome-terminal --window

[Desktop Action preferences]
Name=Preferences
Exec=gnome-terminal --preferences
EOF
fi

if [ -f /usr/share/applications/org.gnome.Cheese.desktop ]; then
echo "Fixing Cam's shortcut name..."
#$maysudo sed -i 's/^Name=" .*$/Name=" Cam"/' /usr/share/applications/org.gnome.Cheese.desktop
cat > /usr/share/applications/org.gnome.Cheese.desktop <<EOF
[Desktop Entry]
Name=Cam
GenericName=Webcam Booth
Comment=Take photos and videos with your webcam, with fun graphical effects
# Translators: Search terms to find this application. Do NOT translate or localize the semicolons! The list MUST also end with a semicolon!
Keywords=photo;video;webcam;
Exec=cheese
Terminal=false
Type=Application
StartupNotify=true
# Translators: Do NOT translate or transliterate this text (this is an icon file name)!
Icon=camera-app
Categories=GNOME;AudioVideo;Video;Recorder;
DBusActivatable=true
X-Ubuntu-Gettext-Domain=cheese
EOF
fi

if [ -f /usr/share/applications/org.gnome.Rhythmbox3.desktop ]; then
echo "Fixing Music's shortcut name..."
#$maysudo sed -i 's/^Name=" .*$/Name=" Music"/' /usr/share/applications/org.gnome.Rhythmbox3.desktop
cat > /usr/share/applications/org.gnome.Rhythmbox3.desktop <<EOF
[Desktop Entry]
Name=Music
GenericName=Music Player
X-GNOME-FullName=Rhythmbox Music Player
Comment=Play and organize your music collection
Keywords=Audio;Song;MP3;CD;Podcast;MTP;iPod;Playlist;Last.fm;UPnP;DLNA;Radio;
Exec=rhythmbox %U
Terminal=false
Type=Application
Icon=music-app
X-GNOME-DocPath=rhythmbox/rhythmbox.xml
Categories=GNOME;GTK;AudioVideo;Audio;Player;
MimeType=application/x-ogg;application/ogg;audio/x-vorbis+ogg;audio/vorbis;audio/x-vorbis;audio/x-scpls;audio/x-mp3;audio/x-mpeg;audio/mpeg;audio/x-mpegurl;audio/x-flac;audio/mp4;audio/x-it;audio/x-mod;audio/x-s3m;audio/x-stm;audio/x-xm;
StartupNotify=true
X-GNOME-Bugzilla-Bugzilla=GNOME
X-GNOME-Bugzilla-Product=rhythmbox
X-GNOME-Bugzilla-Component=general
X-GNOME-Bugzilla-OtherBinaries=rhythmbox-client;rhythmbox-metadata;
X-GNOME-Bugzilla-Version=3.4.6
X-GNOME-UsesNotifications=true
Actions=PlayPause;Next;Previous;StopQuit;
X-Ubuntu-Gettext-Domain=rhythmbox

[Desktop Action PlayPause]
Exec=rhythmbox-client --play-pause

[Desktop Action Next]
Exec=rhythmbox-client --next

[Desktop Action Previous]
Exec=rhythmbox-client --previous

[Desktop Action StopQuit]
Exec=rhythmbox-client --quit
EOF
fi
#-
if [ -f /usr/share/applications/org.gnome.Rhythmbox3.device.desktop ]; then
#$maysudo sed -i 's/^Name=" .*$/Name=" Music"/' /usr/share/applications/org.gnome.Rhythmbox3.device.desktop
cat > /usr/share/applications/org.gnome.Rhythmbox3.device.desktop <<EOF
[Desktop Entry]
Name=Music
GenericName=Music Player
X-GNOME-FullName=Rhythmbox Music Player
Comment=Play and organize your music collection
Exec=rhythmbox-client --select-source %U
Terminal=false
NoDisplay=true
Type=Application
Icon=music-app
X-GNOME-DocPath=rhythmbox/rhythmbox.xml
Categories=GNOME;GTK;AudioVideo;
MimeType=x-content/audio-player;x-content/audio-cdda;
StartupNotify=false
X-GNOME-Bugzilla-Bugzilla=GNOME
X-GNOME-Bugzilla-Product=rhythmbox
X-GNOME-Bugzilla-Component=general
X-GNOME-Bugzilla-OtherBinaries=rhythmbox;rhythmbox-metadata;
X-GNOME-Bugzilla-Version=3.4.6
X-Ubuntu-Gettext-Domain=rhythmbox
EOF
fi

if [ -f /usr/share/applications/csd-automount.desktop ]; then
echo "Installing shortcut for Explorer..."
cat > /usr/share/applications/csd-automount.desktop <<EOF
[Desktop Entry]
Type=Application
Name=File Explorer
Name[am]=ፋይሎች
Name[bg]=Файлове
Name[ca]=Arxius
Name[cs]=Soubory
Name[da]=Filer
Name[de]=Dateien
Name[es]=Archivos
Name[eu]=Fitxategiak
Name[fr]=Fichiers
Name[hr]=Nemo
Name[hu]=Fájlok
Name[ko]=파일
Name[lt]=Failai
Name[nl]=Bestanden
Name[pl]=Pliki
Name[pt]=Ficheiros
Name[pt_BR]=Explorador de Arquivos
Name[pt_PT]=Explorador de Ficheiros
Name[ru]=Файлы
Name[sv]=Filer
Name[tr]=Dosyalar
Name[uk]=Файли
Name[zh_CN]=文件
Name[zh_HK]=檔案
Icon=system-file-manager
Exec=/usr/lib/x86_64-linux-gnu/cinnamon-settings-daemon/csd-automount
OnlyShowIn=X-Cinnamon;
NoDisplay=true
EOF
fi

if [ -f /usr/share/applications/nemo.desktop ]; then
cat > /usr/share/applications/nemo.desktop <<EOF
[Desktop Entry]
Name=File Explorer
Name[am]=ፋይሎች
Name[ar]=الملفات
Name[bg]=Файлове
Name[ca]=Fitxers
Name[ca@valencia]=Fitxers
Name[cs]=Soubory
Name[cy]=Ffeiliau
Name[da]=Filer
Name[de]=Dateien
Name[el]=Αρχεία
Name[eo]=Dosieroj
Name[es]=Archivos
Name[et]=Failid
Name[eu]=Fitxategiak
Name[fi]=Tiedostot
Name[fr]=Fichiers
Name[fr_CA]=Fichiers
Name[he]=קבצים
Name[hr]=Nemo
Name[hu]=Fájlok
Name[id]=Berkas
Name[is]=Skrár
Name[kab]=Ifuyla
Name[ko]=파일
Name[lt]=Failai
Name[nl]=Bestanden
Name[pl]=Pliki
Name[pt]=Explorador de Ficheiros
Name[pt_BR]=Explorador de Arquivos
Name[ro]=Fișiere
Name[ru]=Файлы
Name[sk]=Súbory
Name[sl]=Datoteke
Name[sr]=Датотеке
Name[sr@latin]=Датотеке
Name[sv]=Filer
Name[th]=แฟ้ม
Name[tr]=Dosyalar
Name[uk]=Файли
Name[zh_CN]=文件
Name[zh_HK]=檔案
Comment=Access and organize files
Comment[am]=ፋይሎች ጋር መድረሻ እና ማደራጃ
Comment[ar]=الوصول إلى الملفات وتنظيمها
Comment[bg]=Достъп и управление на файлове
Comment[ca]=Organitzeu i accediu als fitxers
Comment[ca@valencia]=Organitzeu i accediu als fitxers
Comment[cs]=Přístup k souborům a jejich správa
Comment[cy]=Mynediad i drefnu ffeiliau
Comment[da]=Tilgå og organisér filer
Comment[de]=Dateien aufrufen und organisieren
Comment[el]=Πρόσβαση και οργάνωση αρχείων
Comment[en_GB]=Access and organise files
Comment[eo]=Atingi kaj organizi dosierojn
Comment[es]=Acceder a los archivos y organizarlos
Comment[et]=Ligipääs failidele ning failipuu korrastamine
Comment[eu]=Atzitu eta antolatu fitxategiak
Comment[fi]=Avaa ja järjestä tiedostoja
Comment[fr]=Accéder aux fichiers et les organiser
Comment[fr_CA]=Accéder aux fichiers et les organiser
Comment[he]=גישה לקבצים וארגונם
Comment[hr]=Pristupite i organizirajte datoteke
Comment[hu]=Fájlok elérése és rendszerezése
Comment[ia]=Acceder e organisar le files
Comment[id]=Akses dan kelola berkas
Comment[ie]=Accesse e ordina files
Comment[is]=Aðgangur og skipulag skráa
Comment[it]=Accede ai file e li organizza
Comment[kab]=Kcem udiɣ suddes ifuyla
Comment[ko]=파일 접근 및 정리
Comment[lt]=Gauti prieigą prie failų ir juos tvarkyti
Comment[nl]=Bestanden gebruiken en organiseren
Comment[pl]=Porządkowanie i dostęp do plików
Comment[pt]=Aceder e organizar ficheiros
Comment[pt_BR]=Acesse e organize arquivos
Comment[ro]=Accesează și organizează fișiere
Comment[ru]=Управление и доступ к файлам
Comment[sk]=Prístup a organizácia súborov
Comment[sl]=Dostop in razvrščanje datotek
Comment[sr]=Приступите датотекама и организујте их
Comment[sr@latin]=Приступите датотекама и организујте их
Comment[sv]=Kom åt och organisera filer
Comment[th]=เข้าถึงและจัดระเบียบแฟ้ม
Comment[tr]=Dosyalara eriş ve düzenle
Comment[uk]=Доступ до файлів та впорядковування файлів
Comment[zh_CN]=访问和组织文件
Comment[zh_HK]=存取與組織檔案
Exec=nemo %U
Icon=system-file-manager
# Translators: these are keywords of the file manager
Keywords=folders;filesystem;explorer;
Terminal=false
Type=Application
StartupNotify=false
Categories=GNOME;GTK;Utility;Core;
MimeType=inode/directory;application/x-gnome-saved-search;
Actions=open-home;open-computer;open-trash;

[Desktop Action open-home]
Name=Home
Name[af]=Tuis
Name[am]=ቤት
Name[ar]=المجلد الرئيسي
Name[be]=Дом
Name[bg]=Домашна папка
Name[bn]=হোম
Name[bs]=Početni direktorij
Name[ca]=Carpeta de l'usuari
Name[ca@valencia]=Carpeta de l'usuari
Name[cs]=Domov
Name[cy]=Cartref
Name[da]=Hjem
Name[de]=Persönlicher Ordner
Name[el]=Προσωπικός φάκελος
Name[eo]=Hejmo
Name[es]=Carpeta personal
Name[et]=Kodu
Name[eu]=Karpeta nagusia
Name[fi]=Koti
Name[fr]=Dossier personnel
Name[fr_CA]=Dossier personnel
Name[ga]=Baile
Name[gd]=Dhachaigh
Name[gl]=Cartafol persoal
Name[he]=בית
Name[hr]=Osobna mapa
Name[hu]=Saját mappa
Name[ia]=Al domo
Name[id]=Beranda
Name[ie]=Hem
Name[is]=Heimamappa
Name[ja]=ホーム
Name[kab]=Agejdan
Name[kk]=Үй
Name[kn]=ಮನೆ
Name[ko]=홈
Name[ku]=Mal
Name[lt]=Namai
Name[ml]=ആസ്ഥാനം
Name[mr]=मुख्य
Name[ms]=Rumah
Name[nb]=Hjem
Name[nl]=Persoonlijke map
Name[oc]=Dorsièr personal
Name[pl]=Katalog domowy
Name[pt]=Pasta Pessoal
Name[pt_BR]=Pasta pessoal
Name[ro]=Dosar personal
Name[ru]=Домашняя папка
Name[sk]=Domov
Name[sl]=Domov
Name[sr]=Почетна
Name[sr@latin]=Početna
Name[sv]=Hem
Name[ta]=இல்லம்
Name[tg]=Асосӣ
Name[th]=บ้าน
Name[tr]=Ev Dizini
Name[uk]=Домівка
Name[ur]=المنزل
Name[vi]=Nhà
Name[zh_CN]=主目录
Name[zh_HK]=家
Name[zh_TW]=家
Exec=nemo %U

[Desktop Action open-computer]
Name=Computer
Name[af]=Rekenaar
Name[am]=ኮምፒዩተር
Name[ar]=الكمبيوتر
Name[ast]=Ordenador
Name[be]=Кампутар
Name[bg]=Компютър
Name[bn]=কম্পিউটার
Name[bs]=Računar
Name[ca]=Ordinador
Name[ca@valencia]=Ordinador
Name[cs]=Počítač
Name[cy]=Cyfrifiadur
Name[de]=Rechner
Name[el]=Υπολογιστής
Name[eo]=Komputilo
Name[es]=Equipo
Name[et]=Arvuti
Name[eu]=Ordenagailua
Name[fi]=Tietokone
Name[fr]=Poste de travail
Name[fr_CA]=Poste de travail
Name[gd]=Coimpiutair
Name[gl]=Computador
Name[he]=מחשב
Name[hr]=Računalo
Name[hu]=Számítógép
Name[ia]=Computator
Name[id]=Komputer
Name[ie]=Computator
Name[is]=Tölva
Name[ja]=コンピュータ
Name[kab]=Aselkim
Name[kk]=Компьютер
Name[kn]=ಗಣಕ
Name[ko]=컴퓨터
Name[ku]=Komputer
Name[lt]=Kompiuteris
Name[ml]=കമ്പ്യൂട്ടർ
Name[mr]=संगणक
Name[ms]=Komputer
Name[nb]=Datamaskin
Name[nn]=Datamaskin
Name[oc]=Ordenador
Name[pl]=Komputer
Name[pt]=Computador
Name[pt_BR]=Computador
Name[ru]=Компьютер
Name[sk]=Počítač
Name[sl]=Računalnik
Name[sq]=Kompjuteri
Name[sr]=Рачунар
Name[sr@latin]=Računar
Name[sv]=Dator
Name[ta]=கணினி
Name[tg]=Компютер
Name[th]=คอมพิวเตอร์
Name[tr]=Bilgisayar
Name[uk]=Комп’ютер
Name[ur]=کمپیوٹر
Name[vi]=Máy tính
Name[zh_CN]=计算机
Name[zh_HK]=電腦
Name[zh_TW]=電腦
Exec=nemo computer:///

[Desktop Action open-trash]
Name=Trash
Name[af]=Asblik
Name[am]=ቆሻሻ
Name[ar]=سلة المهملات
Name[ast]=Papelera
Name[be]=Сметніца
Name[bg]=Кошче
Name[bn]=ট্র্যাশ
Name[bs]=Smeće
Name[ca]=Paperera
Name[ca@valencia]=Paperera
Name[cs]=Koš
Name[cy]=Sbwriel
Name[da]=Papirkurv
Name[de]=Papierkorb
Name[el]=Απορρίμματα
Name[en_GB]=Rubbish Bin
Name[eo]=Rubujo
Name[es]=Papelera
Name[et]=Prügi
Name[eu]=Zakarrontzia
Name[fi]=Roskakori
Name[fr]=Corbeille
Name[fr_CA]=Corbeille
Name[ga]=Bruscar
Name[gd]=An sgudal
Name[gl]=Lixo
Name[he]=אשפה
Name[hr]=Smeće
Name[hu]=Kuka
Name[ia]=Immunditia
Name[id]=Tempat sampah
Name[ie]=Paper-corb
Name[is]=Rusl
Name[it]=Cestino
Name[ja]=ゴミ箱
Name[kab]=Iḍumman
Name[kk]=Себет
Name[kn]=ಕಸಬುಟ್ಟಿ
Name[ko]=휴지통
Name[ku]=Avêtî
Name[lt]=Šiukšlinė
Name[ml]=ട്രാഷ്
Name[mr]=कचरापेटी
Name[ms]=Tong Sampah
Name[nb]=Papirkurv
Name[nds]=Papierkorb
Name[nl]=Prullenbak
Name[nn]=Papirkorg
Name[oc]=Escobilhièr
Name[pl]=Kosz
Name[pt]=Lixo
Name[pt_BR]=Lixeira
Name[ro]=Coș de gunoi
Name[ru]=Корзина
Name[sk]=Kôš
Name[sl]=Smeti
Name[sq]=Koshi
Name[sr]=Смеће
Name[sr@latin]=Kanta
Name[sv]=Papperskorg
Name[ta]=குப்பைத் தொட்டி
Name[tg]=Сабад
Name[th]=ถังขยะ
Name[tr]=Çöp
Name[uk]=Смітник
Name[ur]=ردی
Name[vi]=Thùng rác
Name[zh_CN]=回收站
Name[zh_HK]=垃圾桶
Name[zh_TW]=回收筒
Exec=nemo trash:///
EOF
fi

if [ -f /usr/share/applications/org.kde.kolourpaint.desktop ]; then
echo "Fixing Paint's shortcut name..."
#$maysudo sed -i 's/^Name=" .*$/Name=" Cam"/' /usr/share/applications/org.gnome.Cheese.desktop
cat > /usr/share/applications/org.kde.kolourpaint.desktop <<EOF
[Desktop Entry]

Name=Paint
Name[ar]=الرسام
Name[be]=Paint
Name[bg]=Paint
Name[br]=Paint
Name[bs]=Paint
Name[ca]=Paint
Name[ca@valencia]=Paint
Name[cs]=Paint
Name[cy]=Paint
Name[da]=Paint
Name[de]=Paint
Name[el]=Paint
Name[en_GB]=Paint
Name[eo]=Paint
Name[es]=Paint
Name[et]=Paint
Name[eu]=Paint
Name[fa]=Paint
Name[fi]=Paint
Name[fr]=Paint
Name[ga]=Paint
Name[gl]=Paint
Name[he]=Paint
Name[hi]=के-कलर-पेंट
Name[hne]=के-कलर-पेंट
Name[hr]=Paint
Name[hu]=Paint
Name[ia]=Paint
Name[is]=Paint
Name[it]=Paint
Name[ja]=Paint
Name[kk]=Paint
Name[km]=Paint
Name[ko]=Paint
Name[ku]=Paint
Name[lt]=Paint
Name[lv]=Paint
Name[ml]=കളർപെയിന്റ്
Name[mr]=कलरपेंट
Name[ms]=Paint
Name[nb]=Paint
Name[nds]=Paint
Name[ne]=रङ पेन्ट
Name[nl]=Paint
Name[nn]=Paint
Name[pa]=ਕੇ-ਰੰਗ-ਪੇਂਟ
Name[pl]=Paint
Name[pt]=Paint
Name[pt_BR]=Paint
Name[ro]=Paint
Name[ru]=Paint
Name[se]=Paint
Name[si]=Paint
Name[sk]=Paint
Name[sl]=Paint
Name[sr]=Колор-сликање
Name[sr@ijekavian]=Колор-сликање
Name[sr@ijekavianlatin]=Kolor-slikanje
Name[sr@latin]=Kolor-slikanje
Name[sv]=Paint
Name[ta]=நிற பெயின்ட்
Name[tg]=Paint
Name[th]=วาดภาพระบายสี-K
Name[tr]=Paint
Name[ug]=Paint
Name[uk]=Paint
Name[uz]=Paint
Name[uz@cyrillic]=Paint
Name[vi]=Paint
Name[x-test]=xxPaintxx
Name[zh_CN]=Paint 画图工具
Name[zh_HK]=Paint
Name[zh_TW]=Paint 小畫家
GenericName=Paint Program
GenericName[af]=Verf Program
GenericName[ar]=برنامج تلوين
GenericName[bg]=Графичен редактор
GenericName[br]=Goulev tresañ
GenericName[bs]=Program za slikanje
GenericName[ca]=Programa de dibuix
GenericName[ca@valencia]=Programa de dibuix
GenericName[cs]=Program pro malování
GenericName[cy]=Rhaglen Peintio
GenericName[da]=Maleprogram
GenericName[de]=Mal- und Zeichenprogramm
GenericName[el]=Πρόγραμμα ζωγραφικής
GenericName[en_GB]=Paint Program
GenericName[eo]=Pentrilo
GenericName[es]=Programa de pintura
GenericName[et]=Joonistamisprogramm
GenericName[eu]=Marrazteko programa
GenericName[fa]=برنامه رنگ
GenericName[fi]=Piirto-ohjelma
GenericName[fr]=Programme de dessin
GenericName[ga]=Clár Péinteála
GenericName[gl]=Programa de debuxo
GenericName[he]=תוכנית ציור
GenericName[hi]=पेंट प्रोग्राम
GenericName[hne]=पेंट प्रोग्राम
GenericName[hr]=Program za slikanje
GenericName[hu]=Rajzolóprogram
GenericName[ia]=Programma per pinger
GenericName[is]=Myndmálunarforrit
GenericName[it]=Programma di disegno
GenericName[ja]=ペイントプログラム
GenericName[kk]=Сурет салу бағдарламасы
GenericName[km]=កម្មវិធី​គូរ
GenericName[ko]=그리기 프로그램
GenericName[ku]=Bernameya Nexşe Kirinê
GenericName[lt]=Piešimo programa
GenericName[lv]=Krāsošanas programma
GenericName[ml]=പെയിന്റ് പ്രോഗ്രാം
GenericName[mr]=रंग कार्यक्रम
GenericName[ms]=Program Mewarna
GenericName[nb]=Tegneprogram
GenericName[nds]=Maalprogramm
GenericName[ne]=रङ्गयाउने कार्यक्रम
GenericName[nl]=Tekenprogramma
GenericName[nn]=Teikneprogram
GenericName[pa]=ਰੰਗ ਪਰੋਗਰਾਮ
GenericName[pl]=Program Paint
GenericName[pt]=Programa de Pintura
GenericName[pt_BR]=Programa de desenho
GenericName[ro]=Program de desenare
GenericName[ru]=Простой редактор изображений
GenericName[se]=Málenprográmma
GenericName[si]=පින්තාරු වැඩසටහන
GenericName[sk]=Kresliaci program
GenericName[sl]=Program za risanje
GenericName[sr]=Програм за сликање
GenericName[sr@ijekavian]=Програм за сликање
GenericName[sr@ijekavianlatin]=Program za slikanje
GenericName[sr@latin]=Program za slikanje
GenericName[sv]=Ritprogram
GenericName[ta]=பெயிண்ட் நிரலி
GenericName[tg]=Муҳаррири графикӣ
GenericName[th]=โปรแกรมวาดภาพ
GenericName[tr]=Boyama Uygulaması
GenericName[ug]=سىزىش پروگراممىسى
GenericName[uk]=Програма для малювання
GenericName[uz]=Chizish dasturi
GenericName[uz@cyrillic]=Чизиш дастури
GenericName[vi]=Chương trình vẽ
GenericName[wa]=Program di dessinaedje
GenericName[xh]=Udweliso lwenkqubo lwepeyinti
GenericName[x-test]=xxPaint Programxx
GenericName[zh_CN]=画图程序
GenericName[zh_HK]=繪圖程式
GenericName[zh_TW]=繪圖程式

Comment=An easy-to-use paint program
Comment[ar]=برنامج تلوين سهل الاستخدام
Comment[bg]=Лесна за изпълнение програма за изпълнение
Comment[ca]=Un programa de dibuix senzill d'usar
Comment[ca@valencia]=Un programa de dibuix senzill d'utilitzar
Comment[cs]=Snadný nástroj pro malování
Comment[da]=Et nemt tegneprogram
Comment[de]=Ein einfach zu benutzendes Mal- und Zeichenprogramm
Comment[el]=Ένα εύκολο στη χρήση πρόγραμμα ζωγραφικής
Comment[en_GB]=An easy-to-use paint program
Comment[es]=Un programa para pintar fácil de usar
Comment[et]=Lihtne joonistamisprogramm
Comment[eu]=Erabiltzen erraza den marrazketa programa
Comment[fi]=Helppokäyttöinen piirto-ohjelma
Comment[fr]=Un programme de dessin facile à utiliser
Comment[gl]=Un programa de debuxo fácil de usar.
Comment[hu]=Egyszerűen használható rajzprogram
Comment[ia]=Un programma pro pinger facilemente
Comment[is]=Einfalt forrit til að teikna og mála myndir
Comment[it]=Un programma di disegno semplice da usare
Comment[ko]=사용하기 쉬운 그리기 프로그램
Comment[lt]=Paprasta piešimo programa
Comment[ml]=ലളിതമായി ഉപയോഗിക്കാവുന്ന പെയിന്റ് പ്രോഗ്രാം
Comment[nl]=Een gemakkelijk te gebruiken tekenprogramma
Comment[nn]=Eit teikneprogram som er lett å bruka
Comment[pl]=Łatwy w użyciu program do malowania
Comment[pt]=Um programa de pintura simples de usar
Comment[pt_BR]=Um programa de desenho fácil de usar
Comment[ru]=Простая в использовании программа для рисования
Comment[sk]=Jednoduchý maľovací program
Comment[sl]=Enostaven program za risanje
Comment[sv]=Ett lättanvänt ritprogram
Comment[tr]=Kolay kullanılır bir boyama programı
Comment[uk]=Проста у користуванні програма для малювання
Comment[x-test]=xxAn easy-to-use paint programxx
Comment[zh_CN]=一款简易画图程序
Comment[zh_TW]=易於使用的繪圖程式

Icon=kolourpaint

Type=Application
Exec=kolourpaint %u
X-DocPath=kolourpaint/index.html
StartupWMClass=kolourpaint

# SYNC: Run kolourpaint --mimetypes
MimeType=application/x-krita;application/x-navi-animation;image/avif;image/bmp;image/gif;image/heif;image/jpeg;image/jxl;image/openraster;image/png;image/svg+xml;image/svg+xml-compressed;image/tiff;image/vnd.adobe.photoshop;image/vnd.microsoft.icon;image/vnd.wap.wbmp;image/webp;image/x-eps;image/x-exr;image/x-hdr;image/x-icns;image/x-mng;image/x-pcx;image/x-pic;image/x-portable-bitmap;image/x-portable-graymap;image/x-portable-pixmap;image/x-rgb;image/x-sun-raster;image/x-tga;image/x-xbitmap;image/x-xcf;image/x-xpixmap;

Categories=Qt;KDE;Graphics;2DGraphics;RasterGraphics;
Terminal=false

EOF
fi
#from https://forum.snapcraft.io/t/overriding-desktop-files-on-ubuntu-snaps/6599/4

if [ -f /usr/share/applications/org.gnome.Characters.desktop ]; then
echo "Fixing Character Map's shortcut name..."
#$maysudo sed -i 's/^Name=" .*$/Name=" Cam"/' /usr/share/applications/org.gnome.Cheese.desktop
cat > /usr/share/applications/org.gnome.Characters.desktop <<EOF
[Desktop Entry]
Type=Application
Name=Characters Map
Name[pt]=Mapa de Caracteres
Name[pt_BR]=Mapa de Caracteres
Name[es]=Mapa de Caracteres
Comment=Utility application to find and insert unusual characters
# Translators: Do NOT translate or transliterate this text (this is an icon file name)!
Icon=org.gnome.Characters
Exec=/usr/bin/gnome-characters
DBusActivatable=true
StartupNotify=true
Categories=GNOME;GTK;Utility;X-GNOME-Utilities;
# Translators: Search terms to find this application. Do NOT translate or localize the semicolons! The list MUST also end with a semicolon!
Keywords=characters;unicode;punctuation;math;letters;emoji;emoticon;symbols;
X-Purism-FormFactor=Workstation;Mobile;
X-Ubuntu-Gettext-Domain=org.gnome.Characters
EOF
fi

if [ -f /usr/share/applications/teams.desktop ]; then
echo "Fixing MS Teams' shortcut name..."
#$maysudo sed -i 's/^Name=" .*$/Name=" Witchcraft"/' /usr/share/applications/org.gnome.Terminal.desktop
cat > /usr/share/applications/teams.desktop <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=Microsoft Teams
Comment=Microsoft Teams for Linux is your chat-centered workspace in Office 365.
Exec=teams %U
Icon=teams
Terminal=false
StartupNotify=true
StartupWMClass=Microsoft Teams
Categories=Network;
MimeType=x-scheme-handler/msteams;
X-KDE-Protocols=teams
Actions=QuitTeams;
X-GNOME-UsesNotifications=true;

[Desktop Action QuitTeams]
Name=Quit Teams
Name[ar]=إنهاء اسكايب
Name[bg]=Изход от Teams
Name[ca]=Surt de Teams
Name[cs]=Ukončit Teams
Name[da]=Afslut Teams
Name[en]=Quit Teams
Name[de]=Teams beenden
Name[el]=Έξοδος από το Teams
Name[es]=Salir de Teams
Name[et]=Sulge Teams
Name[fi]=Sulje Teams
Name[fr]=Quitter Teams
Name[he]=יציאה מסקייפ
Name[hi]=स्काइप से बाहर निकलें
Name[hr]=Izađi iz Teamsa
Name[hu]=A Teams bezárása
Name[id]=Keluar dari Teams
Name[it]=Esci da Teams
Name[ja]=Teams を終了
Name[ko]=Teams 종료
Name[lt]=Išjungti „Teams“
Name[lv]=Iziet no Teams
Name[ms]=Keluar Teams
Name[nb]=Avslutt Teams
Name[nl]=Teams afsluiten
Name[pl]=Zamknij Teams'a
Name[pt]=Sair do Teams
Name[pt_BR]=Encerrar o Teams
Name[ro]=Închide Teams
Name[ru]=Выйти из Скайпа
Name[sk]=Ukončiť aplikáciu Teams
Name[sl]=Zapusti Teams
Name[sr_Latn]=Zatvori Teams
Name[sv]=Avsluta Teams
Name[th]=จบการทำงาน Teams
Name[tr]=Teams'tan Çık
Name[uk]=Вийти зі Teams
Name[vi]=Thoát Teams
Name[zh_CN]=退出 Teams
Name[zh_TW]=結束 Teams
Exec=/usr/bin/teams --quit
OnlyShowIn=Unity;
EOF
fi

if [ -f /usr/share/applications/indicator-stickynotes.desktop ]; then
echo "Fixing Sticky Notes' shortcut name..."
#$maysudo sed -i 's/^Name=" .*$/Name=" Cam"/' /usr/share/applications/org.gnome.Cheese.desktop
cat > /usr/share/applications/indicator-stickynotes.desktop <<EOF
[Desktop Entry]
Type=Application
Name=Sticky Notes
Name[ar]=Sticky Notes
Name[be]=нататак
Name[ca]=Notes adhesives
Name[en_GB]=Sticky Notes
Name[es]=Notas adhesivas
Name[eu]=Ohar itsaskorren jakinarazlea
Name[fr]=Pense-bêtes
Name[he]=Sticky Notes
Name[id]=Catatan Tempel
Name[it]=Sticky Notes
Name[ko]=스티키노트
Name[ms]=Nota Lekat
Name[pt]=Notas Autoadesivas
Name[pt_BR]=Notas Autoadesivas
Name[sv]=Indicator Stickynotes
Name[tr]=Yapışkan Notlar
Name[uk]=Нотатки
Name[zh_CN]=Sticky Notes
GenericName=Sticky Notes
GenericName[ar]=مذكرات لاصقة
GenericName[be]=Ліпучыя нататкі
GenericName[ca]=Notes adhesives
GenericName[cs]=Lepící poznámky
GenericName[da]=Post-It noter
GenericName[de]=Klebezettel
GenericName[el]=Sticky Notes
GenericName[en_GB]=Sticky Notes
GenericName[es]=Notas adhesivas
GenericName[eu]=Ohar itsaskorrak
GenericName[fr]=Pense-bêtes
GenericName[he]=פתקים נצמדים
GenericName[hi]=स्टिकी नोट्स
GenericName[hr]=Ljepljive bilješke
GenericName[hu]=Ragadós jegyzetek
GenericName[id]=Catatan Tempel
GenericName[it]=Note adesive
GenericName[ko]=스티키 노트
GenericName[lt]=Lipnūs rašteliai
GenericName[ms]=Nota Lekat
GenericName[pl]=Żółte karteczki
GenericName[pt]=Sticky Notes
GenericName[pt_BR]=Notas adesivas
GenericName[ru]=Sticky Notes
GenericName[si]=අලවන සටහන්
GenericName[sk]=Sticky Notes
GenericName[sv]=Fästisar
GenericName[tr]=Yapışkan Notlar
GenericName[uk]=Липкі нотатки
GenericName[zh_CN]=便笺
GenericName[zh_TW]=便利貼
Comment=Write reminders on notes
Comment[ar]=كتابة المذكّرات في الملاحظات
Comment[be]=Дадаваць напаміны на нататкі
Comment[ca]=Escriviu els recordatoris a les notes
Comment[es]=Escriba los recordatorios en notas
Comment[eu]=Idatzi gogorarazleak oharretan
Comment[fr]=Écrire les rappels sur les notes
Comment[he]=כתיבת התזכורות בפתקיות
Comment[id]=Tulis pengingat pada catatan
Comment[it]=Scrivi promemoria sulle note
Comment[ko]=알람 지정
Comment[ms]=Tulis peringatan atas nota
Comment[pt]=Escrever lembretes nas notas
Comment[pt_BR]=Escreva lembretes nas notas
Comment[sv]=Skriv påminnelser på Fästisar
Comment[uk]=Запишіть нагадування в нотатках
Comment[zh_CN]=在便签上填写备忘录
Comment[zh_TW]=在便條紙上填寫備忘錄
Icon=indicator-stickynotes
Exec=indicator-stickynotes
Categories=Utility;TextTools;
Hidden=False
X-GNOME-autostart-enabled=true
EOF
fi

if [ -f /usr/share/applications/org.gnome.gedit.desktop ]; then
echo "Fixing Notepad's shortcut name..."
#$maysudo sed -i 's/^Name=" .*$/Name=" Cam"/' /usr/share/applications/org.gnome.Cheese.desktop
cat > /usr/share/applications/org.gnome.gedit.desktop <<EOF
[Desktop Entry]
Name=Notepad
Name[pt]=Bloco de Notas
Name[pt_BR]=Bloco de Notas
Comment=Edit text files
Exec=gedit %U
Terminal=false
Type=Application
StartupNotify=true
MimeType=text/plain;application/x-zerosize;
Icon=org.gnome.gedit
Categories=GNOME;GTK;Utility;TextEditor;
Actions=new-window;new-document;
# Translators: Do NOT translate or localize the semicolons. The list MUST also
# end with a semicolon. It contains search terms to find this application.
Keywords=Text;Editor;Plaintext;Write;gedit;
DBusActivatable=true
X-Ubuntu-Gettext-Domain=gedit

[Desktop Action new-window]
Name=New Window
Exec=gedit --new-window

[Desktop Action new-document]
Name=New Document
Exec=gedit --new-document
EOF
fi
