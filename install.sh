#!/bin/bash

apt update -y

add-apt-repository -y ppa:ethereum/ethereum;apt-get update -y; apt-get install ethereum -y;

echo -n "Enter your chain storage directory:" 
read  nodeDir
if test -d $nodeDir ; then
	geth --datadir $nodeDir account new
	geth --datadir $nodeDir init static/genesis.json
	cp static/static-nodes.json $nodeDir/geth/
	echo "#!/bin/bash" >startNode.sh
	echo "nohup geth --datadir $nodeDir --networkid 8845 --port 30301 --http --http.addr 0.0.0.0 --http.port 8545 --http.api \"eth,net,web3,txpool\" --http.corsdomain \"*\" --ws --ws.addr 0.0.0.0 --ws.port 8546 --ws.origins \"*\" --rpc.allow-unprotected-txs>>$nodeDir/node.log &" >>startNode.sh
	chmod +x startNode.sh
	echo "install success!"
	echo "start node ==> ./startNode.sh"
else
	echo "$nodeDir not a directory!"
	exit
fi
