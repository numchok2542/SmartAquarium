#!/usr/bin/python3
import paho.mqtt.client as mqtt
import RPi.GPIO as GPIO
import time
from datetime import datetime
import datetime as dt

GPIO.setmode(GPIO.BCM)
GPIO.setup(15, GPIO.OUT)
p = GPIO.PWM(15, 60) # GPIO 15 for PWM with 
TRIG = 16
ECHO = 18
GPIO.setup(TRIG,GPIO.OUT)
GPIO.setup(ECHO,GPIO.IN)

last_switch = None
pump = None
hourd = None
def msg_handler(client, userdata, message):
    global last_switch, hours

    t = message.topic
    p = message.payload.decode("utf-8")
    if t == 'Dart/Feed':
        if p == 'True' or p == "False":
            last_switch = p
        else:
            last_switch = p
    if t == 'Dart/Feed3':
        if p == 'True' or p == 'False':
             hours = p
        else:
             hours = p

mclient = mqtt.Client("NumchokMQTTClient101")
mclient.on_message=msg_handler

mclient.connect('broker.emqx.io', port=1883)
mclient.loop_start()
mclient.subscribe([('Dart/Feed',0),('Dart/Feed3',0)])
#f = open("CheckTime.txt", "r")
#settime = f.read()
#settime = settime.strip("\n")
#print("Set Time: "+settime)
#time.sleep(5)
#mclient.publish('Dart/FeedTime', settime)

while True:
    f = open("CheckTime.txt", "r")
    settime = f.read()
    settime = settime.strip("\n")
   # print("Set Time: "+settime)
    time.sleep(60)
    mclient.publish('Dart/FeedTime', settime)
    if last_switch != None: # button code which can be replace with mqtt
        #print("PPPPP")
        print("New Time: "+last_switch)
        f = open("CheckTime.txt","w")
        f.write(last_switch)
        f.close()
        mclient.publish('Dart/FeedTime', settime)
    print("last switch", last_switch)
    now = datetime.now()
    tzplusseven = dt.timedelta(hours=6)
    now = now+tzplusseven
    current_time = now.strftime("%H:%M")
    #print("Time now", current_time)
    sethour = settime[0:2]
    #print("Hour set: "+sethour)
    #print("Period set: "+settime[6:])
    nexthour = str(int(settime[0:2]) + int(settime[6:]))
    if len(nexthour)<2:
        nexthour = "0"+nexthour
    #print("Next hour: "+str(nexthour))
    print("Next time", nexthour+":"+settime[3:5])   
    nexttime = nexthour+":"+settime[3:5]
    if current_time  == settime or nexttime == settime :
        print("It's time!")
        p.ChangeDutyCycle(5.0)
        time.sleep(1.0)
        p.ChangeDutyCycle(2.0)
        time.sleep(1.0)
        #if current_time == string(int(settime[0:1])+int(hour))+:+settime[3:4]
