
# Skripta napisana s ciljem da rijesi problem pokretanja ipseca na
# cvorovima sustava IMUNES.
# Promjenom konfiguracijskih datoteka strongswan.conf ipsec se ne zeli 
# pokrenuti jer ima problema s ucitavanjem plugina za charon.
# Rjesenje je jednostavno preimenovanje charon.load u charon.load_modular

TESTDIR=./temp/demos/tests/

for test in `ls $TESTDIR`
do
	HOSTDIR=$TESTDIR/${test}/hosts/
	for conf in `ls $HOSTDIR`
	do
		target=$HOSTDIR${conf}/etc/strongswan.conf
		if [ -e $target ]
		then
			#  load -> load_modluar
			grep -E "\bload\b" $target > /dev/null 2>&1
			if [ $? -eq 0 ]
			then
				sed -i bak -e 's/load/load_modular/g' $target
			fi
			
		fi
		
		target=$TESTDIR/${test}/evaltest.dat
		if [ -e $target ]
		then
			# icmp_seq=1 -> icmp_seq=
			grep -E "\bicmp_.eq=1" $target > /dev/null 2>&1
			if [ $? -eq 0 ]
			then
				sed -i bak -e 's/icmp_.eq=1/icmp_.eq=/g' $target
			fi
			
			# symbolic -> IP
			grep -E "tcpdump" $target > /dev/null 2>&1
			if [ $? -eq 0 ]
			then
				sed -i bak -e 's/ moon.strongswan.org / 192.168.0.1 /g' $target
				sed -i bak -e 's/ moon.strongswan.org:/ 192.168.0.1:/g' $target
				sed -i bak -e 's/ sun.strongswan.org / 192.168.0.2 /g' $target
				sed -i bak -e 's/ sun.strongswan.org:/ 192.168.0.2:/g' $target				
			fi
		fi
		
	done
done
