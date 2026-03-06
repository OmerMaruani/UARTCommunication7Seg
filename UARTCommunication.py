#-------------------------------------------------------------------------------
# Name:        module1
# Purpose:
#
# Author:      עומר מרואני
#
# Created:     15/08/2025
# Copyright:   (c) עומר מרואני 2025
# Licence:     <your licence>
#-------------------------------------------------------------------------------


import serial
import time

# Replace with your actual serial device (often /dev/ttyS0 or /dev/serial0)

SERIAL_PORT = "/dev/serial0"
BAUD_RATE = 9600    # Match the FPGA's UART baud rate
BAUD_RATE = 115200

#GPIO14 TX, pin 8
#GPIO15 RX, pin 10

def UARTSetup():
    try:
        ser = serial.Serial(SERIAL_PORT, BAUD_RATE, timeout=1)
        print(f"Connected to {SERIAL_PORT} at {BAUD_RATE} baud.\n")
        time.sleep(2)  # Give FPGA time to stabilize/reset if needed
        return ser

    except serial.SerialException as e:
        print(f"Serial error: {e}")
        return None

def ByteSend(ser, byte, WAIT_ENTER = False, ASCII = False):
    # Send a character
    if ASCII: byte = byte.encode()
    else: byte = bytes([byte])

    if WAIT_ENTER: input(f"Ready to send the character {byte}, press Enter to send... ")
    else: print(f"Sending character {byte}")

    ser.write(byte)
    time.sleep(20e-6)

    # Wait for echo
    '''
    rx = ser.read(1)  # Read 1 byte
    if rx:
        if ASCII: print(f"Received: {rx.decode()}")
        else: print(f"Received: {rx.hex()}")
    else:
        print("No response received.")
    '''

def StringSend(ser, string, WAIT_ENTER = False, ASCII = False):
    # Send a string
    if WAIT_ENTER: input(f"Ready to send the string {string}, press Enter to send... ")
    else: print(f"Ready to send the character {string}")

    for char in string:
        byte = char.encode()
        ser.write(byte)
        print(f"Sent {char}")


    # Wait for echo
    string_size=  len(string)
    rx = ser.read( string_size )  # Read len bytes
    if rx:
        if ASCII: print(f"Received: {rx.decode()}")
        else: print(f"Received: {rx.hex()}")
    else:
        print("No response received.")






def UARTClose(ser):
    if ser and ser.is_open:
        ser.close()
        print("Serial port closed.")
    else:
        print("Serial port already closed or not initialized.")




if __name__ == "__main__":
    ser = UARTSetup()

    from ConvertImageToPixels import PixelGenerator
    from ExampleImagesProcess import fullTextForImage

    '''
    for val_color in [ int('11111100', 2), int('00000011', 2), int('00011100', 2)]:
        input("Y")
        for i in range( 76800//3 ):
            ByteSend(ser,val_color,WAIT_ENTER = False,ASCII = False)
            print(f"Sending pixel number {i} = {val_color}")
    '''


    for v in range(3):

        for image_name in ['image_banana','image_applepinklady', 'image_redpepper']:


            new_image_path = '/home/omermaruani/Desktop/example_images/example_images_3/'+image_name +'.png'
            rgb_8bit_data = PixelGenerator(new_image_path, 320, 240, contrast_factor= 1.5, brightness_factor = 1.2)
            print(len(rgb_8bit_data))

            input("Y")
            for i in range(len(rgb_8bit_data)):
                ByteSend(ser,rgb_8bit_data[i], WAIT_ENTER = False,ASCII = False)
                print(f"Sending pixel number {i} = {rgb_8bit_data[i]}")












    for i in range(10):
        pass
        ByteSend(ser,i,WAIT_ENTER = True,ASCII = False)

    '''
    ByteSend(ser, 0x05, WAIT_ENTER = True, ASCII= False)
    ByteSend(ser, 'A' , WAIT_ENTER = True, ASCII = True)
    StringSend(ser, 'ABC', WAIT_ENTER = True, ASCII= True)
    '''
    UARTClose(ser)
