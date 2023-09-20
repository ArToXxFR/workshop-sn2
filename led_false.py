import re
import time
from luma.led_matrix.device import max7219
from luma.core.interface.serial import spi, noop
from luma.core.render import canvas
from luma.core.virtual import viewport
from luma.core.legacy import text, show_message
from luma.core.legacy.font import proportional, CP437_FONT, TINY_FONT, SINCLAIR_FONT, LCD_FONT  
# Matrix Gerät festlegen und erstellen.
serial = spi(port=0, device=1, gpio=noop())
device = max7219(serial, cascaded=1, block_orientation=0,
rotate=0)

def display_cross():
    with canvas(device) as draw:
        for x in range (8):
            draw.point((x,x), fill="red")
        draw.point((0,7), fill="red")
        draw.point((1,6), fill="red")
        draw.point((2,5), fill="red")
        draw.point((3,4), fill="red")
        draw.point((4,3), fill="red")
        draw.point((5,2), fill="red")
        draw.point((6,1), fill="red")
        draw.point((7,0), fill="red")
                
            
    
if __name__ == "__main__":   
    try:
        display_cross()
        time.sleep(3)
        device.clear()
    except KeyboardInterrupt:
        pass
