# nimtcc
# Copyright Kutimotitokura
# A new awesome nimble package
import strutils

type
  rgbColor* = object
    r* : range[0..255]
    g* : range[0..255]
    b* : range[0..255]

proc newRGB*(r , g , b : range[0..255]) : rgbColor =
    return rgbColor(r : r , g : g , b : b)

proc repr*(c : rgbColor) : string =
  return "#" & c.r.toHex(2) & c.g.toHex(2) & c.b.toHex(2)

proc foregroundTCSequence*(color : rgbColor) : string =
  return "\x1b[38;2;$1;$2;$3m" % [repr(color.r) , repr(color.g) , repr(color.b)]

proc backgroundTCSequence*(color : rgbColor) : string =
  return "\x1b[48;2;$1;$2;$3m" % [repr(color.r) , repr(color.g) , repr(color.b)]

proc TCString*(text : string , fore : rgbColor , back : rgbColor) : string =
  return fore.foregroundTCSequence & back.backgroundTCSequence & text & "\x1b[0m"
proc TCForeString*(text : string , fore : rgbColor) : string =
  return fore.foregroundTCSequence & text & "\x1b[0m"
proc TCBackString*(text : string , back : rgbColor) : string =
  return back.backgroundTCSequence & text & "\x1b[0m"
proc TCClear*() =
  echo "\x1b[2J\x1b[0;0H"