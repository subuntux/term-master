#!/bin/bash

echo "[*] Warning"
echo "[*] You need Termux X11 APK"
echo "[*] And Termux X11 APK"
menu_1() {
    echo "[Term: Tool V.1.0]"
    echo "Select an Option"
    echo "[1]-Backup Termux"
    echo "[2]-Restore Termux"
    echo "[3]-Install x11"
    echo "[4]-Install Linux"
    echo "[5]-Execute a Command"
    echo "[6]-Start Klinux Terminal"
    echo "[7]-Download Termux X11 APK"
    echo "[8]-Download Termux API APK"
    echo "[9]-Update Term-Master"
    echo "[0]-Exit"
    
    read -p "Select-| " start
    
    case $start in 
        0)
            exit 0
            ;;
        1)
            termux_backup
            ;;
        2)
            termux_restore
            ;;
        3)
            termux_x11
            ;;
        4)
            termux_linux
            ;;
        5)
            run_commands
            ;;
        6)
            start_terminal
            ;;
        7)
            termux-open-url https://github.com/termux/termux-x11/actions/workflows/debug_build.yml
            ;;
        8)
            termux-open-url https://github.com/termux/termux-api/actions
            pkg install termux-api
            ;;
        9)
            update_term
            ;;
        *)
            echo "Invalid Option"
            ;;
    esac
}

termux_backup() {
    read -p "Which Name for Backup?: " name1
    
    echo "[*] Create $HOME/.backup/$name1"
    mkdir -p $HOME/.backup/$name1
    termux-backup create -f $name1.tar.gz --all
    mv $name1.tar.gz $HOME/.backup/$name1
    echo "[*] Backup Finish"
}

termux_restore() {
    read -p "Which Name have Backup?: " name2
    
    echo "[*] Search $HOME/.backup/$name2"
    cp $HOME/.backup/$name2/$name2.tar.gz .
    termux-restore $name2.tar.gz
    rm $name2.tar.gz
    echo "[*] Restore Finish"
}

termux_x11() {
    echo "X11 Menu"
    echo "[1]-Install X11 Repo (Needed)"
    echo "[2]-Install GUI"
    echo "[3]-Install Browser"
    echo "[4]-Install XTERM"
    echo "[5]-VNC"
    echo "[6]-Termux X11"
    echo "[0]-Exit"
    
    read -p "Select-| " x11_menu
    
    case $x11_menu in 
        0)
            exit 0
            ;;
        1)
            pkg install x11-repo -y
            ;;
        2)
            gui_menu
            ;;
        3)
            pkg install firefox -y
            ;;
        4)
            pkg install aterm -y
            ;;
        5)
            vnc_menu
            ;;
        6)
            x11_setup
            ;;
        *)
            echo "Invalid Option"
            ;;
    esac
}

termux_linux() {
    echo "Linux Distributions Menu"
    echo "[1]-Install proot-distro (Needed)"
    echo "[2]-Install Distro"
    echo "[3]-Backup Distro"
    echo "[4]-Restore Distro"
    echo "[5]-Login Distro"
    echo "[0]-Exit"
    
    read -p "Select-| " option3
    
    case $option3 in 
        0)
            exit 0
            ;;
        1)
            pkg install proot-distro -y
            ;;
        2)
            select_distro
            ;;
        3)
            backup_distro
            ;;
        4)
            restore_distro
            ;;
        5)
            read -p "Distro: " distro 
            pd sh $distro
            ;;
        *)
            echo "Invalid Option"
            ;;
    esac
}

run_commands() {
    read -p "[~#] " cmd 
    eval "$cmd"
}

start_terminal() {
    while true; do 
        read -p "[klinux@localhost~$]¢ " cmd2

        # Splits the input into an array
        read -ra cmd_parts <<< "$cmd2"

        # Checks if the first part of the input is 'tli'
        if [ "${cmd_parts[0]}" = "tli" ]; then
            # Removes the first element ('tli') from the array
            unset cmd_parts[0]
            # Calls tli_wrapper with the remaining arguments
            tli_wrapper "${cmd_parts[@]}"
        elif [ "$cmd2" = "setup" ]; then
            # Creates the directory, ensuring it exists
            mkdir -p $HOME/.cache/tli/
        elif [ "$cmd2" = "cache" ]; then 
            # Lists contents of the cache directory
            ls $HOME/.cache/tli/
        else
            # Executes any other command
            eval "$cmd2"
        fi 
    done
}

gui_menu() {
    echo "GUI Menu"
    echo "[1]-XFCE4"
    echo "[2]-LXDE"
    echo "[0]-Exit"
    
    read -p "Select-| " select_gui
    
    case $select_gui in 
        0)
            exit 0
            ;;
        1)
            xfce_menu
            ;;
        2)
            lxde_menu
            ;;
        *)
            echo "Invalid Option"
            ;;
    esac
}

vnc_menu() {
    echo "VNC Menu"
    echo "[1]-Install Tigervnc"
    echo "[2]-Setup Tigervnc"
    echo "[3]-Start Tigervnc"
    echo "[4]-Stop Tigervnc"
    echo "[0]-Exit"
    
    read -p "Select-| " select_vnc
    
    case $select_vnc in 
        0)
            exit 0
            ;;
        1)
            pkg install tigervnc -y
            ;;
        2)
            vncserver
            ;;
        3)
            vncserver -localhost 
            export DISPLAY=":1"
            ;;
        4)
            vncserver -kill :1
            ;;
        *)
            echo "Invalid Option"
            ;;
    esac
}

x11_setup() {
    echo "Termux X11"
    echo "[1]-Install Termux X11"
    echo "[2]-Start Termux X11"
    echo "[3]-Stop Termux X11"
    echo "[0]-Exit"
    
    read -p "Select-| " x11_sl
    
    case $x11_sl in 
        0)
            exit 0
            ;;
        1)
            pkg install termux-x11-nightly -y
            ;;
        2)
            termux-x11 :1 &
            export DISPLAY=":1"
            ;;
        3)
            pkill Xvfb
            ;;
        *)
            echo "Invalid Option8"
            ;;
    esac
}

select_distro() {
    echo "Distro Manager"
    echo "[1]-Alpine"
    echo "[2]-Arch"
    echo "[3]-Artix"
    echo "[4]-Debian (Bookworm)"
    echo "[5]-Debian (Bullseye)"
    echo "[6]-Deepin"
    echo "[7]-Fedora"
    echo "[8]-Manjaro"
    echo "[9]-OpenKylin"
    echo "[10]-OpenSUSE"
    echo "[11]- Pardus"
    echo "[12]-Ubuntu (23.10)"
    echo "[13]-Ubuntu LTS (New)"
    echo "[14]-Ubuntu LTS (Old)"
    echo "[15]-Void Linux"
    echo "[0]-Exit"
    
    read -p "Select-| " alias1
    
    case $alias1 in 
        0)
            exit 0 
            ;;
        1)
            pd i alpine 
            ;;
        2)
            pd i archlinux
            ;;
        3)
            pd i artix 
            ;;
        4)
            pd i debian 
            ;;
        5)
            pd i debian-oldstable
            ;;
        6)
            pd i deepin 
            ;;
        7)
            pd i fedora 
            ;;
        8)
            pd i manjaro 
            ;;
        9)
            pd i openkylin 
            ;;
        10)
            pd i opensuse 
            ;;
        11)
            pd i pardus 
            ;;
        12)
            pd i ubuntu 
            ;;
        13)
            pd i ubuntu-lts 
            ;;
        14)
            pd i ubuntu-oldlts
            ;;
        15)
            pd i void 
            ;;
        *)
            echo "Invalid Option"
            ;;
    esac
}

backup_distro() {
    echo "Distro Manager"
    echo "[1]-Alpine"
    echo "[2]-Arch"
    echo "[3]-Artix"
    echo "[4]-Debian (Bookworm)"
    echo "[5]-Debian (Bullseye)"
    echo "[6]-Deepin"
    echo "[7]-Fedora"
    echo "[8]-Manjaro"
    echo "[9]-OpenKylin"
    echo "[10]-OpenSUSE"
    echo "[11]- Pardus"
    echo "[12]-Ubuntu (23.10)"
    echo "[13]-Ubuntu LTS (New)"
    echo "[14]-Ubuntu LTS (Old)"
    echo "[15]-Void Linux"
    echo "[16]-Create Cache"
    echo "[0]-Exit"
    
    read -p "Select-| " alias2
    
    case $alias2 in 
        0)
            exit 0 
            ;;
        1)
            pd backup alpine --output alpine.tar.gz
            mv alpine.tar.gz .cache/distro
            ;;
        2)
            pd backup archlinux --output arch.tar.gz
            mv arch.tar.gz .cache/distro
            ;;
        3)
            pd backup artix --output artix.tar.gz
            mv artix.tar.gz .cache/distro
            ;;
        4)
            pd backup debian --output debian.tar.gz 
            mv debian.tar.gz .cache/distro
            ;;
        5)
            pd backup-oldstable --output debian.tar.gz
            mv debian.tar.gz .cache/distro
            ;;
        6)
            pd backup deepin --output deepin.tar.gz
            mv deepin.tar.gz .cache/distro
            ;;
        7)
            pd backup fedora --output fedora.tar.gz
            mv fedora.tar.gz .cache/distro
            ;;
        8)
            pd backup manjaro --output manjaro.tar.gz
            mv manjaro.tar.gz .cache/distro
            ;;
        9)
            pd backup openkylin --output openkylin.tar.gz
            mv openkylin.tar.gz .cache/distro
            ;;
        10)
            pd backup opensuse --output opensuse.tar.gz
            mv opensuse.tar.gz .cache/distro
            ;;
        11)
            pd backup pardus --output pardus.tar.gz
            mv pardus.tar.gz .cache/distro
            ;;
        12)
            pd backup ubuntu --output ubuntu.tar.gz
            mv ubuntu.tar.gz .cache/distro
            ;;
        13)
            pd backup ubuntu-lts --output ubuntu.tar.gz
            mv ubuntu.tar.gz .cache/distro
            ;;
        14)
            pd backup ubuntu-oldlts --output ubuntu.tar.gz
            mv upuntu.tar.gz .cache/distro
            ;;
        15)
            pd backup void 
            ;;
        16)
            mkdir -p .cache/distro
            ;;
        *)
            echo "Invalid Option"
            ;;
    esac
}

restore_distro() {
    echo "Distro Manager"
    echo "[1]-Alpine"
    echo "[2]-Arch"
    echo "[3]-Artix"
    echo "[4]-Debian (Bookworm)"
    echo "[5]-Debian (Bullseye)"
    echo "[6]-Deepin"
    echo "[7]-Fedora"
    echo "[8]-Manjaro"
    echo "[9]-OpenKylin"
    echo "[10]-OpenSUSE"
    echo "[11]- Pardus"
    echo "[12]-Ubuntu (23.10)"
    echo "[13]-Ubuntu LTS (New)"
    echo "[14]-Ubuntu LTS (Old)"
    echo "[15]-Void Linux"
    echo "[0]-Exit"
    
    read -p "Select-| " alias1
    
    case $alias1 in 
        0)
            exit 0 
            ;;
        1)
            cp .cache/distro/alpine.tar.gz .
            pd restore alpine.tar.gz
            rm alpine.tar.gz
            ;;
        2)
            cp .cache/distro/arch.tar.gz .
            pd restore arch.tar.gz
            rm arch.tar.gz
            ;;
        3)
            cp .cache/distro/artix.tar.gz .
            pd restore artix.tar.gz
            rm artix.tar.gz
            ;;
        4)
            cp .cache/distro/debian.tar.gz .
            pd restore debian.tar.gz
            rm debian.tar.gz
            ;;
        5)
            cp .cache/distro/debian.tar.gz .
            pd restore debian.tar.gz
            rm debian.tar.gz
            ;;
        6)
            cp .cache/distro/deepin.tar.gz .
            pd restore deepin.tar.gz
            rm deepin.tar.gz
            ;;
        7)
            cp .cache/distro/fedora.tar.gz .
            pd restore fedora.tar.gz
            rm fedora.tar.gz
            ;;
        8)
            cp .cache/distro/manjaro.tar.gz .
            pd restore manjaro.tar.gz
            rm manjaro.tar.gz
            ;;
        9)
            cp .cache/distro/openkylin.tar.gz .
            pd restore openkylin.tar.gz
            rm openkylin.tar.gz
            ;;
        10)
            cp .cache/distro/opensuse.tar.gz .
            pd restore opensuse.tar.gz
            rm opensuse.tar.gz
            ;;
        11)
            cp .cache/distro/pardus.tar.gz .
            pd restore pardus.tar.gz
            rm pardus.tar.gz
            ;;
        12)
            cp .cache/distro/ubuntu.tar.gz .
            pd restore ubuntu.tar.gz
            rm ubuntu.tar.gz
            ;;
        13)
            cp .cache/distro/ubuntu.tar.gz .
            pd restore ubuntu.tar.gz
            rm ubuntu.tar.gz
            ;;
        14)
            cp .cache/distro/ubuntu.tar.gz .
            pd restore ubuntu.tar.gz
            rm ubuntu.tar.gz
            ;;
        15)
            cp .cache/distro/ubuntu.tar.gz .
            pd restore ubuntu.tar.gz
            rm ubuntu.tar.gz 
            ;;
        *)
            echo "Invalid Option"
            ;;
    esac
}

xfce_menu() {
    echo "XFCE4 Menu"
    echo "[1]-Install XFCE4"
    echo "[2]-Start XFCE4 Session"
    echo "[3]-Start XFCE4 Terminal"
    echo "[0]-Exit"
    
    read -p "Select-| " xfce4_op
    
    case $xfce4_op in 
        0)
            exit 0 
            ;;
        1)
            pkg install xfce4 -y
            ;;
        2)
            xfce4-session
            ;;
        3)
            xfce4-terminal
            ;;
        *)
            echo "Invalid Option"
            ;;
    esac
}

lxde_menu() {
        echo "LXDE Menu"
    echo "[1]-Install LXDE"
    echo "[2]-Start LXDE Session"
    echo "[3]-Start LXDE Terminal"
    echo "[0]-Exit"
    
    read -p "Select-| " lxde_op
    
    case $lxde_op in 
        0)
            exit 0 
            ;;
        1)
            pkg install lxde -y
            ;;
        2)
            lxde-session
            ;;
        3)
            lxde-terminal
            ;;
        *)
            echo "Invalid Option"
            ;;
    esac
}

update_term() {
    wget https://term-master.netlify.app/update/latest.deb 
    dpkg -i latest.deb 
    rm latest.deb 
}

login() {
    read -p "Distro: " distro 
    pd sh $distro
}



help() {
    echo "Instruction"
    echo "Execute: term-master [function]"
    echo "Following Functions"
    echo "--start"
    echo "--backup"
    echo "--restore"
    echo "--x11"
    echo "--linux"
    echo "--cmd"
    echo "--klinux"
    echo "--gui"
    echo "--vnc"
    echo "--x11-setup"
    echo "--distro"
    echo "--b-distro"
    echo "--r-distro"
    echo "--xfce"
    echo "--lxde"
    echo "--api"
    echo "--update"
    echo "--login"
}

tli_wrapper() {
    DEINE_WEBSITE_URL="https://term-master.netlify.app/pkg/"

    COMMAND=$1
    PACKAGE_NAME=$2

    # Vollständige URL der DEB-Datei
    DEB_URL="${DEINE_WEBSITE_URL}/${PACKAGE_NAME}.deb"

    # Funktion, um die DEB-Datei herunterzuladen und zu installieren
    download_and_install_deb() {
        echo "Versuche, DEB-Datei herunterzuladen..."
        wget -q --spider $DEB_URL

        if [ $? -eq 0 ]; then
            echo "DEB-Datei gefunden. Herunterladen..."
            wget $DEB_URL -O "${PACKAGE_NAME}.deb"
            echo "Installiere DEB-Datei..."
            dpkg -i "${PACKAGE_NAME}.deb"
        else
            echo "Keine DEB-Datei gefunden. Führe pkg aus..."
            pkg $COMMAND $PACKAGE_NAME
        fi
    }

    # Hauptlogik des Skripts
    case $COMMAND in
        install)
            download_and_install_deb
            ;;
        *)
            echo "Führe pkg mit originalen Parametern aus..."
            pkg "$@"
            ;;
    esac
}

direct_to_menu() {
  case "$1" in
    --start)
      menu_1
      ;;
    --backup)
      termux_backup
      ;;
    --restore)
      termux_restore
      ;;
    --x11)
        termux_x11
        ;;
    --linux)
        termux_linux
        ;;
    --cmd)
        run_commands
        ;;
    --klinux)
        start_terminal
        ;;
    --gui)
        gui_menu
        ;;
    --vnc)
        vnc_menu
        ;;
    --x11-setup)
        x11_setup
        ;;
    --distro)
        select_distro
        ;;
    --b-distro)
        backup_distro
        ;;
    --r-distro)
        restore_distro
        ;;
    --xfce)
        xfce_menu
        ;;
    --lxde)
        lxde_menu
        ;;
    --api)
        pkg install termux-api -y
        ;;
    --update)
        update_term
        ;;
    --login)
        login
        ;;
    *)
      echo "Menu not Exist: $1"
      ;;
  esac
}


main() {
  if [ -z "$1" ]; then
    menu_1
  else
    direct_to_menu "$1"
    exit 0
  fi
}
main "$@"

main

direct_to _menu "$1"