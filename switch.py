#!/usr/bin/python3
import paho.mqtt.client as mqtt
import RPi.GPIO as GPIO
import time

GPIO.setmode(GPIO.BCM)
GPIO.setup(15, GPIO.OUT)
p = GPIO.PWM(15, 60) # GPIO 15 for PWM with 50Hz
p.start(0.5) # Initialization
lightonoff = 16
pumponoff =  20
GPIO.setup(lightonoff, GPIO.OUT)
GPIO.setup(pumponoff, GPIO.OUT)
GPIO.output(lightonoff, GPIO.LOW)
GPIO.output(pumponoff, GPIO.LOW)

TRIG = 16
ECHO = 18
GPIO.setup(TRIG,GPIO.OUT)
GPIO.setup(ECHO,GPIO.IN)

last_switch = None
light = None
pump = None
dis = 0
def msg_handler(client, userdata, message):
    global last_switch,light,pump

    t = message.topic
    p = message.payload.decode("utf-8")
    if t == 'Dart/Servo':
        if p == 'True' or p == "False":
            last_switch = p
            print(last_switch)
    elif t == 'Dart/Pumping':
          if p == 'True' or p == "False":
            pump = p
            print(pump)
    elif t == 'Dart/Bulb':
          if p == 'True' or p == 'False':
            light = p
            print(light)
def ultrasonic():
    GPIO.output(TRIG, True)
    time.sleep(0.00001)
    GPIO.output(TRIG, False)
    while GPIO.input(ECHO)== 0:
        pulse_start = time.time()

    while GPIO.input(ECHO)== 1:
        pulse_end = time.time()

    pulse_duration = pulse_end - pulse_start

    distance = pulse_duration * 17150

    distance = round(distance+1.15, 2)
    
    print("distance:",distance,"cm")
    
    return distance

mclient = mqtt.Client("NumchokMQTTClient101")
mclient.on_message=msg_handler

mclient.connect('broker.emqx.io', port=1883)
mclient.loop_start()
mclient.subscribe([('Dart/#',0)])

while True:
   # print("While True")
    dis = 20
    if last_switch == "True": # button code which can be replace with mqtt
        print('Button Pressed')
        p.ChangeDutyCycle(5.0)
        time.sleep(1.0)
        p.ChangeDutyCycle(2.0)
        time.sleep(1.0)
    else:
        pass
    if pump == "True":
        print('pump')
        if dis >= 30:
            GPIO.output(pumponoff,GPIO.LOW)
        else:
            GPIO.output(pumponoff, GPIO.HIGH)
            mclient.publish('Dart/PumpState', "True")
            time.sleep(2)
    else:
        GPIO.output(pumponoff, GPIO.LOW)
        mclient.publish('Dart/PumpState', "False")
        print('False')
    if light == "True":
        print('light')
        GPIO.output(lightonoff, GPIO.HIGH)
        mclient.publish('Dart/LightState', "True")
        time.sleep(2)
    else:
        GPIO.output(lightonoff, GPIO.LOW)
        mclient.publish('Dart/LightState', "False")

    time.sleep(2)
