## l2_switch

### Test Method

#### Go to h1 namespace and ping 10.0.0.2
```
ip netns exec h1 bash

ping -c 4 10.0.0.2

exit
```

#### Go to h2 namespace and ping 10.0.0.1
```
ip netns exec h2 bash

ping -c 4 10.0.0.1

exit
```
