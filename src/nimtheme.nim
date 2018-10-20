import nimtcc
import terminal
import strutils
import sequtils

proc test*() =
    echo "kutimoti".TCString(newRGB(255,0,0) , newRGB(0,255,0))
    echo (int)getch()

var text = newSeqWith(10 , "kutimoti")
var fore = newSeqWith(11 , newRGB(122,122,122))
var cur = 0

proc draw() =
    TCClear()
    var current = repr(cur)
    if cur == 10: current = "background"
    echo "now : " & current
    echo "\n\n\n\n"
    for i in 0..9:
        var isCur = " "
        if cur == i: isCur = "-"
        echo "$4$1: $2 [$3]" % [repr(i) , text[i].TCString(fore[i] , fore[10]) , repr(fore[i]) , isCur]
    echo "\n\n\npress h to show help"

proc main*() =
    while true:
        draw()
        var n = getch()
        if (int)(n) == 27: break
        if n.isDigit:
            cur = (int)(n) - (int)('0')
        case n:
            of 'a': fore[cur].r = max(fore[cur].r - 1 , 0)
            of 's': fore[cur].g = max(fore[cur].g - 1 , 0)
            of 'd': fore[cur].b = max(fore[cur].b - 1 , 0)
            of 'q': fore[cur].r = min(fore[cur].r + 1 , 255)
            of 'w': fore[cur].g = min(fore[cur].g + 1 , 255)
            of 'e': fore[cur].b = min(fore[cur].b + 1 , 255)
            of '-': cur = 10
            of 'i':
              echo "text: "
              text[cur] = stdin.readline
            of 'h':
              echo """
ECS ... exit
a ... R up
q ... R down
s ... G up
w ... G down
d ... B up
E ... B down
i ... change current text
press any key
"""
              discard getch()
            else: discard "none"
