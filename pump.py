#!/usr/bin/python3
import paho.mqtt.client as mqtt
import RPi.GPIO as GPIO
import time


last_switch = None

def msg_handler(client, userdata, message):
    global last_switch

    t = message.topic
    p = message.payload.decode("utf-8")
        
    if p == 'True' or p == "False":
        last_switch = p
        print(last_switch)
    else:
        pass


    if last_switch=="True":
        #print(last_switch)
        print()
        #last_sen = last_slider1 + last_slider2
        #mclient.publish("graph",last_sen,retain=True)
        #mclient.publish( "sensor_sum", last_sen, retain=True) #Return value to the phone.
        #print("topic:{} payload:{} retain flag:{} ". format(t,p,message.retain))
    else:
        #mclient.publish( "sensor_sum",0, retain=True)
        pass

mclient = mqtt.Client("NumchokMQTTClient101")
mclient.on_message=msg_handler

mclient.connect('broker.emqx.io', port=1883)
mclient.loop_start()
mclient.subscribe([('Dart/Pumping2',0)])

while True:
    #print("While True")
    #if last_switch == "True": # button code which can be replace with mqtt
        #print('Button Pressed')
        #p.ChangeDutyCycle(5.0)
        #time.sleep(1.0)
        #p.ChangeDutyCycle(2.5)
        #time.sleep(1.0)
        #p.stop()

    time.sleep(1)
