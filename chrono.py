#!/usr/bin/python
import time
import datetime
from Adafruit_LED_Backpack import SevenSegment
segment = SevenSegment.SevenSegment(address=0x70)
segment.begin()

seconds = 0
minutes = 0

while True:
    
    seconds+=1
    if seconds >= 60:
        minutes+=1
        seconds-=60
    
    segment.clear()
    # Affichage des minutes
    segment.set_digit(0, int(minutes / 10))
    segment.set_digit(1, minutes % 10)
    # Affichage des secondes
    segment.set_digit(2, int(seconds / 10))
    segment.set_digit(3, seconds % 10)
    
    # Indique les secondes
    segment.set_colon(seconds % 2)              
    # Mettre l'affichage à jour
    segment.write_display()
    time.sleep(1)
