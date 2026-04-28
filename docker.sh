#docker tool
#created by MichaelCode-tech
main_menu(){
while true;do
	clear
	echo "======Main Menu======"
	echo "1.Docker"
	echo "2.Exit"
	read -p "choose: " choose
	case $choose in
		1)
			Docker_Menu;;
		2)
			exit 0
			break;;
		*)
			echo "please evter vaild answer ";;
	esac
		done
	}
Docker_Menu(){
while true;do
	clear
	echo "====== Docker Menu ======"
	echo "--- Containers ---"
	echo "1. Run container"
	echo "2. List containers"
	echo "3. Stop container"
	echo "4. Remove container"
	echo "5. Exec into container"
	echo "6. Logs of container"
	echo "7. Rename container"
	echo "8. Kill container"
	echo "9. Pause container"
	echo "101.restart container"

	echo "--- Images ---"
	echo "10. List images"
	echo "11. Search for image 🔍"
	echo "12. Remove image"
	
	echo "--- System ---"
	echo "13. Docker info"
	echo "14. Docker version"
	echo "15. Docker system cleanup"

	echo "--- Auth ---"
	echo "16. Login"
	echo "17. Logout"

	echo "--- Network & Volume ---"
	echo "18. Manage network"
	echo "19. Manage volume"

	echo "--- Advanced ---"
	echo "20. Docker Compose (Beta)"

	echo "0. Back to main menu"
	echo "00.download docker"
	read -p "choose: " choose

	case $choose in
		0)
			main_menu;;
		00)
			sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo usermod -aG docker $USER
sudo mkdir -p /mnt/srv/{docker/{comp,cont},data}
sudo chown -R $USER:$USER /mnt/srv/{docker,data}

;;
		1)
		docker_run;;
	2)
	docker stats;;
3)
	read -p "enter the name of container to stop: " stop_co
docker container stop "%stop_co";;
4)
	rm_co;;
5)
	read -p "enter the container name you want exec to " execto
	docker exec -it $execto bash
	;;
6)
	read -p "Enter a container to follow logs: " logs
docker logs -f "$logs";;
7)
	rename_co;;

8)
	read -p "enter container to kell: " kill_co
	docker container kill $kill_co;;
9)
docker prune ;;
101)
read -p "enter container name to restart: " co_res
docker container restart $co_res;;
10)
	watch docker image ls;;
11)
	read -p "enter image name to search: " search
	docker search "$search"
	sleep 10;;
12)
	rm_image;;
13)
	docker info
	sleep 10;;
14)
	docker version
	sleep 10;;
15)
	docker system prune;;
16)
	docker login
	sleep 10;;
17)
	docker logout
	sleep 5;;
18)
	manage_net;;
19)
	volume_func;;
20)
	docker_compo;;
*)
	echo "Enter a vaild option"
esac
done
}
docker_run(){
	docker_run() {
    while true; do
        # Inputs
        read -p "Enter image name: " image
        read -p "Enter container name (optional): " name
        read -p "Enter port mapping (optional, e.g., 8080:80): " port
        read -p "Run container in background? (Y/n): " detach
        read -p "Do you want a memory limit? (y/N): " mem_limit
        read -p "Enter specific network (optional): " network
        read -p "Enter volume (optional, e.g., /host:/container): " volume

        # Build docker run command
        cmd="docker run"

        # detach
       if  [[ "$detach" =~ ^[Yy]$ ]]; then
	       cmd="$cmd -d"
fi

        # name
        [ -n "$name" ] && cmd="$cmd --name $name"

        # port
        [ -n "$port" ] && cmd="$cmd -p $port"

        # memory
        if [[ "$mem_limit" =~ ^[Yy]$ ]]; then
            read -p "Enter memory limit (e.g., 512m): " mem_limits
            [ -n "$mem_limits" ] && cmd="$cmd -m $mem_limits"
        fi

        # network
        [ -n "$network" ] && cmd="$cmd --network $network"

        # volume
        [ -n "$volume" ] && cmd="$cmd -v $volume"

        # image (required)
        cmd="$cmd $image"

        # Show and execute
        echo "Running: $cmd"
        eval $cmd

        read -p "Press enter to run another container or Ctrl+C to exit..."
    done
}
}
rm_co(){
while true; do
    read -p "Enter container name to remove: " rm_co
    read -p "Do you want to remove this container with its volume? (y/n): " choose
    case $choose in
        Y|y|Yes|YES)
            docker container rm -f -v "$rm_co"
           break ;;
        N|n|No|NO)
            docker container rm -f "$rm_co"
            break;;
        *)
            echo "Enter a valid option"
            ;;
    esac
done
}
rename_co(){
	 while true; do
        read -p "Enter the container name to rename (or type 'exit' to go back): " co_name
        [[ "$co_name" =~ ^[Ee][Xx][Ii][Tt]$ ]] && break

        # تحقق من وجود الـ container الأصلي
        if ! docker ps -a --format '{{.Names}}' | grep -w "$co_name" > /dev/null; then
            echo "Error: Container '$co_name' does not exist!"
            continue
        fi

        read -p "Enter the new name for the container: " co_new

        # تحقق من أن الاسم الجديد مش مستخدم بالفعل
        if docker ps -a --format '{{.Names}}' | grep -w "$co_new" > /dev/null; then
            echo "Error: Container name '$co_new' is already in use!"
            continue
        fi

        # تنفيذ rename
        docker container rename "$co_name" "$co_new" && \
            echo "Container '$co_name' renamed to '$co_new' successfully."

    done
}
rm_image(){
while true;do
	clear
echo "1.remove specific image"
echo "2.purne all images"
echo "0.back to Docker menu"
read -p "choose: " choose
case $choose in
	1)
		read -p "enter image to remove: " image_rm
	docker image rm "$image_rm";;
2)
docker image prune;;
0)
	Docker_Menu;;
*)
	echo "please enter a vaild option";;


esac

done
}
manage_net(){
while true;do
	clear
echo "======Manage Network======"
echo "0.back to Docker Menu"
echo "1.list networks"
echo "2.create network"
echo "3.connect a container to a network"
echo "4.disconnect a container to a network"
echo "5.inspect network"
echo "6.remove specific network"
echo "7.prune all networks"
read -p "choose: " choose
case $choose in
	0)
		Docker_Menu;;
	1)
		docker network ls;;
	2)
		read -p "Enter the network name: " name_net
	docker network create "$name_net";;
	3)
		read -p "Enter the network name: " net_name
		read -p "Enter the container name: "co_name
	docker connect "$net_name" "$co_name";;
	4)
		read -p "Enter the network name: " dis_net_name
       	        read -p "Enter the container name: "dis_co_name
       		docker disconnect "$dis_net_name" "$dis_co_name";;
	5)
		read -p "Enter the network name: "inspect
		docker network inspect "$inspect";;
	6)
		read -p "Enter the network name: "net_rm
		docker network rm "$net_rm";;
	7)
		docker networe prune;; 
	*)
		echo "Enter a vaild option";;
esac

done
}
volume_func(){
while true;do
       clear	
echo "======Manage Volumes======"
echo "0.back to Docker Menu"
echo "1.list volumes"
echo "2.create volume"
echo "3.inspect volume"
echo "4.remove specific volume"
echo "5.purne all volumes"
read -p "choose: " choose
case $choose in
	0)
		Docker_Menu;;
	1)
		watch docker volume ls;;
	2)
		read -p "Enter the name of volume to create: "vo
		docker volume create "$vo";;
	3)
		read -p "Enter the name of volume to inspect: "inspect
		watch docker inspect "$inspect";;
	4)
		read -p "Enter the name of volume to delete: "delete
		docker volume rm "$delete";;
	5)
		docker volume prune;;
esac
done

}
docker_compo(){
while true ;do
	clear
echo "=========docker compose========="
echo "Ready-to-use Docker Compose profiles"
echo "NOTE: the docker compose default path we well use is in /mnt/srv/docker/comp/docker-compose.yml"
echo "-----------------"
echo "0.back to main"
echo "11.make the default compose file"
echo "1.portainer and nginx profile"
echo "2.jellyfin profile"
echo "3.NextCloud profile"
echo "4.Nginx proxy manger"
echo "5.Pi hole profile"
echo "6.WireGuard profile"
echo "7.py profile"
echo "8.debian:13.3-slim profile"
echo "9.kali linux profile"
echo "10.apache2 (httpd) profile"
echo "11.pyload profile"
echo "Note: if you dont create any docker compose file so choose 11"
read -p "choose: " choose
case $choose in
	0)
		Docker_Menu;;
	11)
		cat <<EOF >> /mnt/srv/docker/comp/docker-compose.yml
version: "3.9"

networks:
  hs:
    driver: bridge
    ipam:
      config:
        - subnet: 172.20.0.0/24

services:
EOF
;;
	1)
		cat <<EOF >> /mnt/srv/docker/comp/docker-compose.yml
		 # =====================================
  portainer:
    image: portainer/portainer-ce
    container_name: portainer
    networks:
      hs:
    command: --no-analytics
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - /mnt/srv/docker/cont/portainer:/data
      - /etc/timezone:/etc/timezone:ro
      - /etc/localtime:/etc/localtime:ro
    ports:
      - 9000:9000
      - 8000:8000
      - 9443:9443
    restart: always
  # =====================================
  nginx:
    image: lscr.io/linuxserver/nginx
    container_name: nginx
    networks:
      hs:
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Africa/Cairo
    volumes:
      - /mnt/srv/docker/cont/nginx:/config
    ports:
      - 8082:80
      #- 443:443
    restart: unless-stopped
 # =====================================
EOF
;;
2)

	cat <<EOF >> /mnt/srv/docker/comp/docker-compose.yml

	  jellyfin:
    image: lscr.io/linuxserver/jellyfin
    container_name: jellyfin
    networks:
      - hs
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Africa/Cairo
      - JELLYFIN_PublishedServerUrl=http://jellyfin.vs-yt.mm #optional
    volumes:
      - /mnt/srv/docker/cont/jellyfin/config:/config
      - /mnt/srv/data/media:/data/media
    ports:
      - 8096:8096
      - 8920:8920 #optional
      - 7359:7359/udp #optional
      - 1900:1900/udp #optional
    restart: unless-stopped
EOF
;;
3)
	cat <<EOF >> /mnt/srv/docker/comp/docker-compose.yml
nextcloud:
    image: nextcloud:25
    container_name: nextcloud
    user: 1000:1000
    networks:
      - hs
    links:
      - nextcloud-db
    hostname: nc.vs-yt.mm
    environment:
      - TZ=Africa/Cairo
      - POSTGRES_DB=nextcloud
      - POSTGRES_USER=nextcloud
      - POSTGRES_PASSWORD=nextcloud
      - POSTGRES_HOST=nextcloud-db
      - NEXTCLOUD_TRUSTED_DOMAINS=localhost nextcloud 192.168.100.76:8080 nc.vs-yt.mm *.vs-yt.mm
      # - NEXTCLOUD_ADMIN_USER=mbesar
      # - NEXTCLOUD_ADMIN_PASSWORD=password
      # - NEXTCLOUD_DATA_DIR=/var/www/html/data # if you need to change data folder
    volumes:
      - /mnt/srv/docker/cont/nextcloud/html:/var/www/html
      - /mnt/srv/data/nc-data:/var/www/html/data
    ports:
      - 8080:80
    restart: unless-stopped
 #--------------------------------------
  nextcloud-db:
    image: postgres:15
    container_name: nextcloud-db
    user: 1000:1000
    networks:
      - hs
    environment:
      - POSTGRES_USER=nextcloud
      - POSTGRES_PASSWORD=nextcloud
      - POSTGRES_DB=nextcloud
    volumes:
      - /mnt/srv/docker/cont/nextcloud/db:/var/lib/postgresql/data
      - /mnt/srv/docker/cont/nextcloud/db-backup:/var/lib/postgresql/backup
      - /etc/timezone:/etc/timezone:ro
      - /etc/localtime:/etc/localtime:ro
    restart: unless-stopped

EOF
;;
4)
	cat <<EOF >> /mnt/srv/docker/comp/docker-compose.yml
# =====================================
  npm:
    image: jc21/nginx-proxy-manager:latest
    container_name: npm
    networks:
      - hs
    environment:
      - DISABLE_IPV6=true # Uncomment this if IPv6 is not enabled on your host
      - TZ=Africa/Cairo
    volumes:
      - /mnt/srv/docker/cont/npm/data:/data
      - /mnt/srv/docker/cont/npm/letsencrypt:/etc/letsencrypt
    ports:
      - 80:80
      - 443:443
      - 81:81
    restart: always

EOF
;;
5)
	cat <<EOF >> /mnt/srv/docker/comp/docker-compose.yml
# More info at https://github.com/pi-hole/docker-pi-hole/ and https://docs.pi-hole.net/
services:
  pihole:
    container_name: pihole
    image: pihole/pihole:latest
    ports:
      # DNS Ports
      - "53:53/tcp"
      - "53:53/udp"
      # Default HTTP Port
      - "80:80/tcp"
      # Default HTTPs Port. FTL will generate a self-signed certificate
      - "443:443/tcp"
      # Uncomment the below if using Pi-hole as your DHCP Server
      #- "67:67/udp"
    environment:
      # Set the appropriate timezone for your location (https://en.wikipedia.org/wiki/List_of_tz_database_time_zones), e.g:
      TZ: 'Europe/London'
      # Set a password to access the web interface. Not setting one will result in a random password being assigned
      FTLCONF_webserver_api_password: 'correct horse battery staple'
    # Volumes store your data between container upgrades
    volumes:
      # For persisting Pi-hole's databases and common configuration file
      - './etc-pihole:/etc/pihole'
      # Uncomment the below if you have custom dnsmasq config files that you want to persist. Not needed for most starting fresh with Pi-hole v6. If you're upgrading from v5 you and have used this directory before, you should keep it enabled for the first v6 container start to allow for a complete migration. It can be removed afterwards
      #- './etc-dnsmasq.d:/etc/dnsmasq.d'
    cap_add:
      # See https://github.com/pi-hole/docker-pi-hole#note-on-capabilities
      # Required if you are using Pi-hole as your DHCP server, else not needed
      - NET_ADMIN
    restart: unless-stopped
EOF
;;
6)
	cat <<EOF >> /mnt/srv/docker/comp/docker-compose.yml
volumes:
  etc_wireguard:

services:
  wg-easy:
    #environment:
    #  Optional:
    #  - PORT=51821
    #  - HOST=0.0.0.0
    #  - INSECURE=false

    image: ghcr.io/wg-easy/wg-easy:15
    container_name: wg-easy
    networks:
      wg:
        ipv4_address: 10.42.42.42
        ipv6_address: fdcc:ad94:bacf:61a3::2a
    volumes:
      - etc_wireguard:/etc/wireguard
      - /lib/modules:/lib/modules:ro
    ports:
      - "51820:51820/udp"
      - "51821:51821/tcp"
    restart: unless-stopped
    cap_add:
      - NET_ADMIN
      - SYS_MODULE
      # - NET_RAW # ⚠️ Uncomment if using Podman
    sysctls:
      - net.ipv4.ip_forward=1
      - net.ipv4.conf.all.src_valid_mark=1
      - net.ipv6.conf.all.disable_ipv6=0
      - net.ipv6.conf.all.forwarding=1
      - net.ipv6.conf.default.forwarding=1

networks:
  wg:
    driver: bridge
    enable_ipv6: true
    ipam:
      driver: default
      config:
        - subnet: 10.42.42.0/24
        - subnet: fdcc:ad94:bacf:61a3::/64
EOF
;;
7)
	cat <<EOF >> /mnt/srv/docker/comp/docker-compose.yml
py_container:
    image: python:3.12
    container_name: py
    tty: true
    command: bash
EOF
;;
8)
	cat <<EOF >> /mnt/srv/docker/comp/docker-compose.yml
debian:13.3-slim:
    image: debian:13.3-slim
    container_name: debian
    tty: true
    stdin_open: true
    command: bash
EOF
;;
9)
	cat <<EOF >> /mnt/srv/docker/comp/docker-compose.yml
  kali:
    image: kalilinux/kali-rolling:latest
    user: "0:root"
    tty: true
    stdin_open: true
    command: bash
    restart: always


EOF
;;
10)
	cat <<EOF >> /mnt/srv/docker/comp/docker-compose.yml
apache2:
    image: httpd:latest
    container_name: web
    ports:
      - "8080:80"
EOF
;;
11)
	cat <<EOF >> /mnt/srv/docker/comp/docker-compose.yml
	# =====================================
  pyload:
    image: lscr.io/linuxserver/pyload-ng:latest
    container_name: pyload
    networks:
      - hs
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Africa/Cairo
    volumes:
      - /mnt/srv/docker/cont/pyload:/config
      - /mnt/srv/downloads/pyload:/downloads
    ports:
      - 8001:8000
      - 9666:9666 #optional
    restart: unless-stopped

EOF
;;
*)
	echo "please enter a vaild option"
esac

done
}
main_menu
