## firewall

### Switch behavior

* For tcp or udp packet sent from 10.0.0.1 to 10.0.0.2 with destination port ID >= 32768, the firewall will block(i.e. drop) them.

* Otherwise, the packet will be forwarded.

### Test Method

#### Go to h1 namespace and tcpping 10.0.0.2
```
ip netns exec h1 bash

tcpping -x 4 10.0.0.2 80

tcpping -x 4 10.0.0.2 40000

exit
```
