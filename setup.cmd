source ../nso-4.6.1/ncsrc
ncs-setup --dest ~/nso-projects/efx-ciena
cp ncs-4.4.5-ciena-acos-6.0.1.signed.bin ~/nso-4.6.1/packages/neds/
cd
cd nso-4.6.1/packages/neds/
chmod 755 ncs-4.4.5-ciena-acos-6.0.1.signed.bin 
./ncs-4.4.5-ciena-acos-6.0.1.signed.bin 
tar -xvf ncs-4.4.5-ciena-acos-6.0.1.tar.gz
cd ciena-acos/src/
make clean; make
cd ../..
rm ncs-4.4.5-ciena-acos-6.0.1.*
cd ~/nso-projects/efx-ciena
ln -s ~/nso-4.6.1/packages/neds/ciena-acos packages/ciena-acos
ncs --with-package-reload
ncs-netsim create-network ~/nso-4.6.1/packages/neds/ciena-acos 4 c
ncs-netsim start
ncs-netsim ncs-xml-init > devices.xml
ncs_load -l -m devices.xml
echo "request devices sync-from" > cmd
ncs_cli -u admin cmd
cd packages
ncs-make-package --service-skeleton template efx
cd efs/src/yang
