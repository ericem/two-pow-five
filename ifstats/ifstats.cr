# cerner_2^5_2019
iface =  ENV.fetch("IFACE", `netstat -rn -f inet | grep default | awk '{print $6}'`.chomp)
def rxbytes(iface : String) : Int64
  `netstat -I '#{iface}' -f inet -b | grep Link | awk '{print $7}'`.chomp.to_i64.as(Int64)
end
def rxpkts(iface : String) : Int64
  `netstat -I #{iface} -f inet -b | grep Link | awk '{print $5}'`.chomp.to_i64.as(Int64)
end
def txbytes(iface : String) : Int64
  `netstat -I #{iface} -f inet -b | grep Link | awk '{print $10}'`.chomp.to_i64.as(Int64)
end
def txpkts(iface : String) : Int64
  `netstat -I #{iface} -f inet -b | grep Link | awk '{print $8}'`.chomp.to_i64.as(Int64)
end
last = {rxbytes(iface), rxpkts(iface), txbytes(iface), txpkts(iface)}
sleep 1
spawn do
  while true
    now = {rxbytes(iface), rxpkts(iface), txbytes(iface), txpkts(iface)}
    rxmbps, txmbps = (now[0]-last[0])*8/1e6, (now[2]-last[2])*8/1e6
    rxpps, txpps = (now[1]-last[1]), (now[3]-last[3])
    last = now
    field1 = sprintf("mbps TX: %7.2f RX: %7.2f", txmbps.round(2), rxmbps.round(2))
    field2 = sprintf(" pps TX: %7d RX: %7d", txpps, rxpps)
    x1=`tput cols`.chomp.to_i.as(Int) - field1.size
    x2=`tput cols`.chomp.to_i.as(Int) - field2.size
    print `tput sc; tput cup 0 #{x1}; tput setaf 2; tput smso; echo '#{field1}'; tput rc; tput sgr0`
    print `tput sc; tput cup 1 #{x2}; tput setaf 2; tput smso; echo '#{field2}'; tput rc; tput sgr0`
    sleep 1
  end
end
sleep
