from datetime import datetime
import os

from influxdb_client import InfluxDBClient, Point, WritePrecision
from influxdb_client.client.write_api import SYNCHRONOUS
import time
import certifi
import paho.mqtt.client as mqtt
from faker import Faker
import random
# connect to the MQTT broker

MQTT_BROKER_URL = "mqtt.eclipseprojects.io"
MQTT_PUBLISH_TOPIC = "temperature"

mqttc = mqtt.Client()
mqttc.connect(MQTT_BROKER_URL)

# Init Faker, our fake data provider
fake = Faker()


# You can generate an API token from the "API Tokens Tab" in the UI
token = "R9ZW4DS1bxxIsYTzs0eChj9neAQmbEE6Ij7Rg3x_sH6J-xC4Z3M1cq17Wk0U00dMiwoYpdMmF96U01cLYUP0vA=="
#org = "ginzazaid@hotmail.com"
#bucket = "SmartAq"
# You can generate an API token from the "API Tokens Tab" in the UI
#token = os.getenv("INFLUX_TOKEN")
org = "@hotmail.com"
bucket = "SmartAq"




# Infinite loop of fake data sent to the broker
while True:

        temperature = random.uniform(23.5,24)
        pH = random.uniform(7,7.5)
        waterlevel = fake.random_int(min=9,max=11)
        mqttc.publish(MQTT_PUBLISH_TOPIC, temperature)
        mqttc.publish(MQTT_PUBLISH_TOPIC, pH)
        mqttc.publish(MQTT_PUBLISH_TOPIC, waterlevel)
        print(f"Published new temperature measurement: {temperature}, and pH: {pH}, and Water level: {waterlevel}")
        time.sleep(1)
        
        with InfluxDBClient(url="https://europe-west1-1.gcp.cloud2.influxdata.com", token=token, org=org, ssl_ca_cert=certifi.where()) as client:
                write_api = client.write_api(write_options=SYNCHRONOUS)
                
                data = "mem,host=host1 temperature="+str(temperature)
                datapH = "mem,host=host1 pH="+str(pH)
                datawat = "mem,host=host1 waterlevel="+str(pH)
                write_api.write(bucket, org, data)
                write_api.write(bucket, org, datapH)
                write_api.write(bucket, org, datawat)
        

                query = """from(bucket: "SmartAq") |> range(start: -1h)"""
                tables = client.query_api().query(query, org=org)
                for table in tables:
                        for record in table.records:
                                #print(record)
                                pass
        time.sleep(120)
client.close()
