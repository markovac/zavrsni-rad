
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
		target=$HOSTDIR/${conf}/etc/strongswan.conf
		if [ -e $target ]
		then
			cat $target | sed 's/load/load_modular/g' | cat > $target
		fi
	done
done
