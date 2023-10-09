#!/bin/sh
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
GRAY='\033[0;37m'
NC='\033[0m' # No Color


clear

echo -e "${YELLOW}    ___    __  ___________  __  ______  __________ ___________   __
   /   |  /  |/  /  _/ __ \/ / / / __ \/ ___/ ___// ____/  _/ | / /
  / /| | / /|_/ // // /_/ / /_/ / / / /\__ \\__ \ / __/  / //  |/ /
 / ___ |/ /  / // // _  _/ __  / /_/ /___/ /__/ / /____/ // /|  /
/_/  |_/_/  /_/___/_/ |_/_/ /_/\____//____/____/_____/___/_/ |_/

  SIP Server Manager"
echo " "
echo -e "${YELLOW} 1.${NC} ${CYAN} New SIP User ${NC}"
echo -e "${YELLOW} 2.${NC} ${CYAN} Delete SIP User ${NC}"
echo -e "${YELLOW} 3.${NC} ${CYAN} Show Users ${NC}"
echo -e "${YELLOW} 4.${NC} ${RED} EXIT ${NC}"
echo ""
echo -e "${YELLOW} >${NC} ${MAGENTA} Telegrma : @AmirHosseinTSL ${NC}"

echo " "
 read -p " -Enter option number: " choice

    case $choice in

1)

            read -p " -Enter SIP User: (* 4 digits numbers XXXX *) : " user
			
			read -p " -Enter SIP Password: " pass
			
			if [[ $user =~ ^[0-9]+$ ]]; then
			
			sleep 1
			
			else
			
			echo -e "${RED}  ERROR : ${user} is not a number ! ${NC}"
			
			sleep 3
			gip
			
			fi
			
			
			USR=`grep -o "aors = ${user}" /etc/asterisk/pjsip.conf | grep -o '[[:digit:]]*' | sed -n '1p'`
			
			sleep 1
 
           if [ "$USR" == "${user}" ]; then
		   
		   echo -e "${RED}  ERROR : User ${user} already exists ${NC}" 

           sleep 3
		   gip		   

else

echo "			
[${user}] ;${user}
type = endpoint ;${user}
context = internal ;${user}
disallow = all ;${user}
allow = alaw ;${user}
aors = ${user} ;${user}
auth = auth${user} ;${user}
direct_media = no ;${user}

[${user}] ;${user}
type = aor ;${user}
max_contacts = 1 ;${user}
support_path = yes ;${user}

[auth${user}] ;${user}
type=auth ;${user}
auth_type=userpass ;${user}
password=${pass} ;${user}
username=${user} ;${user}
">> /etc/asterisk/pjsip.conf
            
echo -e "${GREEN}  User ${user} Created Successfully ${NC}"       


fi

service asterisk restart
sleep 3
gip

read -s -n 1
;;

2)
        
            read -p " -Enter SIP User: " dele
						
			if [[ $dele =~ ^[0-9]+$ ]]; then
			
			sleep 1
			
			else
			
			echo -e "${RED}  ERROR : ${dele} is not a number ! ${NC}"
			
			sleep 3
			
			gip
			
			fi
			
			
			PUSR=`grep -o "aors = ${dele}" /etc/asterisk/pjsip.conf | grep -o '[[:digit:]]*' | sed -n '1p'`
			
			sleep 1
 
           if [ "$PUSR" == "${dele}" ]; then
		   
		    sed -i "/\;$dele\>/d" /etc/asterisk/pjsip.conf
		
		
			echo -e "${GREEN}  User Deleted Successfully ${NC}"

     
		   service asterisk restart
		   
		   sleep 3
           
		   gip
else


echo -e "${RED}  ERROR : User ${user} is not exists ${NC}"              

sleep 3
gip

fi

   sleep 3
   gip
   
   read -s -n 1
   ;;

		
		





3)
        
		
		asterisk -rx "pjsip list endpoints"

        read -s -n 1
        ;;

4)
            echo ""
            echo -e "${GREEN}Exiting...${NC}"
            exit 0

           read -s -n 1
           ;;



 *)
           echo "  Invalid option !"
           echo ""
           echo -e "  Press ${RED}ENTER${NC} to continue"
           read -s -n 1
           ;;
      esac

gip
