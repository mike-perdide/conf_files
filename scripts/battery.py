#!/usr/bin/python
from datetime import datetime
from os.path import exists
import pickle
import sys

STATE_FILE = "/proc/acpi/battery/BAT0/state"
INFO_FILE = "/proc/acpi/battery/BAT0/info"
DUMP_FILE = "/home/mike/.battery_dump"

range = 20

def read_remaining():
    file = open(STATE_FILE)
    for line in file:
        if "remaining" in line:
            return int(line.split(" ")[-2])

def read_charging_state():
    file = open(STATE_FILE)
    for line in file:
        if "charging state" in line:
            return line.split(" ")[-1].rsplit()[0]

def read_last_full_cap():
    file = open("/proc/acpi/battery/BAT0/info")
    for line in file:
        if "last full capacity" in line:
            return float(line.split(" ")[-2])

def save_battery_state(remaining):
    file = open(DUMP_FILE, "w")
    pickle.dump((datetime.now(), remaining), file)
    file.close()

def load_battery_state():
    file = open(DUMP_FILE, "r")
    last = pickle.load(file)
    return last

def calc_remaining_time():
    current_cap = read_remaining()
    current_date = datetime.now()
    last_date, last_cap = load_battery_state()
    date_delta = current_date - last_date
    cap_delta = current_cap - last_cap

    print "Last capactity: %d mWh" % last_cap
    print "Current capaticty: %d mWh" % current_cap
    print date_delta.seconds/60, "minutes ", date_delta.seconds%60, "seconds"
    # mW per minute
    ratio = (cap_delta/(date_delta.seconds/60.))
    print "Rate: %d mWh per minute" % ratio

    if ratio == 0:
        return "too soon"

    # remaining minutes
    remaining_time = (abs(int(current_cap)/ratio))

    if remaining_time >= 60:
        displayed_time = "%d h %d min" % (remaining_time/60,
                                      remaining_time%60)
    else:
        displayed_time = "%d min" % remaining_time

    return displayed_time

if __name__ == "__main__":
    if len(sys.argv) > 1:
        command = sys.argv[1]
    else:
        command = ""

    remaining = read_remaining()

    if command == "dump":
        save_battery_state(remaining)
    else:
        last_full = read_last_full_cap()
        charging_state = read_charging_state()
        if charging_state == "discharging":
            charging = '<'
        elif charging_state == "charging":
            charging = '>'
        elif charging_state == "charged":
            charging = '='
        else:
            raise Exception("Oops, the charging state is of unknow type:" + charging_state)

        remaining_time = calc_remaining_time()

        ratio = remaining/last_full
        datetime = ""
        print "[%s%s%s] %d%%, remaining: %s" % ((int(range*ratio)-1)*'=',
                                                charging,
                                                int(range*(1-ratio))*' ',
                                                ratio*100,
                                                remaining_time)

