### MineFactory Reloaded

#### harvester

  - use fir trees or another tree with no extra items
  - put on top of power, water block on top of that to ground level
  - needs chest to put in chopped down bits
  - needs sludge boiler to extract sludge from harvester
      - isolate sludge boiler as it will poison users in 3x3 block

<!-- end list -->

1.  harvester with gold chest next to it
2.  itemduct filtering logs in round robin mode to 3x redstone dynamos
    on left, which provide power to system
3.  itemduct filtering saplings on right back to planter
4.  branch itemduct off planter and set to 'dense mode' so any leftover
    saplings go this way. plug that into LP network.

<!-- end list -->

```
    X X X
    X P X 7 - I
    X X X I   I
      H   I   I
      C - I   I
- - -   T     I
F F F   r     I
- - - D D D - C -> ME

X - dirt
P - planter
H - harvester
F - furnace
D - dynamo
T,L,7,-, I - itemducts
r - redstone
C - chest
SB - sludge boiler
```

#### planter

  - needs power
  - sits next to tree farm, harvests 3x3 in front of machine
  - fertiliser works same as planter (needed?)