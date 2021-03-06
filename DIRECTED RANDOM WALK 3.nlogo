turtles-own [someone AT AT-init]

to setup
  clear-all
  setup-patches
  setup-turtles
  reset-ticks
end

to go
  ask turtles [
  search
  perform
  repeat 500 [display]
  ]
  if(background?)[
    ask patches[ if (count turtles-here = 0) [set pcolor white]]]
  tick
  if (ticks = stop-time)
  [ask turtles[ output-show AT-init output-show AT]]
end


to setup-patches
  ask patches [ set pcolor white]
end

to setup-turtles
  create-turtles number [setxy random-xcor random-ycor set AT random max-AT set AT-init AT set someone no-turtles set color At ]
end

;;NOTA:
;; COMPARAR ESTE MODELO CON EL V.2 PARA VER SI ES QUE REALMENTE SE SEPARAN Y ESO AFECTA EL AGRUPAMIENTO


to search
set someone one-of other turtles in-radius vision
end

to perform
  if (someone != nobody)[
  if ([AT] of someone = AT) [face someone fd 1]
  if ([AT] of someone > AT) [face someone fd 1 set AT AT + 1]
  if ([AT] of someone < AT) [face someone fd -1 set AT AT - 1]
    refresh-color
    set someone no-turtles]
end

to refresh-color
  set color At
  if (ticks > 35 and background? )
  [set pcolor 139 - At]
end
@#$#@#$#@
GRAPHICS-WINDOW
210
10
647
448
-1
-1
13.0
1
10
1
1
1
0
1
1
1
-16
16
-16
16
0
0
1
ticks
30.0

BUTTON
15
10
78
43
NIL
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
16
62
79
95
NIL
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
12
190
184
223
number
number
0
100
100.0
1
1
NIL
HORIZONTAL

SLIDER
11
237
183
270
vision
vision
1
30
15.0
1
1
NIL
HORIZONTAL

MONITOR
5
453
62
498
Mean AT
mean [AT] of turtles
17
1
11

MONITOR
64
452
121
497
Max AT
MAX [AT] of turtles
17
1
11

MONITOR
123
452
180
497
Min AT
min [AT] of turtles
17
1
11

PLOT
4
290
204
440
AT PLOT
TIME
AT
0.0
10.0
0.0
10.0
true
true
"" ""
PENS
"Mean" 1.0 0 -955883 true "" "plot mean [AT] of turtles"
"Max" 1.0 0 -2674135 true "" "plot max [AT] of turtles"
"Min" 1.0 0 -13345367 true "" "plot min [AT] of turtles"

TEXTBOX
235
471
385
499
Punto de quiebre: vision=6 para grid 16x16
11
0.0
0

SWITCH
401
473
527
506
background?
background?
0
1
-1000

OUTPUT
692
37
1047
345
11

SLIDER
682
360
854
393
stop-time
stop-time
0
2000
50.0
25
1
NIL
HORIZONTAL

TEXTBOX
687
401
837
443
Tiempo para imprimir la variacion de AT de cada tortuga
11
0.0
1

TEXTBOX
536
476
720
518
Visualizar las parcelas ocupadas por cada grupo (desde el tick 35)
11
0.0
1

SLIDER
7
139
184
172
max-AT
max-AT
1
100
49.0
1
1
NIL
HORIZONTAL

@#$#@#$#@
## WHAT IS IT?

This is the third version of DIRECTED RANDOM WALK 1:

As the first version, the phenomenon modelled is the emergence behaviour from a group of turtles/people/particles when randomly approaching into each other. It could be explained as a simple room game in which everyone in the room decides to choose randomly someone in their arounds and take 1 step forward, repeating the same process multiple times, everyone at the same time, tick by tick.

_ADDED IN 2ND VERSION_:

Turtles now possess a value called **AT** which could be understood as any value in a 1D space which the turtle might change during time when they interact with each other. Following the last example, we could say **AT** is the turtle's "Aligment" (opinion/position on something) and they are comparing it to other turtles **AT**.

In this case **AT** whill change in a rate of +1 or -1, depending on the interaction (explained in HOW IT WORKS:GO section)

_ADDED IN 3RD VERSION_:

In this case the direction in which turtles takes a step depends on how the **AT** changes, if the turtle **AT** goes -1, the step will be in the opposite direction of the other turtle.

►Agents:

Turtles : 
They would act like the particles/people. Their color depends of their AT (refresh every tick).

_ADDED IN 2ND VERSION_:
Once turtle takes a step, that turtle will compare their **AT** and modify it depending on the other turtle **AT**.

_ADDED IN 3RD VERSION_:
The turtle's step direction depends if their **AT** is lower or higher than other turtle **AT**

Observer:
It would set values for the setup

►Properties:

Turtles:
A agenset called **SOMEONE** which refers to the turtle they chose randomly and will approach to. 

_ADDED IN 2ND VERSION_:
A value called **AT** (0:max-AT) which represents the turtle position in a 1D space or a numerical representation of their "opinion". 


Global :
Vision range value called **VISION**(0:30), every turtle will have the same range of vision.
Number of turtles created called **NUMBER**(0:100).

_ADDED IN 2ND VERSION_:
Background?: This option when turned on will let you see (from tick number 35) the space the different groups of turtles use turning patches into different colors for each group, also it show us visually how they expand while the group stands still

_ADDED IN 3RD VERSION_:
Stop-time: Time to register initial and final **AT** of turtles.
max-AT: Maximum AT possible

## HOW IT WORKS

**SETUP** (Initialize):

First you need to set **NUMBER** and then **VISION** (this one can be changed during the process). Once it is decided, clicking SETUP will create turtles with initial random position.


**GO** (Iterative / Tick):

The turtles first select randomly a turtle in their range of vision and set them as **SOMEONE**, then face them and take 1 step forward in direction to them. 

_ADDED IN 2ND VERSION_:
Finally the turtle will compare their **AT**, if turtle-1 **AT** is higher than turtle-2 **AT**, turtle-1 will increase their AT +1, and if   turtle-1 **AT** is lower than turtle-2 **AT**, turtle-1 will decrease their AT -1.
(NOTE: It is not necessary for them to be in the same patch or position, is just turtle-1 moving in direction to turtle-2 and comparing their **AT**, turtle-2 is not necessary interacting with turtle-1).

_ADDED IN 3RD VERSION_:
At the same time,  if turtle-1 **AT** is higher than turtle-2 **AT**, turtle-1 will move fordward 1 step in the direction of turtle 2, and if turtle-1 **AT** is lower than turtle-2 **AT**, turtle-1 will move fordward 1 step in the opposite direction of turtle 2

If there is no one in their range of vision, they wont move until next tick.

## HOW TO USE IT

►The **SETUP** and **GO** button were explained in order above.

►The inputs:

**NUMBER**: The number of turtles that would be created.

**VISION**: Choose the range vision of the individuals.


_ADDED IN 3RD VERSION_:

**STOP-TIME**: Choose the time in which you would register the initial and final **AT** of turtles.

►The outputs:

_**MONITOR:**_ Positioning of turtles.


_ADDED IN 2ND VERSION_:

_**Values monitor**_: 3 monitos for mean, maximum and minimum **AT** values of all the turtles.

_**AT PLOT**_: Plot which displays the how the mean, max and mimimum **AT** value of all turtles changes over time/ticks.


_ADDED IN 3RD VERSION_:
_**AT REGISTER**_: When ticks == stop-time: It will show the initial and current **AT** of every turtle.

## THINGS TO NOTICE

Once the model is running, you will notice how the turtles will start to create groups and start to move together as a whole (similarly to "orbitation" around the center of mass).

When different groups meet each other, they will start a "turtle exchange" that most of the time will end up with both groups converging.



_ADDED IN 2ND VERSION_:

If **VISION** is high enough, the turtles will create just one big group and AT value will converge around one point.


Low **VISION** values as 1 or 2 will show totally different behaviour in the _**AT PLOT**_.



_ADDED IN 3RD VERSION_:

Since AT changes in steps by +1 or -1, reducing max-AT would let us have a discrete case of AT, and if the max-AT is high, we would have a continous version of the model.

Turtles take longer to converge in groups, they will change of color first and then will reunite in position.



## THINGS TO TRY

Low **VISION** value (0-10) will create different groups, and once they connect each ither by trading one turtles, they will converge into one big group.

High **VISION** value (11+) will create one big group automatically.

@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.1.1
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
