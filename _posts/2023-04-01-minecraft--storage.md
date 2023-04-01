---
title: minecraft--storage
date: '2023-04-01 19:37:57 +0000'
categories:
- minecraft--storage
tags:
- minecraft--storage
---


### logical pipes

<http://technicpack.wikia.com/wiki/Logistics_Pipes_Tutorial>

```

                                power
                                  V
chest -> provider -> basic   -> basic -> basic <- provider <- [
                                         basic -> supplier -> [ storage
                                            V
                                         request

meybe

                                power
                                  V
chest -> provider -> basic   -> basic -> basic <- chassis mk2 chestitemsink or itemsink and <- [ storage
                                            V
                                         request
```

  - providers - default
  - supplier - set to inventory contents, single for barrel multiple for
    chests.
  - use supply pipe with charcoal set for input (infinite) on to solid
    fuel boiler box
  - chestitemsink module accepts any item that is already in the
    connected chest.

### boiler (for power)

  - make steel plates by rolling 4 refined iron (iron ingot cooked
    again) in a rolling machine

one boiler is enough. arrange with steam engine next to logistics power
and boiler to get steam and supply power. prime steam engine with
charcoal until boiler takes off. supply boiler with charcoal using
supply pipe. feed charcoal in from furnace / tree farm.

  - 3 x 3 solid fuel boiler box (can be 1 x 1 x 1)
  - 3 x 3 x 3 high pressure steam tank
  - hobbyist steam engine on top with lever
  - wooden kinesis pipe out of steam engine into cobblestone / gold
    kinesis pipe then into logistic power junction