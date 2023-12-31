#!/bin/bash

terms=""" 
This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
THE SOFTWARE IS PROVIDED ''AS IS'', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
"""
dna_ascii=$(cat /usr/lib/floflis/layers/dna/dna_ascii)

termsagreement () {
   echo "${dna_ascii}"
   echo "Terms (applies to The Floflis Platform, The Floflis OS and its set of applications such as this script - ethgenerate.sh):"
   echo "${terms}"
   echo "Scroll up to read. PLEASE READ/WRITE CAREFULLY!"
   echo "Do you agree with the terms and the disclaimer? [Y/n]"
   read terms_input
   case $terms_input in
      [nN])
         exit ;;
      [yY])
         echo "Ok"
         echo "${dna_ascii}"
         echo "The safest way to store your ETH keys is by using a hardware wallet. USB keys (Trezor/Ledger/Keepkey/etc) are not supported yet, but we will cover them as soon as possible."
         echo "${dna_ascii}"
esac
}

ethaddresscreate () {
   echo "Creating your ETH/Polygon/XDai address..."
   echo "Create a password to protect your wallet; BUT DON'T FORGET IT! It won't be possible to reset your password. Choose a password you'll never forget."
   echo "${dna_ascii}"
   geth account new
   bothproceed
}

bothproceed () {
   flouser=$(jq -r '.name' /1/config/user.json)
   echo "Need root to fix permissions on /1/config/user.json" # have to fix it in the script that runs this script
   sudo chmod -R a+rwX /1/config/user.json && sudo chown $flouser:$flouser /1/config/user.json
   if [ "$(jq -r '.eth' /1/config/user.json)" = "null" ]; then
      cat /1/config/user.json | jq '. + {"eth": ""}' | tee /1/config/user.json
fi
   ethaddress=$(geth --verbosity "0" console --exec "eth.accounts[0]" | tr -d '"')
   contents="$(jq ".eth = \"$ethaddress\"" /1/config/user.json)" && \
   echo "${contents}" > /1/config/user.json
   echo "Done!"
   echo "Now you have your ETH address on Floflis!"
   echo "----"
   echo "Are you ready to farm FLOF and others tokens?"
   echo "Your journey begins today."
   echo "Your ETH address: $ethaddress"
   echo "----"
   echo "PS: we recommend that once you reach some $ values with your Floflis ETH address (be it generated for Floflis or imported from a private key), SAFELY MOVE YOUR ASSETS TO YOUR SAFE WALLET SUCH AS A HARDWARE WALLET(S)."
#read main address: geth --verbosity "0" console --exec "eth.accounts[0]" (should filter out the quotes) OR jq -r '.address' /home/daniell/.ethereum/keystore/UTC--*
   exit
}

function olduserproceed {
   echo "We are once again asking, for you to reconsider: don't trust any service with your privatekey, not even Floflis; your privatekeys may contain invaluable assets that you can't afford to lose; and this script nor the Floflis Platform are responsible for your personal choices."
#   PS3='Whats your choice? '
#   options=("Create exclusive ETH address" "Import from privatekey")
#   select opt in "${options[@]}"
#   do
#      case $opt in
#         "Create exclusive ETH address")
#            echo "The best choice! You are on the correct way."
            ethaddresscreate;;
#         "Import from privatekey")
#            echo -n "Type your privatekey if you are aware of the risks, and responsible for your own choices: "
#            read prvkey
#            geth account import <(echo $prvkey)
#            bothproceed
#            ;;
#         *) echo "invalid option $REPLY";;
#        esac
#done
#   echo "Are you sure to import privatekey?"
#}

echo "Button 'y' = Yes"
echo "Button 'n' = No"
echo "Type the choosen option (Y or n) and press Enter."
echo "----"
echo "Are you new to Ethereum? [Y/n]"
read newethereum
case $newethereum in
   [nN])
      termsagreement
      echo "For now, the best safety measure available is: to not import your privatekey; but create one for exclusive use on Floflis."
      echo "----"
      echo "Its recommendable to make an exclusive ETH address for Floflis instead of importing from your private key, even if you trust us a lot."
      echo "Also, we recommend that once you reach some $ values with your Floflis ETH address, SAFELY MOVE YOUR ASSETS TO YOUR SAFE WALLET SUCH AS A HARDWARE WALLET(S)."
      olduserproceed;;
   [yY])
      termsagreement
      ethaddresscreate
esac

#You can verify this script source here.
