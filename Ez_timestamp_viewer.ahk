#Requires AutoHotkey v2.0
#SingleInstance force
Persistent


global appEnabled := true
global time_zone_GMT := 7

;---Hotkeys---
^F1::ExitApp()
^`::toggleApp()

OnClipboardChange(clipChanged)


;---Functions---
clipChanged(DataType) {
    global appEnabled

    if (!appEnabled)
        return

    ;ignore non-text data
    if (DataType != 1)
        return

    ;timestamp often has length 10 or 13
    rawData := A_Clipboard
    if (StrLen(rawData) != 13 && StrLen(rawData) != 10)
        return

    ;convert proccess
    try {
        rawData := SubStr(rawData, 1, 10)
        timestamp := Number(rawData)
        date := unixTimeToHumanReadable(timestamp)
   
        ToolTip(date)
        SetTimer(ToolTip, -5000)

    } catch Error as e {
    }
}

global daysOfMonth := [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ]
unixTimeToHumanReadable(seconds)
{
    global daysOfMonth, time_zone_GMT
    ; Number of days in month
    ; in normal year

    ;GMT +7
    seconds := seconds + (time_zone_GMT*60*60)
    ;Leap year flag
    flag := 0

    ; Calculate total days unix time T
    daysTillNow := seconds // (24 * 60 * 60)
    extraTime := Mod(seconds, 24 * 60 * 60)

    currYear := 1970
    ; Calculating current year
    while (true) {
        if (Mod(currYear, 400) = 0 || (Mod(currYear, 4) = 0 && Mod(currYear, 100) != 0)) {
            if (daysTillNow < 366) {
                break
            }
            daysTillNow -= 366
        }
        else {
            if (daysTillNow < 365) {
                break
            }
            daysTillNow -= 365
        }
        currYear += 1
    }

    if (Mod(currYear, 400) = 0 || (Mod(currYear, 4) == 0 && Mod(currYear, 100) != 0))
        flag := 1

    ; Updating extradays because it
    ; will give days till previous day
    ; and we have include current day
    extraDays := daysTillNow + 1

    ; Calculating MONTH and DATE
    month := 1
    index := 1
    if (flag = 1) {
        while (true) {
            if (index = 2) {
                if (extraDays - 29 < 0)
                    break
                extraDays -= 29
            }
            else {
                if (extraDays - daysOfMonth[index] <= 0) {
                    break
                }
                extraDays -= daysOfMonth[index]
            }
            month += 1
            index += 1
        }
    }
    else {
        while (true) {
            if (extraDays - daysOfMonth[index] <= 0) {
                break
            }
            month += 1
            extraDays -= daysOfMonth[index]
            index += 1
        }
    }

    ; Current Month
    if (extraDays > 0) {
        date := extraDays
    }
    else {
        if (month = 2 && flag = 1)
            date := 29
        else {
            date := daysOfMonth[month]
        }
    }

    ; Calculating hh:mm:ss
    hours := extraTime // 3600
    minutes := Mod(extraTime, 3600) // 60
    secondss := Mod(Mod(extraTime, 3600), 60)

    ; Return the time
    return date . "/" . month . "/" . currYear . " " . hours . ":" . minutes . ":" . secondss . "  GMT+" . time_zone_GMT
}

toggleApp(){
    global appEnabled
    appEnabled := !appEnabled

    ToolTip(appEnabled ? "ON" : "OFF")
    SetTimer(ToolTip, -2000)
}








