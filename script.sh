source colors

for i in  ------------------# Jocker------------# Jocker-Termux-----# Jocker-Termux-Script;do
    printf "$(clear) $C Iniciando script. . . .$i"
        printf "\n\n"
        sleep 0.2
done

command -v python > /dev/null 2>&1 || { echo >&2 -e "$R [$G *$R ]$Y Instalando Grep..."; pkg install grep -y;}
command -v curl > /dev/null 2>&1 || { echo >&2 -e "$R [$G *$R ]$Y Instalando Curl..."; pkg install curl -y;}
command -v figlet > /dev/null 2>&1 || { echo >&2 -e "$R [$G *$R ]$Y Instalando Figlet..."; pkg install figlet -y;}
command -v lolcat > /dev/null 2>&1 || { echo >&2 -e "$R [$G *$R ]$Y Instalando Lolcat..."; pkg install gem -y && gem install lolcat;}

banner() {
  printf "
        $Y .$G  ___         _      _$Y    .
         .$G / __| __ _ _(_)_ __| |_ $Y .
         .$G \__ \/ _| '_| | '_ \  _|$Y .
         .$G |___/\__|_| |_| .__/\__|$Y .
         .$G               |_|$Y    . . .
          .  .     ..  ...    .   ..
            .. .   .  ..   .  .
               ... 	 ..$W
               
            \e[101m.:By: Jocker Termux:.$W

   $R >$G Datetime:$W ";date;
printf "\n\n"
  
}

phone() {
  figlet -c -f small Info. Del Numero|lolcat
if [[ -e phoneinfo.txt ]]; then
rm -rf phoneinfo.txt
fi

while read -p ' Telefono (Ejem.: +525101883010)>>> ' phone && [ -z $phone ];do
printf "\n\n$R [$Y !$R ]:->$G Error Introdusca un Numero Telefonico$R <-:[$Y !$R ]\n\n$B"
  sleep 1
  echo $(clear)
  phone
done

getphone=$(curl -s "apilayer.net/api/validate?access_key=43fc2577cf1cdb2eb522583eaee6ae8f&number='$phone'&country_code=&format=1" -L > phoneinfo.txt)

valid=$(grep -o 'valid\":true' phoneinfo.txt )
if [[ $valid == *'valid":true'* ]]; then


country=$(grep 'country_name\":\"' phoneinfo.txt | cut -d ":" -f2 | tr -d ',' | tr -d '\"')
location=$(grep 'location\":\"' phoneinfo.txt | cut -d ":" -f2 | tr -d ',' | tr -d '\"')
carrier=$(grep 'carrier\":\"' phoneinfo.txt | cut -d ":" -f2 | tr -d ',' | tr -d '\"')
line_type=$(grep 'line_type\":\"' phoneinfo.txt | cut -d ":" -f2 | tr -d ',' | tr -d '\"')
IFS=$'\n'
printf "$R [$G *$R ]$Y Ciudad: %s$W\n" $country
printf "$R [$G *$R ]$Y Localizacion: %s$W\n" $location
printf "$R [$G *$R ]$Y Transportador: %s$W\n" $carrier
printf "$R [$G *$R ]$Y Tipo de linea: %s$W\n" $line_type

else
printf "$R [$G !$R ]$W Solicitud Invalida!\n"
fi

}

myinfo() {
  figlet -c -f small Tu Info.|lolcat
touch myinfo && echo "" > myinfo
curl "ifconfig.me/all" -s  > myinfo

my_ip=$(grep -o 'ip_addr:.*' myinfo | cut -d " " -f2)
remote_ip=$(grep -o 'remote_host:.*' myinfo | cut -d " " -f2)
printf "$R [$G *$R ]$Y Tu IP: %s$W\n" $my_ip
printf "$R [$G *$R ]$Y Host Remoto: %s$W\n" $remote_ip
rm -rf myinfo
}

iptracker() {
  echo $(clear)
  figlet -c -f small IP-Tracker|lolcat
if [[ -e iptracker.log ]]; then
rm -rf iptracker.log
fi
while read -p 'IP Para Rastrear>>> ' ip_tracker && [ -z $ip_tracker ];do
printf "\n\n$R [$Y !$R ]:->$G Error Introdusca una IP$R <-:[$Y !$R ]\n\n$B"
  sleep 1
  echo $(clear)
  iptracker
done
IFS=$'\n'
iptracker=$(curl -s -L "www.ip-tracker.org/locator/ip-lookup.php?ip=$ip_tracker" --user-agent "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.63 Safari/537.31" > iptracker.log)
continent=$(grep -o 'Continent.*' iptracker.log | head -n1 | cut -d ">" -f3 | cut -d "<" -f1)

printf "\n"
hostnameip=$(grep  -o "</td></tr><tr><th>Hostname:.*" iptracker.log | cut -d "<" -f7 | cut -d ">" -f2)
if [[ $hostnameip != "" ]]; then
printf "$R [$G *$R ]$Y Nombre del host: %s$W\n" $hostnameip
fi
##


reverse_dns=$(grep -a "</td></tr><tr><th>Hostname:.*" iptracker.log | cut -d "<" -f1)
if [[ $reverse_dns != "" ]]; then
printf "$R [$G *$R ]$Y DNS Inverso: %s$W\n" $reverse_dns
fi
##


if [[ $continent != "" ]]; then
printf "$R [$G *$R ]$Y IP Continente: %s$W\n" $continent
fi
##

country=$(grep -o 'Country:.*' iptracker.log | cut -d ">" -f3 | cut -d "&" -f1)
if [[ $country != "" ]]; then
printf "$R [$G *$R ]$Y IP Ciudad: %s\n" $country
fi
##

state=$(grep -o "tracking lessimpt.*" iptracker.log | cut -d "<" -f1 | cut -d ">" -f2)
if [[ $state != "" ]]; then
printf "$R [$G *$R ]$Y Estado: %s$W\n" $state
fi
##
city=$(grep -o "City Location:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)

if [[ $city != "" ]]; then
printf "$R [$G *$R ]$Y Ciudad de locasion: %s$W\n" $city
fi
##

isp=$(grep -o "ISP:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)
if [[ $isp != "" ]]; then
printf "$R [$G *$R ]$Y ISP: %s$W\n" $isp
fi
##

as_number=$(grep -o "AS Number:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)
if [[ $as_number != "" ]]; then
printf "$R [$G *$R ]$Y Como Numero: %s$W\n" $as_number
fi
##

ip_speed=$(grep -o "IP Address Speed:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)
if [[ $ip_speed != "" ]]; then
printf "$R [$G *$R ]$Y IP Velocidad de la Direccion: %s$W\n" $ip_speed
fi
##
ip_currency=$(grep -o "IP Currency:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)

if [[ $ip_currency != "" ]]; then
printf "$R [$G *$R ]$Y IP Moneda %s$W\n" $ip_currency
fi
##
printf "\n"
rm -rf iptracker.log
}

mailchecker() {
  echo $(clear)
  figlet -c -f small E-mail checker|lolcat
while read -p 'E-mail a Checkar>>> ' email && [ -z $email ];do
printf "\n\n$R [$Y !$R ]:->$G Error Introdusca un E-mail$R <-:[$Y !$R ]\n\n$B"
  sleep 1
  echo $(clear)
  mailchecker
done

checkmail=$(curl -s https://api.2ip.me/email.txt?email=$email | grep -o 'true\|false')

if [[ $checkmail == 'true' ]]; then
printf "$R [$G *$R ]$G E-mail Valido!$W\n"
elif [[ $checkmail == 'false' ]]; then
printf "$R [$G !$R ] E-mail No Valido!\n"
fi

}

function menu {
  echo $(clear)
  banner
  printf "
$R [$W 1$R ]$Y Info. Numero de Telefono.     $R [$W 3$R ]$Y Localizar IP.
$R [$W 2$R ]$Y Tu Informacion.               $R [$W 4$R ]$Y Chekar E-mail.

                      $R [$W 99$R ]$Y Exit$B

"
  while read -p ">>> " opc && [ -z $opc ];do
  printf "\n\n$R [$Y !$R ]:->$G Error seleccione una opcion$R <-:[$Y !$R ]\n\n$B"
  sleep 1
  echo $(clear)
  menu
  done
  if [ $opc == '1' ];then
    printf "$W"
    phone
  elif [ $opc == '2' ];then
    printf "$W"
    myinfo
  elif [ $opc == '3' ];then
    printf "$W"
    iptracker
  elif [ $opc == '4' ];then
   printf "$W"
   mailchecker
  elif [ $opc == '99' ];then
    echo $(clear)
    exit
  else
    printf "\n\n$R [$Y !$R ]:->$G Error seleccione una opcion$R <-:[$Y !$R ]\n\n$B"
    sleep 1
    echo $(clear)
    menu
  fi
}

menu
